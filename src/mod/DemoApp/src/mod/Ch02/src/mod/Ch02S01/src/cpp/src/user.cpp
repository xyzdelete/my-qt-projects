#include "user.hpp"
#include <QJsonObject>

User::User(QObject* const parent)
  : QObject{parent}
{
}

void
User::setId(const int& id)
{
  if (this->m_id != id)
  {
    this->m_id = id;
    emit this->idChanged();
  }
}

void
User::setLogin(const QString& login)
{
  if (this->m_login != login)
  {
    this->m_login = login;
    emit this->loginChanged();
  }
}

void
User::setAvatarUrl(const QString& avatarUrl)
{
  if (this->m_avatarUrl != avatarUrl)
  {
    this->m_avatarUrl = avatarUrl;
    emit this->avatarUrlChanged();
  }
}

void
User::setHtmlUrl(const QString& htmlUrl)
{
  if (this->m_htmlUrl != htmlUrl)
  {
    this->m_htmlUrl = htmlUrl;
    emit this->htmlUrlChanged();
  }
}

void
User::setType(const QString& type)
{
  if (this->m_type != type)
  {
    this->m_type = type;
    emit this->typeChanged();
  }
}

User*
User::fromJson(const QJsonObject& json, QObject* const parent)
{
  User* const user{new User{parent}};
  user->setId(json["id"].toInt());
  user->setLogin(json["login"].toString());
  user->setAvatarUrl(json["avatar_url"].toString());
  user->setHtmlUrl(json["html_url"].toString());
  user->setType(json["type"].toString());
  return user;
}