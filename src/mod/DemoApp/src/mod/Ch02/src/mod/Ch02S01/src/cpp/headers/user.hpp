#pragma once

#include <QJsonObject>
#include <QObject>
#include <QString>
#include <qqml.h>

class User : public QObject
{
  Q_OBJECT
  QML_ELEMENT

  Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
  Q_PROPERTY(QString login READ login WRITE setLogin NOTIFY loginChanged)
  Q_PROPERTY(
    QString avatarUrl READ avatarUrl WRITE setAvatarUrl NOTIFY avatarUrlChanged
  )
  Q_PROPERTY(
    QString htmlUrl READ htmlUrl WRITE setHtmlUrl NOTIFY htmlUrlChanged
  )
  Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)
public:
  explicit User(QObject* const parent = nullptr);

  int
  id() const
  {
    return this->m_id;
  }

  QString
  login() const
  {
    return this->m_login;
  }

  QString
  avatarUrl() const
  {
    return this->m_avatarUrl;
  }

  QString
  htmlUrl() const
  {
    return this->m_htmlUrl;
  }

  QString
  type() const
  {
    return this->m_type;
  }

  void
  setId(const int& id);
  void
  setLogin(const QString& login);
  void
  setAvatarUrl(const QString& avatarUrl);
  void
  setHtmlUrl(const QString& htmlUrl);
  void
  setType(const QString& type);

  static User*
  fromJson(const QJsonObject& json, QObject* const parent = nullptr);
signals:
  void
  idChanged();
  void
  loginChanged();
  void
  avatarUrlChanged();
  void
  htmlUrlChanged();
  void
  typeChanged();

private:
  int     m_id{};
  QString m_login{};
  QString m_avatarUrl{};
  QString m_htmlUrl{};
  QString m_type{};
};