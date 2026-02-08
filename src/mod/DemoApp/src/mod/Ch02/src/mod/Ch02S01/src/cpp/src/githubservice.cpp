#include "githubservice.hpp"
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkRequest>

GitHubService::GitHubService(QObject* const parent)
  : QObject{parent}
  , m_networkManager{new QNetworkAccessManager{this}}
{
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
GitHubService::fetchUserRepositories(const QString& username)
{
  if (this->m_isLoading || username.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});
  this->clearRepositories();

  const QString endpoint{QString{"users/%1/repos"}.arg(username)};
  const QUrl    url{
    QString{"https://api.github.com/%1?sort=updated&per_page=50"}.arg(endpoint)
  };

  QNetworkRequest request{url};
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setRawHeader("User-Agent", "GitHubClient-Qt-Modern");
  request.setRawHeader("Accept", "application/vnd.github.v3+json");

  if (!this->m_authToken.isEmpty())
  {
    request.setRawHeader(
      "Authorization", QString{"Bearer %1"}.arg(this->m_authToken).toUtf8()
    );
  }

  QNetworkReply* const reply{this->m_networkManager->get(request)};

  reply->setProperty("requestType", "userRepositories");

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onUserRepositoriesReceived
  );
  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::fetchAuthenticatedUserRepositories()
{
  if (this->m_isLoading)
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});
  this->clearRepositories();

  const QUrl url{QString{
    "https://api.github.com/user/repos?sort=updated&per_page=50&visibility=all"
  }};

  QNetworkRequest request{url};
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setRawHeader("User-Agent", "GitHubClient-Qt-Modern");
  request.setRawHeader("Accept", "application/vnd.github.v3+json");

  if (!this->m_authToken.isEmpty())
  {
    request.setRawHeader(
      "Authorization", QString{"Bearer %1"}.arg(this->m_authToken).toUtf8()
    );
  }

  QNetworkReply* const reply{this->m_networkManager->get(request)};
  reply->setProperty("requestType", "userRepositories");

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onUserRepositoriesReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::fetchRepository(const QString& owner, const QString& repo)
{
  if (this->m_isLoading || owner.isEmpty() || repo.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});

  const QUrl url{
    QString{"https://api.github.com/repos/%1/%2"}.arg(owner, repo)
  };
  QNetworkRequest request{url};

  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setRawHeader("User-Agent", "GitHubClient-Qt-Modern");
  request.setRawHeader("Accept", "application/vnd.github.v3+json");

  if (!this->m_authToken.isEmpty())
  {
    request.setRawHeader(
      "Authorization", QString{"Bearer %1"}.arg(this->m_authToken).toUtf8()
    );
  }

  QNetworkReply* reply{this->m_networkManager->get(request)};
  reply->setProperty("requestType", "singleRepository");

  this->connect(
    reply, &QNetworkReply::finished, this, &GitHubService::onRepositoryReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::searchRepositories(
  const QString& query, const QString& sort, const QString& order
)
{
  if (this->m_isLoading || query.isEmpty())
  {
    return;
  }

  this->setIsLoading(true);
  this->setErrorMessage(QString{});
  this->clearRepositories();

  QUrl url{QString{"https://api.github.com/search/"
                   "repositories?q=%1&sort=%2&order=%3&per_page=50"}
             .arg(query, sort, order)};

  QNetworkRequest request{url};
  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

  request.setRawHeader("User-Agent", "GitHubClient-Qt-Modern");
  request.setRawHeader("Accept", "application/vnd.github.v3+json");

  if (!this->m_authToken.isEmpty())
  {
    request.setRawHeader(
      "Authorization", QString{"Bearer %1"}.arg(this->m_authToken).toUtf8()
    );
  }

  QNetworkReply* const reply{this->m_networkManager->get(request)};
  reply->setProperty("requestType", "searchRepositories");

  this->connect(
    reply,
    &QNetworkReply::finished,
    this,
    &GitHubService::onSearchResultsReceived
  );

  this->connect(
    reply, &QNetworkReply::errorOccurred, this, &GitHubService::onRequestFailed
  );
}

void
GitHubService::clearRepositories()
{
  if (!this->m_repositories.isEmpty())
  {
    this->m_repositories.clear();
    emit this->repositoriesChanged();
  }
}

QVariant
GitHubService::parseRepositoryJson(const QJsonObject& json)
{
  QVariantMap repo;

  repo["id"]              = json["id"].toInt();
  repo["name"]            = json["name"].toString();
  repo["fullName"]        = json["full_name"].toString();
  repo["description"]     = json["description"].toString();
  repo["htmlUrl"]         = json["html_url"].toString();
  repo["language"]        = json["language"].toString();
  repo["stargazersCount"] = json["stargazers_count"].toInt();
  repo["forksCount"]      = json["forks_count"].toInt();
  repo["isPrivate"]       = json["private"].toBool();
  repo["updatedAt"] =
    QDateTime::fromString(json["updated_at"].toString(), Qt::ISODate);

  // Owner info
  QJsonObject owner{json["owner"].toObject()};
  QVariantMap ownerMap;
  ownerMap["id"]        = owner["id"].toInt();
  ownerMap["login"]     = owner["login"].toString();
  ownerMap["avatarUrl"] = owner["avatar_url"].toString();
  ownerMap["htmlUrl"]   = owner["html_type"].toString();
  ownerMap["type"]      = owner["type"].toString();
  repo["owner"]         = ownerMap;

  return repo;
}

void
GitHubService::onUserRepositoriesReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};

  if (!reply)
  {
    this->setIsLoading(false);
    this->setErrorMessage("Invalid response received");
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  QByteArray      data{reply->readAll()};
  QJsonParseError parseError;
  QJsonDocument   doc{QJsonDocument::fromJson(data, &parseError)};

  if (parseError.error != QJsonParseError::NoError)
  {
    this->setErrorMessage(
      QString{"JSON parsing error: %1"}.arg(parseError.errorString())
    );

    reply->deleteLater();
    return;
  }

  if (!doc.isArray())
  {
    this->setErrorMessage("Expected JSON array for repository list");
    reply->deleteLater();
    return;
  }

  QJsonArray   repositories{doc.array()};
  QVariantList repoList;

  for (const QJsonValue& value : repositories)
  {
    if (value.isObject())
    {
      repoList.append(this->parseRepositoryJson(value.toObject()));
    }
  }

  this->m_repositories = repoList;
  emit repositoriesChanged();
  reply->deleteLater();
}

void
GitHubService::onRepositoryReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};

  if (!reply)
  {
    this->setIsLoading(false);
    setErrorMessage("Invalid response received");
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  QByteArray      data{reply->readAll()};
  QJsonParseError parseError;
  QJsonDocument   doc{QJsonDocument::fromJson(data, &parseError)};

  if (parseError.error != QJsonParseError::NoError)
  {
    this->setErrorMessage(
      QString{"JSON parsing error %1"}.arg(parseError.errorString())
    );

    reply->deleteLater();
    return;
  }

  if (!doc.isObject())
  {
    this->setErrorMessage("Expected JSON object for repository");
    reply->deleteLater();
    return;
  }

  QVariant repository{this->parseRepositoryJson(doc.object())};
  emit this->repositoryFetched(repository);
  reply->deleteLater();
}

void
GitHubService::onSearchResultsReceived()
{
  QNetworkReply* const reply{qobject_cast<QNetworkReply*>(this->sender())};

  if (!reply)
  {
    this->setIsLoading(false);
    this->setErrorMessage("Invalid response received");
    return;
  }

  this->setIsLoading(false);

  if (reply->error() != QNetworkReply::NoError)
  {
    reply->deleteLater();
    return;
  }

  QByteArray      data{reply->readAll()};
  QJsonParseError parseError;
  QJsonDocument   doc{QJsonDocument::fromJson(data, &parseError)};

  if (parseError.error != QJsonParseError::NoError)
  {
    this->setErrorMessage(
      QString{"JSON parsing error: %1"}.arg(parseError.errorString())
    );
    reply->deleteLater();
    return;
  }

  if (!doc.isObject())
  {
    setErrorMessage("Expected JSON object for search results");
    reply->deleteLater();
    return;
  }

  QJsonObject  searchResults{doc.object()};
  QJsonArray   items{searchResults["items"].toArray()};
  QVariantList repoList;

  for (const QJsonValue& value : items)
  {
    if (value.isObject())
    {
      repoList.append(this->parseRepositoryJson(value.toObject()));
    }
  }

  this->m_repositories = repoList;
  emit this->repositoriesChanged();
  reply->deleteLater();
}

void
GitHubService::onRequestFailed(const QNetworkReply::NetworkError& error)
{
  QNetworkReply* reply{qobject_cast<QNetworkReply*>(this->sender())};

  this->setIsLoading(false);

  QString errorMsg;
  switch (error)
  {
  case QNetworkReply::AuthenticationRequiredError:
    errorMsg = "Authentication required. Please check your token.";
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
  default:
    errorMsg =
      QString{"Network error occured: %1"}.arg(static_cast<int>(error));
    break;
  }

  this->setErrorMessage(errorMsg);
  qWarning() << "GitHub API request failed:" << errorMsg;

  if (reply)
  {
    reply->deleteLater();
  }
}