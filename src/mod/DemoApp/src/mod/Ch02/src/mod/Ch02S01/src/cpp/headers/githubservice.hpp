#pragma once

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>
#include <QVariantList>
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
  Q_PROPERTY(
    QVariantList repositories READ repositories NOTIFY repositoriesChanged
  )

public:
  explicit GitHubService(QObject* const parent = nullptr);

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

  QVariantList
  repositories() const
  {
    return this->m_repositories;
  }

  void
  setAuthToken(const QString& token);
  Q_INVOKABLE void
  fetchUserRepositories(const QString& username = QString{});
  Q_INVOKABLE void
  fetchRepository(const QString& owner, const QString& repo);
  Q_INVOKABLE void
  clearRepositories();
  Q_INVOKABLE void
  searchRepositories(
    const QString& query,
    const QString& sort  = "stars",
    const QString& order = "desc"
  );
  Q_INVOKABLE void
  fetchAuthenticatedUserRepositories();
signals:
  void
  authTokenChanged();
  void
  isLoadingChanged();
  void
  errorMessageChanged();
  void
  repositoriesChanged();
  void
  repositoryFetched(const QVariant& repository);
private slots:
  void
  onUserRepositoriesReceived();
  void
  onRepositoryReceived();
  void
  onSearchResultsReceived();
  void
  onRequestFailed(const QNetworkReply::NetworkError& error);

private:
  void
  setIsLoading(bool loading);
  void
  setErrorMessage(const QString& message);
  QVariant
  parseRepositoryJson(const QJsonObject& json);

  QNetworkAccessManager* const m_networkManager{};
  QString                      m_authToken{};
  bool                         m_isLoading{};
  QString                      m_errorMessage{};
  QVariantList                 m_repositories{};
};