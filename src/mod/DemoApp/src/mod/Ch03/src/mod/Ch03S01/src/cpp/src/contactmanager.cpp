#include "contactmanager.hpp"
#include "contact.hpp"

ContactManager::ContactManager(QObject* const parent)
  : QObject{parent}
  , m_contactModel{new ContactListModel{this}}
{
  this->setupConnections();

  this->generateSampleContacts();
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
  c1.setPhone("+1-555-123-1245");
  c1.setCompany("Tech Innovations Inc");
  c1.setJobTitle("Software Engineer");
  c1.setTags({"work", "colleague"});
  c1.setIsFavorite(true);
  this->m_contactModel->addContact(c1);
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
}

void
ContactManager::onContactRemoved()
{
  this->updateStatistics();
}

void
ContactManager::onContactUpdated()
{
  this->updateStatistics();
}

void
ContactManager::updateStatistics()
{
  emit this->totalContactsChanged();
  emit this->favoritesCountChanged();
}