#pragma once

#include "githubservice.hpp"
#include "issue.hpp"
#include <QAbstractListModel>
#include <QList>
#include <qqml.h>

class IssueListModel : public QAbstractListModel
{
  Q_OBJECT
  QML_ELEMENT

  Q_PROPERTY(GitHubService* service READ service CONSTANT)
  Q_PROPERTY(int count READ count NOTIFY countChanged)
  Q_PROPERTY(bool isLoadingPage READ isLoadingPage NOTIFY isLoadingPageChanged)
  Q_PROPERTY(int totalCount READ totalCount NOTIFY totalCountChanged)
  Q_PROPERTY(bool hasMore READ hasMore NOTIFY hasMoreChanged)
  Q_PROPERTY(int currentPage READ currentPage NOTIFY currentPageChanged)

public:
  enum class Roles : std::size_t
  {
    IdRole = Qt::UserRole + 1,
    NumberRole,
    TitleRole,
    IssueStateRole,
    BodyRole,
    HtmlUrlRole,
    RepoFullNameRole,
    CommentsCountRole,
    UserLoginRole,
    CreatedAtRole
  };

  explicit IssueListModel(QObject* parent = nullptr);

  int
  rowCount(const QModelIndex& parent = QModelIndex{}) const override;
  QVariant
  data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
  QHash<int, QByteArray>
  roleNames() const override;

  GitHubService*
  service() const
  {
    return this->m_service;
  }

  int
  count() const
  {
    return this->m_issues.size();
  }

  bool
  isLoadingPage() const
  {
    return this->m_isLoadingPage;
  }

  int
  totalCount() const
  {
    return this->m_totalCount;
  }

  bool
  hasMore() const
  {
    return this->m_issues.size() < this->m_totalCount;
  }

  int
  currentPage() const
  {
    return this->m_currentPage;
  }

  Q_INVOKABLE void
  search(const QString& query);
  Q_INVOKABLE void
  loadMore();

signals:
  void
  countChanged();
  void
  isLoadingPageChanged();
  void
  totalCountChanged();
  void
  hasMoreChanged();
  void
  currentPageChanged();

private:
  void
  setIsLoadingPage(const bool& loading);
  void
  setTotalCount(const int& total);
  void
  appendBatch(const QList<Issue*>& batch);
  void
  resetWith(const QList<Issue*>& batch);

private slots:
  void
  onSearchResultsReady(
    const QList<Issue*>& issues, const int& page, const int& totalCount
  );

private:
  GitHubService* m_service{new GitHubService{this}};
  QList<Issue*>  m_issues{};
  QString        m_currentQuery{};
  int            m_currentPage{0};
  int            m_perPage{30};
  int            m_totalCount{0};
  bool           m_isLoadingPage{false};
};
