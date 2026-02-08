#pragma once

#include "cachemanager.hpp"
#include "issue.hpp"
#include "repository.hpp"
#include "user.hpp"
#include <QDebug>
#include <QElapsedTimer>
#include <QFutureWatcher>
#include <QHash>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QList>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QObject>
#include <QString>
#include <QThread>
#include <QtConcurrent>
#include <functional>
#include <qqml.h>

class GitHubService : public QObject
{
  Q_OBJECT
  QML_ELEMENT

  Q_PROPERTY(
    QString authToken READ authToken WRITE setAuthToken NOTIFY authTokenChanged
  )
  Q_PROPERTY(bool isLoading READ isLoading NOTIFY isLoadingChanged)
  Q_PROPERTY(QString errorMessage READ errorMessage NOTIFY errorMessageChanged)
  Q_PROPERTY(bool isParsing READ isParsing NOTIFY isParsingChanged)

public:
  explicit GitHubService(QObject* parent = nullptr);

  QString
  authToken() const
  {
    return this->m_authToken;
  }

  bool
  isLoading() const
  {
    return this->m_isLoading;
  }

  QString
  errorMessage() const
  {
    return this->m_errorMessage;
  }

  bool
  isParsing() const
  {
    return this->m_inflightParses > 0;
  }

  void
  setAuthToken(const QString& token);

  void
  setCache(CacheManager* cache);

  void
  searchRepositoriesPage(
    const QString& query,
    const int&     page,
    const int&     perPage,
    const QString& sort  = "stars",
    const QString& order = "desc"
  );

  void
  searchRepositoriesCursor(
    const QString& query,
    const int&     perPage,
    const QString& sort  = "stars",
    const QString& order = "desc"
  );

  void
  fetchByUrl(const QUrl& url);

  void
  searchIssues(
    const QString& query,
    const int&     page,
    const int&     perPage,
    const QString& sort  = "created",
    const QString& order = "desc"
  );

  void
  searchUsers(
    const QString& query,
    const int&     page,
    const int&     perPage,
    const QString& sort  = "followers",
    const QString& order = "desc"
  );

  static QString
  parseNextLink(const QByteArray& linkHeader);

signals:
  void
  authTokenChanged();
  void
  isLoadingChanged();
  void
  errorMessageChanged();
  void
  requestFailed();
  void
  isParsingChanged();
  void
  searchResultsReady(const QList<Repository*>& repositories);

  void
  searchResultsPageReady(
    const QList<Repository*>& repositories,
    const int&                page,
    const int&                totalCount
  );

  void
  searchResultsCursorReady(
    const QList<Repository*>& repositories,
    const QString&            nextUrl,
    const bool&               isFirstPage
  );

  void
  issueSearchResultsReady(
    const QList<Issue*>& issues, const int& page, const int& totalCount
  );

  void
  userSearchResultsReady(
    const QList<User*>& users, const int& page, const int& totalCount
  );

  void
  cachedPageReady(
    const QList<Repository*>& repositories,
    const int&                page,
    const int&                totalCount
  );

  void
  cachedCursorReady(
    const QList<Repository*>& repositories,
    const QString&            nextUrl,
    const bool&               isFirstPage
  );
private slots:
  void
  onSearchResultsPageReceived();
  void
  onSearchResultsCursorReceived();

  void
  onIssueSearchResultsReceived();
  void
  onUserSearchResultsReceived();

  void
  onCacheLoaded(const QString& key, const QByteArray& body, const bool& found);
  void
  onRequestFailed(const QNetworkReply::NetworkError& error);

private:
  enum class RequestKind
  {
    Page,
    Cursor
  };

  struct PendingRequest
  {
    RequestKind kind;
    // Page kind only
    int page{0};
    // Cursor kind only
    bool isFirstPage{false};
  };

  QList<Repository*>
  parseSearchItems(const QByteArray& body, int* totalCountOut = nullptr) const;
  void
  parseBytesAsync(
    const QByteArray&                                   body,
    std::function<void(const QList<Repository*>&, int)> onParsed
  );
  void
  beginParse();
  void
  endParse();
  QNetworkRequest
  buildRequest(const QUrl& url) const;
  void
  setIsLoading(bool loading);
  void
  setErrorMessage(const QString& message);

  QNetworkAccessManager* const m_networkManager{
    new QNetworkAccessManager{this}
  };
  QString                        m_authToken{};
  bool                           m_isLoading{};
  QString                        m_errorMessage{};
  CacheManager*                  m_cache{nullptr};
  QHash<QString, PendingRequest> m_pendingByKey{};
  int                            m_inflightParses{0};
};