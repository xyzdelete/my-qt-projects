#pragma once

#include "cachemanager.hpp"
#include "githubservice.hpp"
#include "repository.hpp"
#include <QAbstractListModel>
#include <QDateTime>
#include <QDebug>
#include <QList>
#include <QQmlEngine>
#include <QString>
#include <QTimer>
#include <QUrl>
#include <qqml.h>

class RepositoryListModel : public QAbstractListModel
{
  Q_OBJECT
  QML_ELEMENT

  Q_PROPERTY(GitHubService* service READ service CONSTANT)
  Q_PROPERTY(int count READ count NOTIFY countChanged)
  Q_PROPERTY(int currentPage READ currentPage NOTIFY currentPageChanged)
  Q_PROPERTY(int perPage READ perPage WRITE setPerPage NOTIFY perPageChanged)
  Q_PROPERTY(int totalCount READ totalCount NOTIFY totalCountChanged)
  Q_PROPERTY(bool hasMore READ hasMore NOTIFY hasMoreChanged)
  Q_PROPERTY(bool isLoadingPage READ isLoadingPage NOTIFY isLoadingPageChanged)
  Q_PROPERTY(
    bool useCursor READ useCursor WRITE setUseCursor NOTIFY useCursorChanged
  )
  Q_PROPERTY(QString nextUrl READ nextUrl NOTIFY nextUrlChanged)
  Q_PROPERTY(
    bool autoRefresh READ autoRefresh WRITE setAutoRefresh NOTIFY
      autoRefreshChanged
  )
  Q_PROPERTY(
    int refreshIntervalMs READ refreshIntervalMs WRITE setRefreshIntervalMs
      NOTIFY refreshIntervalMsChanged
  )
  Q_PROPERTY(
    QDateTime lastRefreshAt READ lastRefreshAt NOTIFY lastRefreshAtChanged
  )
  Q_PROPERTY(
    QString sortField READ sortField WRITE setSortField NOTIFY sortFieldChanged
  )
public:
  enum class Roles : std::size_t
  {
    IdRole = Qt::UserRole + 1,
    NameRole,
    FullNameRole,
    DescriptionRole,
    StarsRole,
    ForksRole,
    LanguageRole,
    UrlRole,
    UpdatedAtRole,
    IsPrivateRole
  };

  explicit RepositoryListModel(QObject* parent = nullptr);

  int
  rowCount(const QModelIndex& parent = QModelIndex()) const override;

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
    return this->m_repos.size();
  }

  int
  currentPage() const
  {
    return this->m_currentPage;
  }

  int
  perPage() const
  {
    return this->m_perPage;
  }

  int
  totalCount() const
  {
    return this->m_totalCount;
  }

  bool
  hasMore() const;

  bool
  isLoadingPage() const
  {
    return this->m_isLoadingPage;
  }

  bool
  useCursor() const
  {
    return this->m_useCursor;
  }

  QString
  nextUrl() const
  {
    return this->m_nextUrl;
  }

  bool
  autoRefresh() const
  {
    return this->m_autoRefresh;
  }

  int
  refreshIntervalMs() const
  {
    return this->m_refreshIntervalMs;
  }

  QDateTime
  lastRefreshAt() const
  {
    return this->m_lastRefreshAt;
  }

  QString
  sortField() const
  {
    return this->m_sortField;
  }

  void
  setPerPage(const int& perPage);
  void
  setUseCursor(const bool& useCursor);

  void
  setAutoRefresh(const bool& autoRefresh);
  void
  setRefreshIntervalMs(const int& itnervalMs);
  void
  setSortField(const QString& field);

  Q_INVOKABLE void
  search(const QString& query);
  Q_INVOKABLE void
  loadMore();
  Q_INVOKABLE
  void
  fetchNextPage();
signals:
  void
  countChanged();
  void
  currentPageChanged();
  void
  perPageChanged();
  void
  totalCountChanged();
  void
  hasMoreChanged();
  void
  isLoadingPageChanged();
  void
  useCursorChanged();
  void
  nextUrlChanged();
  void
  autoRefreshChanged();
  void
  refreshIntervalMsChanged();
  void
  lastRefreshAtChanged();
  void
  sortFieldChanged();
private slots:
  void
  onSearchResultsPageReady(
    const QList<Repository*>& repositories,
    const int&                page,
    const int&                totalCount
  );
  void
  onSearchResultsCursorReady(
    const QList<Repository*>& repositories,
    const QString&            nextUrl,
    const bool&               isFirstPage
  );
  void
  onCachedPageReady(
    const QList<Repository*>& repositories,
    const int&                page,
    const int&                totalCount
  );
  void
  onCachedCursorReady(
    const QList<Repository*>& repositories,
    const QString&            nextUrl,
    const bool&               isFirstPage
  );
  void
  onRefreshTick();

private:
  void
  setIsLoadingPage(const bool& loading);
  void
  setTotalCount(const int& toal);
  void
  setNextUrl(const QString& url);
  void
  appendBatch(const QList<Repository*>& batch);
  void
  resetWith(const QList<Repository*>& batch);
  void
  applyDiff(const QList<Repository*>& incomming);

  GitHubService*     m_service{new GitHubService{this}};
  QList<Repository*> m_repos{};
  QString            m_currentQuery{};
  int                m_currentPage{0};
  int                m_perPage{30};
  int                m_totalCount{0};
  bool               m_isLoadingPage{false};
  bool               m_useCursor{false};
  QString            m_nextUrl{};
  QTimer*            m_refreshTimer{new QTimer{this}};
  bool               m_autoRefresh{false};
  int                m_refreshIntervalMs{30000};
  QDateTime          m_lastRefreshAt{};
  QString            m_sortField{QStringLiteral("stars")};
  bool               m_isRefreshing{false};
};