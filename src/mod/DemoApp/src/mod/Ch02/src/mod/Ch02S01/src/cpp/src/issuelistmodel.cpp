#include "issuelistmodel.hpp"

IssueListModel::IssueListModel(QObject* parent)
  : QAbstractListModel{parent}
{
  this->connect(
    this->m_service,
    &GitHubService::issueSearchResultsReady,
    this,
    &IssueListModel::onSearchResultsReady
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
IssueListModel::rowCount(const QModelIndex& parent) const
{
  if (parent.isValid())
  {
    return 0;
  }

  return this->m_issues.size();
}

QVariant
IssueListModel::data(const QModelIndex& index, int role) const
{
  if (!index.isValid() || index.row() < 0 || index.row() >= m_issues.size())
  {
    return {};
  }

  const Issue* const issue{this->m_issues.at(index.row())};

  switch (static_cast<IssueListModel::Roles>(role))
  {
  case IssueListModel::Roles::IdRole:
    return issue->id();
  case IssueListModel::Roles::NumberRole:
    return issue->number();
  case IssueListModel::Roles::TitleRole:
    return issue->title();
  case IssueListModel::Roles::IssueStateRole:
    return issue->state();
  case IssueListModel::Roles::BodyRole:
    return issue->body();
  case IssueListModel::Roles::HtmlUrlRole:
    return issue->htmlUrl();
  case IssueListModel::Roles::RepoFullNameRole:
    return issue->repoFullName();
  case IssueListModel::Roles::CommentsCountRole:
    return issue->commentsCount();
  case IssueListModel::Roles::UserLoginRole:
    return issue->userLogin();
  case IssueListModel::Roles::CreatedAtRole:
    return issue->createdAt();
  default:
    return {};
  }
}

QHash<int, QByteArray>
IssueListModel::roleNames() const
{
  return {
    {           static_cast<int>(IssueListModel::Roles::IdRole),"issueId"                                                                },
    {       static_cast<int>(IssueListModel::Roles::NumberRole),       "number"},
    {        static_cast<int>(IssueListModel::Roles::TitleRole),        "title"},
    {   static_cast<int>(IssueListModel::Roles::IssueStateRole),   "issueState"},
    {         static_cast<int>(IssueListModel::Roles::BodyRole),         "body"},
    {      static_cast<int>(IssueListModel::Roles::HtmlUrlRole),      "htmlUrl"},
    { static_cast<int>(IssueListModel::Roles::RepoFullNameRole), "repoFullName"},
    {static_cast<int>(IssueListModel::Roles::CommentsCountRole),
     "commentsCount"                                                           },
    {    static_cast<int>(IssueListModel::Roles::UserLoginRole),    "userLogin"},
    {    static_cast<int>(IssueListModel::Roles::CreatedAtRole),    "createdAt"}
  };
}

void
IssueListModel::search(const QString& query)
{
  if (query.isEmpty() || this->m_isLoadingPage)
  {
    return;
  }

  this->m_currentQuery = query;
  this->m_currentPage  = 1;
  emit this->currentPageChanged();
  this->setIsLoadingPage(true);
  this->m_service->searchIssues(query, this->m_currentPage, this->m_perPage);
}

void
IssueListModel::loadMore()
{
  if (
    this->m_isLoadingPage || this->m_currentQuery.isEmpty() || !this->hasMore()
  )
  {
    return;
  }

  this->setIsLoadingPage(true);
  const int nextPage{this->m_currentPage + 1};
  this->m_service->searchIssues(
    this->m_currentQuery, nextPage, this->m_perPage
  );
}

void
IssueListModel::onSearchResultsReady(
  const QList<Issue*>& issues, const int& page, const int& totalCount
)
{
  this->setIsLoadingPage(false);
  this->setTotalCount(totalCount);

  if (page == 1)
  {
    this->resetWith(issues);
  }
  else
  {
    appendBatch(issues);
  }

  this->m_currentPage = page;
  emit this->currentPageChanged();
  emit this->hasMoreChanged();
}

void
IssueListModel::setIsLoadingPage(const bool& loading)
{
  if (this->m_isLoadingPage != loading)
  {
    this->m_isLoadingPage = loading;
    emit this->isLoadingPageChanged();
  }
}

void
IssueListModel::setTotalCount(const int& total)
{
  if (this->m_totalCount != total)
  {
    this->m_totalCount = total;
    emit this->totalCountChanged();
  }
}

void
IssueListModel::resetWith(const QList<Issue*>& batch)
{
  this->beginResetModel();
  qDeleteAll(this->m_issues);
  this->m_issues.clear();
  this->m_issues = batch;
  for (Issue* const i : this->m_issues)
  {
    i->setParent(this);
  }
  this->endResetModel();
  emit this->countChanged();
}

void
IssueListModel::appendBatch(const QList<Issue*>& batch)
{
  if (batch.isEmpty())
  {
    return;
  }

  const auto first{this->m_issues.size()};
  const auto last{first + batch.size() - 1};
  this->beginInsertRows({}, first, last);
  for (Issue* const i : batch)
  {
    i->setParent(this);
    this->m_issues.append(i);
  }
  this->endInsertRows();
  emit this->countChanged();
}