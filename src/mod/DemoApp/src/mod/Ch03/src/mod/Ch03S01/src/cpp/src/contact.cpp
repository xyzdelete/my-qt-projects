#include "contact.hpp"

#include <QDebug>
#include <QJsonArray>

Contact::Contact(const QString& firstName, const QString& lastName)
  : m_firstName{firstName}
  , m_lastName{lastName}
{
}

Contact::Contact(const Contact& other)
  : m_id{other.m_id}
  , m_firstName{other.m_firstName}
  , m_lastName{other.m_lastName}
  , m_email{other.m_email}
  , m_phone{other.m_phone}
  , m_company{other.m_company}
  , m_jobTitle{other.m_jobTitle}
  , m_address{other.m_address}
  , m_notes{other.m_notes}
  , m_avatarUrl{other.m_avatarUrl}
  , m_tags{other.m_tags}
  , m_isFavorite{other.m_isFavorite}
  , m_dateAdded{other.m_dateAdded}
  , m_dateModified{other.m_dateModified}
  , m_contactFrequency{other.m_contactFrequency}
{
}

Contact::Contact(Contact&& other) noexcept
  : m_id{std::move(other.m_id)}
  , m_firstName{std::move(other.m_firstName)}
  , m_lastName{std::move(other.m_lastName)}
  , m_email{std::move(other.m_email)}
  , m_phone{std::move(other.m_phone)}
  , m_company{std::move(other.m_company)}
  , m_jobTitle{std::move(other.m_jobTitle)}
  , m_address{std::move(other.m_address)}
  , m_notes{std::move(other.m_notes)}
  , m_avatarUrl{std::move(other.m_avatarUrl)}
  , m_tags{std::move(other.m_tags)}
  , m_isFavorite{std::move(other.m_isFavorite)}
  , m_dateAdded{std::move(other.m_dateAdded)}
  , m_dateModified{std::move(other.m_dateModified)}
  , m_contactFrequency{std::move(other.m_contactFrequency)}
{
}

Contact&
Contact::operator=(const Contact& other)
{
  if (this != &other)
  {
    this->m_id               = other.m_id;
    this->m_firstName        = other.m_firstName;
    this->m_lastName         = other.m_lastName;
    this->m_email            = other.m_email;
    this->m_phone            = other.m_phone;
    this->m_company          = other.m_company;
    this->m_jobTitle         = other.m_jobTitle;
    this->m_address          = other.m_address;
    this->m_notes            = other.m_notes;
    this->m_avatarUrl        = other.m_avatarUrl;
    this->m_tags             = other.m_tags;
    this->m_isFavorite       = other.m_isFavorite;
    this->m_dateAdded        = other.m_dateAdded;
    this->m_dateModified     = other.m_dateModified;
    this->m_contactFrequency = other.m_contactFrequency;
  }
  return *this;
}

Contact&
Contact::operator=(Contact&& other) noexcept
{
  if (this != &other)
  {
    this->m_id               = std::move(other.m_id);
    this->m_firstName        = std::move(other.m_firstName);
    this->m_lastName         = std::move(other.m_lastName);
    this->m_email            = std::move(other.m_email);
    this->m_phone            = std::move(other.m_phone);
    this->m_company          = std::move(other.m_company);
    this->m_jobTitle         = std::move(other.m_jobTitle);
    this->m_address          = std::move(other.m_address);
    this->m_notes            = std::move(other.m_notes);
    this->m_avatarUrl        = std::move(other.m_avatarUrl);
    this->m_tags             = std::move(other.m_tags);
    this->m_isFavorite       = std::move(other.m_isFavorite);
    this->m_dateAdded        = std::move(other.m_dateAdded);
    this->m_dateModified     = std::move(other.m_dateModified);
    this->m_contactFrequency = std::move(other.m_contactFrequency);
  }
  return *this;
}

void
Contact::setFirstName(const QString& firstName)
{
  this->m_firstName = firstName;
  this->touch();
}

void
Contact::setLastName(const QString& lastName)
{
  this->m_lastName = lastName;
  this->touch();
}

void
Contact::setEmail(const QString& email)
{
  this->m_email = email;
  this->touch();
}

void
Contact::setPhone(const QString& phone)
{
  this->m_phone = phone;
  this->touch();
}

void
Contact::setCompany(const QString& company)
{
  this->m_company = company;
  this->touch();
}

void
Contact::setJobTitle(const QString& jobTitle)
{
  this->m_jobTitle = jobTitle;
  this->touch();
}

void
Contact::setAddress(const QString& address)
{
  this->m_address = address;
  this->touch();
}

void
Contact::setNotes(const QString& notes)
{
  this->m_notes = notes;
  this->touch();
}

void
Contact::setAvatarUrl(const QUrl& avatarUrl)
{
  this->m_avatarUrl = avatarUrl;
  this->touch();
}

void
Contact::setTags(const QStringList& tag)
{
  this->m_tags = tag;
  this->touch();
}

void
Contact::setIsFavorite(const bool& isFavorite)
{
  this->m_isFavorite = isFavorite;
  this->touch();
}

void
Contact::setDateAdded(const QDateTime& dateAdded)
{
  this->m_dateAdded = dateAdded;
}

void
Contact::setDateModified(const QDateTime& dateModified)
{
  this->m_dateModified = dateModified;
}

void
Contact::setContactFrequency(const int& contactFrequency)
{
  this->m_contactFrequency = contactFrequency;
  this->touch();
}

void
Contact::touch()
{
  this->m_dateModified = QDateTime::currentDateTime();
}

void
Contact::addTag(const QString& tag)
{
  if (!this->m_tags.contains(tag))
  {
    this->m_tags.append(tag);
    this->touch();
  }
}

void
Contact::removeTag(const QString& tag)
{
  if (this->m_tags.removeOne(tag))
  {
    this->touch();
  }
}

bool
Contact::hasTag(const QString& tag) const
{
  return this->m_tags.contains(tag);
}

// JSON serialization
QJsonObject
Contact::toJson() const
{
  QJsonObject json;
  json["id"]        = this->m_id;
  json["firstName"] = this->m_lastName;
  json["email"]     = this->m_email;
  json["phone"]     = this->m_phone;
  json["company"]   = this->m_company;
  json["jobTitle"]  = this->m_jobTitle;
  json["address"]   = this->m_address;
  json["notes"]     = this->m_notes;
  json["avatarUrl"] = this->m_avatarUrl.toString();

  QJsonArray tagsArray;
  for (const QString& tag : this->m_tags)
  {
    tagsArray.append(QJsonValue{tag});
  }
  json["tags"] = tagsArray;

  json["isFavorite"]       = this->m_isFavorite;
  json["dateAdded"]        = this->m_dateAdded.toString(Qt::ISODate);
  json["dateModified"]     = this->m_dateModified.toString(Qt::ISODate);
  json["contactFrequency"] = this->m_contactFrequency;

  return json;
}

Contact
Contact::fromJson(const QJsonObject& json)
{
  Contact contact;

  contact.m_id        = json["id"].toString();
  contact.m_firstName = json["firstName"].toString();
  contact.m_lastName  = json["lastName"].toString();
  contact.m_email     = json["email"].toString();
  contact.m_phone     = json["phone"].toString();
  contact.m_company   = json["company"].toString();
  contact.m_jobTitle  = json["jobTitle"].toString();
  contact.m_address   = json["address"].toString();
  contact.m_notes     = json["notes"].toString();
  contact.m_avatarUrl = QUrl{json["avatarUrl"].toString()};

  QJsonArray  tagsArray{json["tags"].toArray()};
  QStringList tags;
  for (const QJsonValue& value : tagsArray)
  {
    tags.append(value.toString());
  }

  contact.m_tags = tags;

  contact.m_isFavorite = json["isFavorite"].toBool();
  contact.m_dateAdded =
    QDateTime::fromString(json["dateAdded"].toString(), Qt::ISODate);

  contact.m_dateModified =
    QDateTime::fromString(json["dateModified"].toString(), Qt::ISODate);

  contact.m_contactFrequency = json["contactFrequency"].toInt();

  return contact;
}

bool
Contact::operator==(const Contact& other) const
{
  return this->m_id == other.m_id;
}

QString
Contact::initials() const
{
  QString result;
  if (!this->m_firstName.isEmpty())
  {
    result += this->m_firstName[0].toUpper();
  }

  if (!this->m_lastName.isEmpty())
  {
    result += this->m_lastName[0].toUpper();
  }

  return result.isEmpty() ? "?" : result;
}

int
Contact::avatarColorIndex() const
{
  // Generate consistent color index based on name hash
  QString name{this->fullName()};
  if (name.isEmpty())
  {
    name = this->m_id;
  }

  const auto& hash{qHash(name)};
  return static_cast<int>(hash % 8);
}