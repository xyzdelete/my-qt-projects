#pragma once

#include <QDateTime>
#include <QJsonObject>
#include <QObject>
#include <QString>
#include <QStringList>
#include <QUrl>
#include <QUuid>

class Contact
{
public:
  explicit Contact() = default;
  ~Contact()         = default;
  Contact(const QString& firstName, const QString& lastName);
  Contact(const Contact& other);
  Contact(Contact&& other) noexcept;
  Contact&
  operator=(const Contact& other);
  Contact&
  operator=(Contact&& other) noexcept;

  bool
  operator==(const Contact& other) const;

  bool
  operator!=(const Contact& other) const
  {
    return !(*this == other);
  }

  // Getters
  QString
  id() const
  {
    return this->m_id;
  }

  QString
  firstName() const
  {
    return this->m_firstName;
  }

  QString
  lastName() const
  {
    return this->m_lastName;
  }

  QString
  fullName() const
  {
    return this->m_firstName + " " + this->m_lastName;
  }

  QString
  email() const
  {
    return this->m_email;
  }

  QString
  phone() const
  {
    return this->m_phone;
  }

  QString
  company() const
  {
    return this->m_company;
  }

  QString
  jobTitle() const
  {
    return this->m_jobTitle;
  }

  QString
  address() const
  {
    return this->m_address;
  }

  QString
  notes() const
  {
    return this->m_notes;
  }

  QUrl
  avatarUrl() const
  {
    return this->m_avatarUrl;
  }

  QStringList
  tags() const
  {
    return this->m_tags;
  }

  bool
  isFavorite() const
  {
    return this->m_isFavorite;
  }

  QDateTime
  dateAdded() const
  {
    return this->m_dateAdded;
  }

  QDateTime
  dateModified() const
  {
    return this->m_dateModified;
  }

  int
  contactFrequency() const
  {
    return this->m_contactFrequency;
  }

  // Setters
  void
  setId(const QString& id)
  {
    this->m_id = id;
  }

  void
  setFirstName(const QString& firstName);
  void
  setLastName(const QString& lastName);
  void
  setEmail(const QString& email);
  void
  setPhone(const QString& phone);
  void
  setCompany(const QString& company);
  void
  setJobTitle(const QString& jobTitle);
  void
  setAddress(const QString& address);
  void
  setNotes(const QString& notes);
  void
  setAvatarUrl(const QUrl& avatarUrl);
  void
  setTags(const QStringList& tags);
  void
  setIsFavorite(const bool& isFavorite);
  void
  setDateAdded(const QDateTime& dateAdded);
  void
  setDateModified(const QDateTime& dateModified);
  void
  setContactFrequency(const int& contactFrequency);

  // Utility
  void
  touch();
  void
  addTag(const QString& tag);
  void
  removeTag(const QString& tag);
  bool
  hasTag(const QString& tag) const;

  QJsonObject
  toJson() const;
  static Contact
  fromJson(const QJsonObject& json);

  QString
  initials() const;
  int
  avatarColorIndex() const;

private:
  QString     m_id{QUuid::createUuid().toString(QUuid::WithoutBraces)};
  QString     m_firstName{};
  QString     m_lastName{};
  QString     m_email{};
  QString     m_phone{};
  QString     m_company{};
  QString     m_jobTitle{};
  QString     m_address{};
  QString     m_notes{};
  QUrl        m_avatarUrl{};
  QStringList m_tags{};
  bool        m_isFavorite{};
  QDateTime   m_dateAdded{QDateTime::currentDateTime()};
  QDateTime   m_dateModified{QDateTime::currentDateTime()};
  int         m_contactFrequency{};
};