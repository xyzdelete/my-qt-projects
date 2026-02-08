#include "githubservice.hpp"

namespace
{
// Builds a GitHub search URL. The search text is percent-encoded so characters
// such as '&', '#', '+' or spaces cannot corrupt the query string.
// Built with plain concatenation on purpose: QString::arg() would re-scan the
// already substituted text and mangle sequences such as "%3A".
QUrl
makeSearchUrl(
  const QString& endpoint,
  const QString& query,
  const QString& sort,
  const QString& order,
  const int&     perPage,
  const int&     page
)
{
  QUrl url{
    QString{QStringLiteral("https://api.github.com/search/") + endpoint}
  };

  QString queryString{QStringLiteral("q=")};
  queryString += QString::fromLatin1(QUrl::toPercentEncoding(query));
  queryString += QStringLiteral("&sort=") + sort;
  queryString += QStringLiteral("&order=") + order;
  queryString += QStringLiteral("&per_page=") + QString::number(perPage);
  queryString += QStringLiteral("&page=") + QString::number(page);

  url.setQuery(queryString, QUrl::StrictMode);
  return url;
}
} // namespace

GitHubService::GitHubService(QObject* parent)
  : QObject{parent}
{
}

void
GitHubService::beginParse()
{
  if (this->m_inflightParses++ == 0)
  {
    emit this->isParsingChanged();
  }
}

void
GitHubService::endParse()
{
  if (--this->m_inflightParses == 0)
  {
    emit this->isParsingChanged();
  }
}

void
GitHubService::setCache(CacheManager* cache)
{
  if (this->m_cache == cache)
  {
    return;
  }
  if (this->m_cache)
  {
    this->m_cache->disconnect(this);
  }

  this->m_cache = cache;

  if (m_cache)
  {
    this->connect(
      this->m_cache, &CacheManager::loaded, this, &GitHubService::onCacheLoaded
    );
  }
}

QList<Repository*>
GitHubService::parseSearchItems(
  const QByteArray& body, int* totalCountOut
) const
{
  QJsonParseError    parseError{};
  QJsonDocument      doc{QJsonDocument::fromJson(body, &parseError)};
  QList<Repository*> items{};
  if (parseError.error != QJsonParseError::NoError || !doc.isObject())
  {
    return items;
  }

  const QJsonObject root{doc.object()};

  if (totalCountOut)
  {
    *totalCountOut = root.value("total_count").toInt();
  }

  // Not `arr{...}`: braces would pick QJsonArray's initializer-list constructor
  // and wrap the array in another array with a single element
  const QJsonArray arr = root.value("items").toArray();

  items.reserve(arr.size());

  for (const QJsonValue& v : arr)
  {
    if (v.isObject())
    {
      items.append(Repository::fromJson(v.toObject(), nullptr));
    }
  }

  return items;
}

void
GitHubService::parseBytesAsync(
  const QByteArray&                                   body,
  std::function<void(const QList<Repository*>&, int)> onParsed
)
{
  this->beginParse();
  auto* const watcher{new QFutureWatcher<QList<Repository*>>{this}};

  auto* const total{new int{0}};

  this->connect(
    watcher,
    &QFutureWatcher<QList<Repository*>>::finished,
    this,
    [this, watcher, total, onParsed]()
    {
      const QList<Repository*> repos{watcher->result()};
      const int                totalCount{*total};
      delete total;
      watcher->deleteLater();
      this->endParse();
      onParsed(repos, totalCount);
    }
  );

  QThread*                    guiThread{this->thread()};
  QFuture<QList<Repository*>> future{QtConcurrent::run(
    [body, total, guiThread]()
    {
      QElapsedTimer timer{};
      timer.start();
      QList<Repository*> repos{Repository::listFromJsonBytes(body, total)};
      for (Repository* const r : repos)
      {
        r->moveToThread(guiThread);
      }
      qDebug() << "[parse] off-GUI-thread parse of" << body.size() << "bytes->"
               << repos.size() << "repos in" << timer.elapsed() << "ms";
      return repos;
    }
  )};
  watcher->setFuture(future);
}

void
GitHubService::onCacheLoaded(
  const QString& key, const QByteArray& body, const bool& found
)
{
  auto it{this->m_pendingByKey.find(key)};

  // Not pending any more: the network answer already arrived and removed it,
  // so this cache read is stale and must be dropped.
  if (it == this->m_pendingByKey.end())
  {
    return;
  }

  const PendingRequest req{it.value()};
  this->m_pendingByKey.erase(it);

  if (!found || body.isEmpty())
  {
    return;
  }

  if (req.kind == GitHubService::RequestKind::Page)
  {
    int                total = 0;
    QList<Repository*> items{this->parseSearchItems(body, &total)};

    if (!items.isEmpty() || total > 0)
    {
      emit this->cachedPageReady(items, req.page, total);
    }
    else
    {
      qDeleteAll(items);
    }
  }
  else
  {
    QList<Repository*> items{this->parseSearchItems(body)};

    if (!items.isEmpty())
    {
      emit this->cachedCursorReady(items, QString{}, req.isFirstPage);
    }
    else
    {
      qDeleteAll(items);
    }
  }
}

void
GitHubService::setAuthToken(const QString& token)
{
  if (this->m_authToken != token)
  {
    this->m_authToken = token;
    emit this->authTokenChanged();
  }
}

void
GitHubService::setIsLoading(bool loading)
{
  if (this->m_isLoading != loading)
  {
    this->m_isLoading = loading;
    emit this->isLoadingChanged();
  }
}

void
GitHubService::setErrorMessage(const QString& message)
{
  if (this->m_errorMessage != message)
  {
    this->m_errorMessage = message;
    emit this->errorMessageChanged();
  }
}

void
GitHubService::searchRepositoriesPage(
  const QString& query,
  const int&     page,
  const int&     perPage,
  const QString& sort,
  const QString& order
)
{
  if (this->m_isLoading || query.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});

  const QUrl url{makeSearchUrl(
    QStringLiteral("repositories"), query, sort, order, perPage, page
  )};

  // Cache lookup in parallel with the network request.
  // Only page 1 is looked up: it is used as a first paint of a fresh search.
  // Later pages would be appended twice (cache, then network).
  if (this->m_cache && page == 1)
  {
    const QString key{url.toString()};

    this->m_pendingByKey.insert(
      key, PendingRequest{GitHubService::RequestKind::Page, page, false}
    );

    this->m_cache->requestLoad(key);
  }

  QNetworkReply* const reply{
    this->m_networkManager->get(this->buildRequest(url))
  };
  reply->setProperty("requestType", "searchRepositoriesPage");
  reply->setProperty("page", page);

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onSearchResultsPageReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::searchRepositoriesCursor(
  const QString& query,
  const int&     perPage,
  const QString& sort,
  const QString& order
)
{
  if (this->m_isLoading || query.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});

  const QUrl url{makeSearchUrl(
    QStringLiteral("repositories"), query, sort, order, perPage, 1
  )};

  if (this->m_cache)
  {
    const QString key{url.toString()};
    this->m_pendingByKey.insert(
      key, PendingRequest{GitHubService::RequestKind::Cursor, 0, true}
    );
    this->m_cache->requestLoad(key);
  }

  QNetworkReply* const reply{
    this->m_networkManager->get(this->buildRequest(url))
  };
  reply->setProperty("requestType", "searchRepositoriesCursor");
  reply->setProperty("isFirstPage", true);

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onSearchResultsCursorReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::fetchByUrl(const QUrl& url)
{
  if (this->m_isLoading || !url.isValid())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});

  // No cache lookup here: these are "load more" pages that get appended, a
  // cached copy would be appended once from the cache and once from the
  // network.

  QNetworkReply* const reply{
    this->m_networkManager->get(this->buildRequest(url))
  };
  reply->setProperty("requestType", "searchRepositoriesCursor");
  reply->setProperty("isFirstPage", false);

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onSearchResultsCursorReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

QString
GitHubService::parseNextLink(const QByteArray& linkHeader)
{
  // Format: <url>; rel="next", <url>; rel="last", ...
  const QString&     header{QString::fromUtf8(linkHeader)};
  const QStringList& parts{header.split(",", Qt::SkipEmptyParts)};
  for (const QString& part : parts)
  {
    const auto& relIdx{part.indexOf(QStringLiteral("rel=\"next\""))};
    if (relIdx < 0)
    {
      continue;
    }

    const auto& lt{part.indexOf("<")};
    const auto& gt{part.indexOf(">")};
    if (lt >= 0 && gt > lt)
    {
      return part.mid(lt + 1, gt - lt - 1);
    }
  }

  return {};
}

void
GitHubService::onSearchResultsPageReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};

  if (!reply)
  {
    this->setIsLoading(false);
    this->setErrorMessage("Invalid response received");
    emit this->requestFailed();
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  const int        page{reply->property("page").toInt()};
  const QString    cacheKey{reply->url().toString()};
  const QByteArray data{reply->readAll()};
  reply->deleteLater();

  // The network answer is the truth: a cache read that is still in flight for
  // this key is stale now and gets dropped in onCacheLoaded().
  this->m_pendingByKey.remove(cacheKey);

  if (this->m_cache && !data.isEmpty())
  {
    this->m_cache->requestSave(cacheKey, data);
  }

  this->parseBytesAsync(
    data,
    [this, page](const QList<Repository*>& repos, int totalCount)
    {
      if (repos.isEmpty() && totalCount == 0)
      {
        this->setErrorMessage("JSON parse error on paged search response");
        emit this->requestFailed();
        return;
      }

      emit this->searchResultsPageReady(repos, page, totalCount);
    }
  );
}

void
GitHubService::onSearchResultsCursorReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};

  if (!reply)
  {
    this->setIsLoading(false);
    this->setErrorMessage("Invalid response received");
    emit this->requestFailed();
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  const bool       isFirstPage{reply->property("isFirstPage").toBool()};
  const QByteArray linkHeader{reply->rawHeader("Link")};
  const QString    nextUrl{this->parseNextLink(linkHeader)};
  const QString    cacheKey{reply->url().toString()};
  const QByteArray data{reply->readAll()};
  reply->deleteLater();

  this->m_pendingByKey.remove(cacheKey);

  // Only the first page is cached, it is the only one served from the cache.
  if (this->m_cache && isFirstPage && !data.isEmpty())
  {
    this->m_cache->requestSave(cacheKey, data);
  }

  this->parseBytesAsync(
    data,
    [this,
     nextUrl,
     isFirstPage](const QList<Repository*>& repos, int totalCount)
    {
      Q_UNUSED(totalCount);
      emit this->searchResultsCursorReady(repos, nextUrl, isFirstPage);
    }
  );
}

void
GitHubService::onRequestFailed(const QNetworkReply::NetworkError& error)
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};

  this->setIsLoading(false);

  QString errorMsg;
  switch (error)
  {
  case QNetworkReply::AuthenticationRequiredError:
    errorMsg = "Authentication required. Please check your token.";
    break;
  case QNetworkReply::ContentAccessDenied:
    // GitHub answers HTTP 403 when the search rate limit is exhausted
    errorMsg = "Access denied or GitHub rate limit reached. Add a token or "
               "wait a minute and try again.";
    break;
  case QNetworkReply::ContentNotFoundError:
    errorMsg = "Repository or user not found.";
    break;
  case QNetworkReply::TimeoutError:
    errorMsg = "Request timed out. Please try again.";
    break;
  case QNetworkReply::HostNotFoundError:
    errorMsg = "Unable to connect to GitHub API.";
    break;
  case QNetworkReply::UnknownNetworkError:
    // In a browser a blocked or CORS-rejected request is reported like this
    errorMsg = "Network request failed. Check your connection, the browser "
               "console for blocked requests, or the GitHub rate limit.";
    break;
  default:
    errorMsg =
      QString{"Network error occurred: %1"}.arg(static_cast<int>(error));
    break;
  }

  this->setErrorMessage(errorMsg);
  emit this->requestFailed();
  qWarning() << "GitHub API request failed:" << errorMsg;

  if (reply)
  {
    reply->deleteLater();
  }
}

QNetworkRequest
GitHubService::buildRequest(const QUrl& url) const
{
  QNetworkRequest request{url};

  // Browsers forbid scripts to set the User-Agent header ("Refused to set
  // unsafe header"), they always send their own. GitHub requires one on the
  // desktop and Android, so it is only skipped on WebAssembly.
  // No Content-Type either: these are GET requests without a body, and in a
  // browser it would force an extra CORS preflight for every request.
#ifndef Q_OS_WASM
  request.setRawHeader("User-Agent", "RepositoryExplorer");
#endif
  request.setRawHeader("Accept", "application/vnd.github+json");
  if (!this->m_authToken.isEmpty())
  {
    request.setRawHeader(
      "Authorization", QString{"Bearer %1"}.arg(this->m_authToken).toUtf8()
    );
  }
  return request;
}

void
GitHubService::searchIssues(
  const QString& query,
  const int&     page,
  const int&     perPage,
  const QString& sort,
  const QString& order
)
{
  if (this->m_isLoading || query.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  setErrorMessage(QString{});

  const QUrl url{makeSearchUrl(
    QStringLiteral("issues"),
    query + QStringLiteral(" is:issue"),
    sort,
    order,
    perPage,
    page
  )};

  QNetworkReply* const reply{
    this->m_networkManager->get(this->buildRequest(url))
  };
  reply->setProperty("page", page);

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onIssueSearchResultsReceived
  );
  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::onIssueSearchResultsReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};
  if (!reply)
  {
    this->setIsLoading(false);
    this->setErrorMessage("Invalid response received");
    emit this->requestFailed();
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  const int        page{reply->property("page").toInt()};
  const QByteArray data{reply->readAll()};
  reply->deleteLater();

  int                 total{0};
  const QList<Issue*> issues{Issue::listFromJsonBytes(data, &total)};
  if (issues.isEmpty() && total == 0 && !data.isEmpty())
  {
    this->setErrorMessage("Failed to parse issue search response");
    emit this->requestFailed();
    return;
  }

  emit this->issueSearchResultsReady(issues, page, total);
}

void
GitHubService::searchUsers(
  const QString& query,
  const int&     page,
  const int&     perPage,
  const QString& sort,
  const QString& order
)
{
  if (this->m_isLoading || query.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});

  const QUrl url{
    makeSearchUrl(QStringLiteral("users"), query, sort, order, perPage, page)
  };

  QNetworkReply* const reply{
    this->m_networkManager->get(this->buildRequest(url))
  };

  reply->setProperty("page", page);

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onUserSearchResultsReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::onUserSearchResultsReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};
  if (!reply)
  {
    this->setIsLoading(false);
    this->setErrorMessage("Invalid response received");
    emit this->requestFailed();
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  const int        page{reply->property("page").toInt()};
  const QByteArray data{reply->readAll()};
  reply->deleteLater();

  QJsonParseError     err{};
  const QJsonDocument doc{QJsonDocument::fromJson(data, &err)};
  if (err.error != QJsonParseError::NoError || !doc.isObject())
  {
    this->setErrorMessage("Failed to parse user search response");
    emit this->requestFailed();
    return;
  }

  const QJsonObject root{doc.object()};
  const int         total{root.value("total_count").toInt()};
  // Not `items{...}`, see parseSearchItems()
  const QJsonArray items = root.value("items").toArray();

  QList<User*> users{};
  users.reserve(items.size());
  for (const QJsonValue& v : items)
  {
    if (v.isObject())
    {
      users.append(User::fromJson(v.toObject(), nullptr));
    }
  }

  emit this->userSearchResultsReady(users, page, total);
}