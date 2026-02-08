#include "userlistmodel.hpp"

UserListModel::UserListModel(QObject* parent)
  : QAbstractListModel{parent}
{
  this->connect(
    this->m_service,
    &GitHubService::userSearchResultsReady,
    this,
    &UserListModel::onSearchResultsReady
  );

  // Without this a failed request leaves isLoadingPage stuck on true
  this->connect(
    this->m_service,
    &GitHubService::requestFailed,
    this,
    [this]()
    {
      this->setIsLoadingPage(false);
    }
  );

  this->m_service->setCache(CacheManager::create(nullptr, nullptr));
}

int
UserListModel::rowCount(const QModelIndex& parent) const
{
  if (parent.isValid())
  {
    return 0;
  }

  return this->m_users.size();
}

QVariant
UserListModel::data(const QModelIndex& index, int role) const
{
  if (
    !index.isValid() || index.row() < 0 || index.row() >= this->m_users.size()
  )
  {
    return {};
  }

  const User* const user{this->m_users.at(index.row())};

  switch (static_cast<UserListModel::Roles>(role))
  {
  case UserListModel::Roles::IdRole:
    return user->id();
  case UserListModel::Roles::LoginRole:
    return user->login();
  case UserListModel::Roles::AvatarUrlRole:
    return user->avatarUrl();
  case UserListModel::Roles::HtmlUrlRole:
    return user->htmlUrl();
  case UserListModel::Roles::TypeRole:
    return user->type();
  default:
    return {};
  }
}

QHash<int, QByteArray>
UserListModel::roleNames() const
{
  return {
    {       static_cast<int>(UserListModel::Roles::IdRole),    "userId"},
    {    static_cast<int>(UserListModel::Roles::LoginRole),     "login"},
    {static_cast<int>(UserListModel::Roles::AvatarUrlRole), "avatarUrl"},
    {  static_cast<int>(UserListModel::Roles::HtmlUrlRole),   "htmlUrl"},
    {     static_cast<int>(UserListModel::Roles::TypeRole),  "userType"}
  };
}

void
UserListModel::search(const QString& query)
{
  if (query.isEmpty() || this->m_isLoadingPage)
  {
    return;
  }

  this->m_currentQuery = query;
  this->m_currentPage  = 1;
  emit this->currentPageChanged();
  this->setIsLoadingPage(true);
  this->m_service->searchUsers(query, this->m_currentPage, m_perPage);
}

void
UserListModel::loadMore()
{
  if (this->m_isLoadingPage || m_currentQuery.isEmpty() || !this->hasMore())
  {
    return;
  }

  this->setIsLoadingPage(true);

  const int nextPage{this->m_currentPage + 1};

  this->m_service->searchUsers(this->m_currentQuery, nextPage, this->m_perPage);
}

void
UserListModel::onSearchResultsReady(
  const QList<User*>& users, const int& page, const int& totalCount
)
{
  this->setIsLoadingPage(false);
  this->setTotalCount(totalCount);

  if (page == 1)
  {
    this->resetWith(users);
  }
  else
  {
    this->appendBatch(users);
  }

  this->m_currentPage = page;
  emit this->currentPageChanged();
  emit this->hasMoreChanged();
}

void
UserListModel::setIsLoadingPage(const bool& loading)
{
  if (this->m_isLoadingPage != loading)
  {
    this->m_isLoadingPage = loading;
    emit this->isLoadingPageChanged();
  }
}

void
UserListModel::setTotalCount(const int& total)
{
  if (this->m_totalCount != total)
  {
    this->m_totalCount = total;
    emit this->totalCountChanged();
  }
}

void
UserListModel::resetWith(const QList<User*>& batch)
{
  this->beginResetModel();
  qDeleteAll(this->m_users);
  this->m_users.clear();
  this->m_users = batch;

  for (User* const u : this->m_users)
  {
    u->setParent(this);
  }

  this->endResetModel();
  emit this->countChanged();
}

void
UserListModel::appendBatch(const QList<User*>& batch)
{
  if (batch.isEmpty())
  {
    return;
  }

  const auto first{this->m_users.size()};
  const auto last{first + batch.size() - 1};

  this->beginInsertRows({}, first, last);

  for (User* const u : batch)
  {
    u->setParent(this);
    this->m_users.append(u);
  }

  this->endInsertRows();
  emit this->countChanged();
}