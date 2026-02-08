#include "repositorylistmodel.hpp"

RepositoryListModel::RepositoryListModel(QObject* parent)
  : QAbstractListModel{parent}
{
  this->connect(
    this->m_service,
    &GitHubService::searchResultsPageReady,
    this,
    &RepositoryListModel::onSearchResultsPageReady
  );

  this->connect(
    this->m_service,
    &GitHubService::searchResultsCursorReady,
    this,
    &RepositoryListModel::onSearchResultsCursorReady
  );

  this->connect(
    this->m_service,
    &GitHubService::requestFailed,
    this,
    [this]()
    {
      this->setIsLoadingPage(false);
      // A failed refresh must not leave the flag set, otherwise auto refresh
      // stops for good and the next search is mistaken for a refresh.
      this->m_isRefreshing = false;
    }
  );

  this->m_service->setCache(CacheManager::create(nullptr, nullptr));

  // Cached results get their own slots: they are only a first paint and must
  // not be handled like a finished network request.
  this->connect(
    this->m_service,
    &GitHubService::cachedPageReady,
    this,
    &RepositoryListModel::onCachedPageReady
  );

  this->connect(
    this->m_service,
    &GitHubService::cachedCursorReady,
    this,
    &RepositoryListModel::onCachedCursorReady
  );

  this->m_refreshTimer->setSingleShot(false);
  this->connect(
    this->m_refreshTimer,
    &QTimer::timeout,
    this,
    &RepositoryListModel::onRefreshTick
  );
}

bool
RepositoryListModel::hasMore() const
{
  if (this->m_useCursor)
  {
    return !this->m_nextUrl.isEmpty();
  }
  return this->m_repos.size() < this->m_totalCount;
}

void
RepositoryListModel::setUseCursor(const bool& useCursor)
{
  if (this->m_useCursor != useCursor)
  {
    this->m_useCursor = useCursor;

    if (useCursor)
    {
      this->setAutoRefresh(false);
    }

    // Clear all results and reset every mode specific counter
    this->resetWith({});
    this->m_currentQuery.clear();
    this->m_currentPage = 0;
    emit this->currentPageChanged();
    this->setTotalCount(0);
    this->setNextUrl({});

    emit this->useCursorChanged();
    emit this->hasMoreChanged();
  }
}

void
RepositoryListModel::setAutoRefresh(const bool& autoRefresh)
{
  const bool shouldAutoRefresh{autoRefresh && !this->m_useCursor};
  if (this->m_autoRefresh == shouldAutoRefresh)
  {
    return;
  }

  this->m_autoRefresh = shouldAutoRefresh;
  emit this->autoRefreshChanged();

  if (
    this->m_autoRefresh && !this->m_useCursor && !this->m_currentQuery.isEmpty()
  )
  {
    this->m_refreshTimer->start(this->m_refreshIntervalMs);
  }
  else
  {
    this->m_refreshTimer->stop();
  }
}

void
RepositoryListModel::setRefreshIntervalMs(const int& intervalMs)
{
  const int clamped{qMax(intervalMs, 10000)};
  if (this->m_refreshIntervalMs == clamped)
  {
    return;
  }

  this->m_refreshIntervalMs = clamped;

  emit this->refreshIntervalMsChanged();
  if (this->m_refreshTimer->isActive())
  {
    this->m_refreshTimer->setInterval(this->m_refreshIntervalMs);
  }
}

void
RepositoryListModel::setSortField(const QString& field)
{
  const QString normalized{
    (field == QLatin1String("updated")) ? field : QLatin1String("stars")
  };

  if (this->m_sortField == normalized)
  {
    return;
  }

  this->m_sortField = normalized;
  emit this->sortFieldChanged();
}

void
RepositoryListModel::onRefreshTick()
{
  if (this->m_currentQuery.isEmpty())
  {
    return;
  }
  if (this->m_isLoadingPage)
  {
    return;
  }
  if (this->m_useCursor)
  {
    return;
  }
  if (this->m_isRefreshing)
  {
    return;
  }
  // The service silently ignores a request while it is loading; do not set
  // the refreshing flag for a request that will never be sent.
  if (this->m_service->isLoading())
  {
    return;
  }

  this->m_isRefreshing  = true;
  this->m_lastRefreshAt = QDateTime::currentDateTime();
  emit this->lastRefreshAtChanged();

  this->m_service->searchRepositoriesPage(
    this->m_currentQuery, 1, this->m_perPage, this->m_sortField, "desc"
  );
}

void
RepositoryListModel::setPerPage(const int& perPage)
{
  if (this->m_perPage != perPage && perPage > 0 && perPage < 101)
  {
    this->m_perPage = perPage;
    emit this->perPageChanged();
  }
}

void
RepositoryListModel::setIsLoadingPage(const bool& loading)
{
  if (this->m_isLoadingPage != loading)
  {
    this->m_isLoadingPage = loading;
    emit this->isLoadingPageChanged();
  }
}

void
RepositoryListModel::setTotalCount(const int& total)
{
  if (this->m_totalCount != total)
  {
    this->m_totalCount = total;
    emit this->totalCountChanged();
  }
}

void
RepositoryListModel::setNextUrl(const QString& url)
{
  if (this->m_nextUrl != url)
  {
    this->m_nextUrl = url;
    emit this->nextUrlChanged();
  }
}

int
RepositoryListModel::rowCount(const QModelIndex& parent) const
{
  if (parent.isValid())
  {
    return 0;
  }

  return this->m_repos.size();
}

QVariant
RepositoryListModel::data(const QModelIndex& index, int role) const
{
  if (
    !index.isValid() || index.row() < 0 || index.row() >= this->m_repos.size()
  )
  {
    return {};
  }

  const Repository* repo{this->m_repos.at(index.row())};

  switch (static_cast<RepositoryListModel::Roles>(role))
  {
  case RepositoryListModel::Roles::IdRole:
    return repo->id();
  case RepositoryListModel::Roles::NameRole:
    return repo->name();
  case RepositoryListModel::Roles::FullNameRole:
    return repo->fullName();
  case RepositoryListModel::Roles::DescriptionRole:
    return repo->description();
  case RepositoryListModel::Roles::StarsRole:
    return repo->stargazersCount();
  case RepositoryListModel::Roles::ForksRole:
    return repo->forksCount();
  case RepositoryListModel::Roles::LanguageRole:
    return repo->language();
  case RepositoryListModel::Roles::UrlRole:
    return repo->htmlUrl();
  case RepositoryListModel::Roles::UpdatedAtRole:
    return repo->updatedAt();
  case RepositoryListModel::Roles::IsPrivateRole:
    return repo->isPrivate();
  default:
    return {};
  }
}

QHash<int, QByteArray>
RepositoryListModel::roleNames() const
{
  QHash<int, QByteArray> hashMap{
    {         static_cast<int>(RepositoryListModel::Roles::IdRole),"repoId"                                                                   },
    {       static_cast<int>(RepositoryListModel::Roles::NameRole),       "name"},
    {   static_cast<int>(RepositoryListModel::Roles::FullNameRole),   "fullName"},
    {static_cast<int>(RepositoryListModel::Roles::DescriptionRole),
     "description"                                                              },
    {      static_cast<int>(RepositoryListModel::Roles::StarsRole),
     "stargazersCount"                                                          },
    {      static_cast<int>(RepositoryListModel::Roles::ForksRole), "forksCount"},
    {   static_cast<int>(RepositoryListModel::Roles::LanguageRole),   "language"},
    {        static_cast<int>(RepositoryListModel::Roles::UrlRole),    "htmlUrl"},
    {  static_cast<int>(RepositoryListModel::Roles::UpdatedAtRole),  "updatedAt"},
    {  static_cast<int>(RepositoryListModel::Roles::IsPrivateRole),  "isPrivate"}
  };

  return hashMap;
}

void
RepositoryListModel::search(const QString& query)
{
  if (query.isEmpty() || this->m_isLoadingPage)
  {
    return;
  }

  this->m_refreshTimer->stop();
  this->m_isRefreshing = false;

  this->m_currentQuery = query;
  this->m_currentPage  = 1;
  this->setNextUrl({});
  emit this->currentPageChanged();

  this->setIsLoadingPage(true);
  if (this->m_useCursor)
  {
    this->m_service->searchRepositoriesCursor(
      query, this->m_perPage, this->m_sortField, "desc"
    );
  }
  else
  {
    this->m_service->searchRepositoriesPage(
      query, this->m_currentPage, this->m_perPage, this->m_sortField, "desc"
    );
  }
}

void
RepositoryListModel::loadMore()
{
  if (
    this->m_isLoadingPage || this->m_currentQuery.isEmpty() ||
    !this->hasMore() || this->m_useCursor
  )
  {
    return;
  }

  this->setIsLoadingPage(true);
  const int& nextPage{this->m_currentPage + 1};
  this->m_service->searchRepositoriesPage(
    this->m_currentQuery, nextPage, this->m_perPage, this->m_sortField, "desc"
  );
}

void
RepositoryListModel::fetchNextPage()
{
  if (this->m_isLoadingPage || !this->m_useCursor || this->m_nextUrl.isEmpty())
  {
    return;
  }

  this->setIsLoadingPage(true);
  this->m_service->fetchByUrl(QUrl{this->m_nextUrl});
}

void
RepositoryListModel::onSearchResultsPageReady(
  const QList<Repository*>& repositories, const int& page, const int& totalCount
)
{
  if (this->m_isRefreshing && page == 1)
  {
    this->applyDiff(repositories);
    this->setTotalCount(totalCount);
    this->m_isRefreshing = false;
    return;
  }

  this->setIsLoadingPage(false);
  this->setTotalCount(totalCount);

  if (page == 1)
  {
    this->resetWith(repositories);
    this->m_currentPage = 1;
  }
  else
  {
    this->appendBatch(repositories);
    this->m_currentPage = page;
  }

  emit this->currentPageChanged();
  emit this->hasMoreChanged();

  // Start the refresh timer after data lands
  // Not when the search button clicked
  if (this->m_autoRefresh && !this->m_useCursor && !m_currentQuery.isEmpty())
  {
    this->m_refreshTimer->start(this->m_refreshIntervalMs);
  }
}

void
RepositoryListModel::onSearchResultsCursorReady(
  const QList<Repository*>& repositories,
  const QString&            nextUrl,
  const bool&               isFirstPage
)
{
  this->setIsLoadingPage(false);
  this->setNextUrl(nextUrl);

  if (isFirstPage)
  {
    this->resetWith(repositories);
  }
  else
  {
    this->appendBatch(repositories);
  }

  emit this->hasMoreChanged();
}

void
RepositoryListModel::onCachedPageReady(
  const QList<Repository*>& repositories, const int& page, const int& totalCount
)
{
  // Cache is only a first paint of page 1 of a fresh search. Ignore it when
  // refreshing, for later pages, or when the network already answered.
  if (this->m_isRefreshing || page != 1 || !this->m_isLoadingPage)
  {
    qDeleteAll(repositories);
    return;
  }

  this->setTotalCount(totalCount);
  this->resetWith(repositories);
  this->m_currentPage = 1;

  emit this->currentPageChanged();
  emit this->hasMoreChanged();
}

void
RepositoryListModel::onCachedCursorReady(
  const QList<Repository*>& repositories,
  const QString&            nextUrl,
  const bool&               isFirstPage
)
{
  Q_UNUSED(nextUrl);

  if (!isFirstPage || !this->m_useCursor || !this->m_isLoadingPage)
  {
    qDeleteAll(repositories);
    return;
  }

  // Leave nextUrl and the loading flag alone, the network answer sets both.
  this->resetWith(repositories);
}

void
RepositoryListModel::resetWith(const QList<Repository*>& batch)
{
  this->beginResetModel();
  qDeleteAll(this->m_repos);
  this->m_repos.clear();
  this->m_repos = batch;
  for (Repository* r : this->m_repos)
  {
    r->setParent(this);
  }
  this->endResetModel();
  emit this->countChanged();
}

void
RepositoryListModel::appendBatch(const QList<Repository*>& batch)
{
  if (batch.isEmpty())
  {
    return;
  }

  const auto& first{this->m_repos.size()};
  const auto& last{first + batch.size() - 1};

  this->beginInsertRows({}, first, last);
  for (Repository* r : batch)
  {
    r->setParent(this);
    this->m_repos.append(r);
  }
  this->endInsertRows();
  emit this->countChanged();
}

void
RepositoryListModel::applyDiff(const QList<Repository*>& incoming)
{
  // Build current row index (repo id -> row number)
  QHash<int, int> rowById{};
  rowById.reserve(this->m_repos.size());
  for (auto i{0}; i < this->m_repos.size(); ++i)
  {
    rowById.insert(this->m_repos.at(i)->id(), i);
  }

  // Build incoming lookup (repo id -> object) and membership set
  QHash<int, Repository*> incomingById{};
  QSet<int>               incomingIds{};
  incomingById.reserve(incoming.size());
  incomingIds.reserve(incoming.size());
  for (Repository* const r : incoming)
  {
    incomingById.insert(r->id(), r);
    incomingIds.insert(r->id());
  }

  // Pass 1: remove rows absent from incoming (backwards keeps indices valid)
  for (auto i{m_repos.size() - 1}; i >= 0; --i)
  {
    if (!incomingIds.contains(this->m_repos.at(i)->id()))
    {
      this->beginRemoveRows({}, i, i);
      delete m_repos.at(i);
      this->m_repos.removeAt(i);
      this->endRemoveRows();
    }
  }

  // Rebuild the row index after removals
  rowById.clear();
  for (auto i{0}; i < this->m_repos.size(); ++i)
  {
    rowById.insert(this->m_repos.at(i)->id(), i);
  }

  // Pass 2: update mutable fields for surviving rows
  for (auto i{0}; i < this->m_repos.size(); ++i)
  {
    Repository* const existing{this->m_repos.at(i)};
    Repository* const updated{incomingById.value(existing->id(), nullptr)};
    if (!updated)
    {
      continue;
    }

    QVector<int> changedRoles{};
    if (existing->stargazersCount() != updated->stargazersCount())
    {
      existing->setStargazersCount(updated->stargazersCount());
      changedRoles.append(
        static_cast<int>(RepositoryListModel::Roles::StarsRole)
      );
    }
    if (existing->forksCount() != updated->forksCount())
    {
      existing->setForksCount(updated->forksCount());
      changedRoles.append(
        static_cast<int>(RepositoryListModel::Roles::ForksRole)
      );
    }
    if (existing->description() != updated->description())
    {
      existing->setDescription(updated->description());
      changedRoles.append(
        static_cast<int>(RepositoryListModel::Roles::DescriptionRole)
      );
    }
    if (existing->language() != updated->language())
    {
      existing->setLanguage(updated->language());
      changedRoles.append(
        static_cast<int>(RepositoryListModel::Roles::LanguageRole)
      );
    }
    if (!changedRoles.isEmpty())
    {
      emit this->dataChanged(this->index(i), this->index(i), changedRoles);
    }
    // This incoming object served its purpose; delete it.
    delete updated;
    incomingById.remove(existing->id());
  }

  // Pass 3: collect new items and prepend them in one batch
  QList<Repository*> toPrepend{};
  for (Repository* const r : incoming)
  {
    if (incomingById.contains(r->id()))
    {
      toPrepend.append(r);
    }
  }

  if (!toPrepend.isEmpty())
  {
    this->beginInsertRows({}, 0, toPrepend.size() - 1);
    for (auto i{toPrepend.size() - 1}; i >= 0; --i)
    {
      Repository* const r{toPrepend.at(i)};
      r->setParent(this);
      this->m_repos.prepend(r);
    }
    this->endInsertRows();
  }

  if (this->m_repos.size() != rowById.size())
  {
    emit this->countChanged();
  }
}