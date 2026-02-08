#include "contactmanager.hpp"
#include "contact.hpp"

ContactManager::ContactManager(QObject* const parent)
  : QObject{parent}
{
  this->m_proxyModel->setSourceModel(this->m_contactModel);
  this->m_proxyModel->setSortAscending(true);
  this->setupConnections();

  this->loadContacts();
}

void
ContactManager::setupConnections()
{
  this->connect(
    this->m_contactModel,
    &ContactListModel::contactAdded,
    this,
    &ContactManager::onContactAdded
  );

  this->connect(
    this->m_contactModel,
    &ContactListModel::contactRemoved,
    this,
    &ContactManager::onContactUpdated
  );

  this->connect(
    this->m_contactModel,
    &ContactListModel::contactUpdated,
    this,
    &ContactManager::onContactUpdated
  );
}

void
ContactManager::generateSampleContacts()
{
  Contact c1{"Emma", "Johnson"};
  c1.setEmail("emma.johnson@example.com");
  c1.setPhone("+15551231245");
  c1.setCompany("Tech Innovations Inc");
  c1.setJobTitle("Software Engineer");
  c1.setTags({"work", "colleague"});
  c1.setAddress("1234 Street");
  c1.setNotes("Emma notes");
  c1.setIsFavorite(true);

  Contact c2{"Liam", "Martinez"};
  c2.setEmail("liam.martinez@example.com");
  c2.setPhone("+15552487719");
  c2.setCompany("BlueWave Analytics");
  c2.setJobTitle("Data Analyst");
  c2.setTags({"work", "partner", "alumni"});
  c2.setAddress("482 Maple Avenue");
  c2.setNotes("Met at the data conference");
  c2.setIsFavorite(false);

  Contact c3{"Sophia", "Chen"};
  c3.setEmail("sophia.chen@example.com");
  c3.setPhone("+15553905521");
  c3.setCompany("Horizon Design Studio");
  c3.setJobTitle("UX Designer");
  c3.setTags({"vendor", "friends"});
  c3.setAddress("77 Willow Lane");
  c3.setNotes("Prefers email over calls");
  c3.setIsFavorite(true);

  Contact c4{"Noah", "Williams"};
  c4.setEmail("noah.williams@example.com");
  c4.setPhone("+15556713084");
  c4.setCompany("Summit Logistics");
  c4.setJobTitle("Operations Manager");
  c4.setTags({"client", "lead"});
  c4.setAddress("9021 Ridge Road");
  c4.setNotes("Quarterly review in March");
  c4.setIsFavorite(false);

  Contact c5{"Olivia", "Brown"};
  c5.setEmail("olivia.brown@example.com");
  c5.setPhone("+15558529460");
  c5.setCompany("GreenLeaf Consulting");
  c5.setJobTitle("Project Manager");
  c5.setTags({"family", "prospect"});
  c5.setAddress("315 Oak Street");
  c5.setNotes("Birthday on June 14");
  c5.setIsFavorite(true);

  this->m_contactModel->addContact(c1);
  this->m_contactModel->addContact(c2);
  this->m_contactModel->addContact(c3);
  this->m_contactModel->addContact(c4);
  this->m_contactModel->addContact(c5);
}

int
ContactManager::totalContacts() const
{
  return this->m_contactModel->count();
}

int
ContactManager::favoritesCount() const
{
  int count{0};
  for (int i{0}; i < this->m_contactModel->count(); ++i)
  {
    Contact contact{this->m_contactModel->getContact(i)};
    if (contact.isFavorite())
    {
      ++count;
    }
  }

  return count;
}

void
ContactManager::addContact(
  const QString& firstName,
  const QString& lastName,
  const QString& email,
  const QString& phone
)
{
  this->m_contactModel->addContact(firstName, lastName, email, phone);
}

void
ContactManager::addContactFull(
  const QString&     firstName,
  const QString&     lastName,
  const QString&     email,
  const QString&     phone,
  const QString&     company,
  const QString&     jobTitle,
  const QString&     address,
  const QString&     notes,
  const bool&        isFavorite,
  const QStringList& tags
)
{
  Contact contact{firstName, lastName};

  if (!email.isEmpty())
  {
    contact.setEmail(email);
  }
  if (!phone.isEmpty())
  {
    contact.setPhone(phone);
  }
  if (!company.isEmpty())
  {
    contact.setCompany(company);
  }
  if (!jobTitle.isEmpty())
  {
    contact.setJobTitle(jobTitle);
  }
  if (!address.isEmpty())
  {
    contact.setAddress(address);
  }
  if (!notes.isEmpty())
  {
    contact.setNotes(notes);
  }

  contact.setIsFavorite(isFavorite);
  contact.setTags(tags);

  this->m_contactModel->addContact(contact);
}

void
ContactManager::removeContact(const int& index)
{
  this->m_contactModel->removeContact(index);
}

void
ContactManager::toggleFavorite(const int& index)
{
  this->m_contactModel->toggleFavorite(index);
}

void
ContactManager::clearAllContacts()
{
  this->m_contactModel->clear();
}

void
ContactManager::onContactAdded()
{
  this->updateStatistics();
  this->saveContacts();
}

void
ContactManager::onContactRemoved()
{
  this->updateStatistics();
  this->saveContacts();
}

void
ContactManager::onContactUpdated()
{
  this->updateStatistics();
  this->saveContacts();
}

void
ContactManager::updateStatistics()
{
  emit this->totalContactsChanged();
  emit this->favoritesCountChanged();
}

QVariantMap
ContactManager::getContactData(const int& index) const
{
  QVariantMap data{};
  if (index < 0 || index >= this->m_contactModel->count())
  {
    return data;
  }

  Contact contact{this->m_contactModel->getContact(index)};
  data["firstName"]  = contact.firstName();
  data["lastName"]   = contact.lastName();
  data["email"]      = contact.email();
  data["phone"]      = contact.phone();
  data["company"]    = contact.company();
  data["jobTitle"]   = contact.jobTitle();
  data["address"]    = contact.address();
  data["notes"]      = contact.notes();
  data["isFavorite"] = contact.isFavorite();
  data["tags"]       = contact.tags();
  data["avatarColor"] =
    this->m_contactModel
      ->data(
        this->m_contactModel->index(index),
        static_cast<int>(ContactListModel::ContactRoles::AvatarColorRole)
      )
      .toString();
  return data;
}

void
ContactManager::updateContactFull(
  const int&         index,
  const QString&     firstName,
  const QString&     lastName,
  const QString&     email,
  const QString&     phone,
  const QString&     company,
  const QString&     jobTitle,
  const QString&     address,
  const QString&     notes,
  const bool&        isFavorite,
  const QStringList& tags
)
{
  if (index < 0 || index >= this->m_contactModel->count())
  {
    qWarning() << "Invalid index for updateContactFull:" << index;
    return;
  }

  Contact contact{this->m_contactModel->getContact(index)};

  contact.setFirstName(firstName);
  contact.setLastName(lastName);
  contact.setEmail(email);
  contact.setPhone(phone);
  contact.setCompany(company);
  contact.setJobTitle(jobTitle);
  contact.setAddress(address);
  contact.setNotes(notes);
  contact.setIsFavorite(isFavorite);
  contact.setTags(tags);
  contact.touch();

  this->m_contactModel->updateContact(index, contact);
}

void
ContactManager::loadContacts()
{
  QVector<Contact> contacts{};

  if (JsonSerializer::fileExists(this->m_dataFilePath))
  {
    if (JsonSerializer::loadContacts(this->m_dataFilePath, contacts))
    {
      this->m_contactModel->addContacts(contacts);
      qDebug() << "ContactManager: Loaded" << contacts.size()
               << "contacts from a file";
    }
    else
    {
      qWarning() << "ContactManager: Failed to load contacts:"
                 << JsonSerializer::lastError();

      this->generateSampleContacts();
    }
  }
  else
  {
    qDebug() << "No contacts file found, generating sample data";
    this->generateSampleContacts();
  }
}

void
ContactManager::saveContacts()
{
  QVector<Contact> contacts{this->m_contactModel->getAllContacts()};

  if (!JsonSerializer::saveContacts(contacts, this->m_dataFilePath))
  {
    qWarning() << "ContactManager: Failed to save contacts:"
               << JsonSerializer::lastError();
  }
}