#include "repository.hpp"
#include "user.hpp"

Repository::Repository(QObject* const parent)
  : QObject{parent}
{
}

void
Repository::setId(const int& id)
{
  if (this->m_id != id)
  {
    this->m_id = id;
    emit this->idChanged();
  }
}

void
Repository::setName(const QString& name)
{
  if (this->m_name != name)
  {
    this->m_name = name;
    emit this->nameChanged();
  }
}

void
Repository::setFullName(const QString& fullName)
{
  if (this->m_fullName != fullName)
  {
    this->m_fullName = fullName;
    emit this->fullNameChanged();
  }
}

void
Repository::setDescription(const QString& description)
{
  if (this->m_description != description)
  {
    this->m_description = description;
    emit this->descriptionChanged();
  }
}

void
Repository::setHtmlUrl(const QString& htmlUrl)
{
  if (this->m_htmlUrl != htmlUrl)
  {
    this->m_htmlUrl = htmlUrl;
    emit this->htmlUrlChanged();
  }
}

void
Repository::setLanguage(const QString& language)
{
  if (this->m_language != language)
  {
    this->m_language = language;
    emit this->languageChanged();
  }
}

void
Repository::setStargazersCount(const int& count)
{
  if (this->m_stargazersCount != count)
  {
    this->m_stargazersCount = count;
    emit this->stargazersCountChanged();
  }
}

void
Repository::setForksCount(const int& count)
{
  if (this->m_forksCount != count)
  {
    this->m_forksCount = count;
    emit this->forksCountChanged();
  }
}

void
Repository::setUpdatedAt(const QDateTime& dateTime)
{
  if (this->m_updatedAt != dateTime)
  {
    this->m_updatedAt = dateTime;
    emit this->updatedAtChanged();
  }
}

void
Repository::setIsPrivate(const bool& isPrivate)
{
  if (this->m_isPrivate != isPrivate)
  {
    this->m_isPrivate = isPrivate;
    emit this->isPrivateChanged();
  }
}

void
Repository::setOwner(QObject* const owner)
{
  if (this->m_owner != owner)
  {
    this->m_owner = owner;
    emit this->ownerChanged();
  }
}

Repository*
Repository::fromJson(const QJsonObject& json, QObject* const parent)
{
  Repository* const repo{new Repository{parent}};

  repo->setId(json["id"].toInt());
  repo->setName(json["name"].toString());
  repo->setFullName(json["full_name"].toString());
  repo->setDescription(json["description"].toString());
  repo->setHtmlUrl(json["html_url"].toString());
  repo->setLanguage(json["language"].toString());
  repo->setStargazersCount(json["stargazers_count"].toInt());
  repo->setForksCount(json["forks_count"].toInt());
  repo->setIsPrivate(json["private"].toBool());

  QString updatedAtStr{json["updated_at"].toString()};
  if (!updatedAtStr.isEmpty())
  {
    QDateTime updatedAt{QDateTime::fromString(updatedAtStr, Qt::ISODate)};
    repo->setUpdatedAt(updatedAt);
  }

  QJsonObject ownerJson{json["owner"].toObject()};
  if (!ownerJson.isEmpty())
  {
    User* const owner{User::fromJson(ownerJson, repo)};
    repo->setOwner(owner);
  }

  return repo;
}