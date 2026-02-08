#include "contactlistmodel.hpp"
#include "contact.hpp"

ContactListModel::ContactListModel(QObject* const parent)
  : QAbstractListModel{parent}
{
}

int
ContactListModel::rowCount(const QModelIndex& parent) const
{
  if (parent.isValid())
  {
    return 0;
  }

  return this->m_contacts.size();
}

QVariant
ContactListModel::data(const QModelIndex& index, int role) const
{
  if (!index.isValid() || index.row() >= this->m_contacts.size())
  {
    return QVariant{};
  }

  const Contact& contact{this->m_contacts.at(index.row())};

  switch (static_cast<ContactListModel::ContactRoles>(role))
  {
  case ContactListModel::ContactRoles::IdRole:
    return QVariant{contact.id()};
  case ContactListModel::ContactRoles::FirstNameRole:
    return QVariant{contact.firstName()};
  case ContactListModel::ContactRoles::LastNameRole:
    return QVariant{contact.lastName()};
  case ContactListModel::ContactRoles::FullNameRole:
    return QVariant{contact.fullName()};
  case ContactListModel::ContactRoles::EmailRole:
    return QVariant{contact.email()};
  case ContactListModel::ContactRoles::PhoneRole:
    return QVariant{contact.phone()};
  case ContactListModel::ContactRoles::CompanyRole:
    return QVariant{contact.company()};
  case ContactListModel::ContactRoles::JobTitleRole:
    return QVariant{contact.jobTitle()};
  case ContactListModel::ContactRoles::AddressRole:
    return QVariant{contact.address()};
  case ContactListModel::ContactRoles::NotesRole:
    return QVariant{contact.notes()};
  case ContactListModel::ContactRoles::AvatarUrlRole:
    return QVariant{contact.avatarUrl()};
  case ContactListModel::ContactRoles::TagsRole:
    return QVariant{contact.tags()};
  case ContactListModel::ContactRoles::IsFavoriteRole:
    return QVariant{contact.isFavorite()};
  case ContactListModel::ContactRoles::DateAddedRole:
    return QVariant{contact.dateAdded()};
  case ContactListModel::ContactRoles::DateModififedRole:
    return QVariant{contact.dateModified()};
  case ContactListModel::ContactRoles::ContactFrequencyRole:
    return QVariant{contact.contactFrequency()};
  case ContactListModel::ContactRoles::InitialsRole:
    return QVariant{contact.initials()};
  case ContactListModel::ContactRoles::AvatarColorIndexRole:
    return QVariant{contact.avatarColorIndex()};
  case ContactListModel::ContactRoles::AvatarColorRole:
  {
    static const QStringList colors{
      "#16a3a4",
      "#0EA5E9",
      "#8B5CF6",
      "#0D9488",
      "#EC4899",
      "#6366F1",
      "#F59E0B",
      "#EF4444",
      "#06B6D4",
      "#8B5CF6"
    };

    const int idx{contact.avatarColorIndex()};
    return QVariant{colors[idx % colors.size()]};
  }
  default:
    return QVariant{};
  }
}

QHash<int, QByteArray>
ContactListModel::roleNames() const
{
  QHash<int, QByteArray> roles{};

  roles[static_cast<int>(ContactListModel::ContactRoles::IdRole)] = "contactId";
  roles[static_cast<int>(ContactListModel::ContactRoles::FirstNameRole)] =
    "firstName";
  roles[static_cast<int>(ContactListModel::ContactRoles::LastNameRole)] =
    "lastName";
  roles[static_cast<int>(ContactListModel::ContactRoles::FullNameRole)] =
    "fullName";
  roles[static_cast<int>(ContactListModel::ContactRoles::EmailRole)] = "email";
  roles[static_cast<int>(ContactListModel::ContactRoles::PhoneRole)] = "phone";
  roles[static_cast<int>(ContactListModel::ContactRoles::CompanyRole)] =
    "company";
  roles[static_cast<int>(ContactListModel::ContactRoles::JobTitleRole)] =
    "jobTitle";
  roles[static_cast<int>(ContactListModel::ContactRoles::AddressRole)] =
    "address";
  roles[static_cast<int>(ContactListModel::ContactRoles::NotesRole)] = "notes";
  roles[static_cast<int>(ContactListModel::ContactRoles::AvatarUrlRole)] =
    "avatarUrl";
  roles[static_cast<int>(ContactListModel::ContactRoles::TagsRole)] = "tags";
  roles[static_cast<int>(ContactListModel::ContactRoles::IsFavoriteRole)] =
    "isFavorite";
  roles[static_cast<int>(ContactListModel::ContactRoles::DateAddedRole)] =
    "dateAdded";
  roles[static_cast<int>(ContactListModel::ContactRoles::DateModififedRole)] =
    "dateModified";
  roles[static_cast<int>(
    ContactListModel::ContactRoles::ContactFrequencyRole
  )] = "contactFrequency";
  roles[static_cast<int>(ContactListModel::ContactRoles::InitialsRole)] =
    "initials";
  roles[static_cast<int>(
    ContactListModel::ContactRoles::AvatarColorIndexRole
  )] = "avatarColorIndex";
  roles[static_cast<int>(ContactListModel::ContactRoles::AvatarColorRole)] =
    "avatarColor";

  return roles;
}

bool
ContactListModel::setData(
  const QModelIndex& index, const QVariant& value, int role
)
{
  if (!index.isValid() || index.row() >= this->m_contacts.size())
  {
    return false;
  }

  Contact& contact = this->m_contacts[index.row()];
  bool     changed = false;

  switch (static_cast<ContactListModel::ContactRoles>(role))
  {
  case ContactListModel::ContactRoles::FirstNameRole:
    contact.setFirstName(value.toString());
    changed = true;
    break;
  case ContactListModel::ContactRoles::LastNameRole:
    contact.setLastName(value.toString());
    changed = true;
    break;
  case ContactListModel::ContactRoles::EmailRole:
    contact.setEmail(value.toString());
    changed = true;
    break;
  case ContactListModel::ContactRoles::PhoneRole:
    contact.setPhone(value.toString());
    changed = true;
    break;
  case ContactListModel::ContactRoles::CompanyRole:
    contact.setCompany(value.toString());
    changed = true;
    break;
  case ContactListModel::ContactRoles::JobTitleRole:
    contact.setJobTitle(value.toString());
    changed = true;
    break;
  case ContactListModel::ContactRoles::IsFavoriteRole:
    contact.setIsFavorite(value.toBool());
    changed = true;
    break;
  default:
    return false;
  }

  if (changed)
  {
    // Update timestamp
    contact.touch();
    emit this->dataChanged(index, index, {role});
    return true;
  }
  return false;
}

Qt::ItemFlags
ContactListModel::flags(const QModelIndex& index) const
{
  if (!index.isValid())
  {
    return Qt::NoItemFlags;
  }

  return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}

void
ContactListModel::toggleFavorite(const int& row)
{
  if (row < 0 || row >= this->m_contacts.size())
  {
    return;
  }

  const QModelIndex& idx{this->index(row)};
  const bool         currentFavorite{this->m_contacts[row].isFavorite()};

  const bool isDataSet{this->setData(
    idx,
    !currentFavorite,
    static_cast<int>(ContactListModel::ContactRoles::IsFavoriteRole)
  )};

  if (!isDataSet)
  {
    return;
  }

  emit this->contactUpdated(row);

  return;
}

void
ContactListModel::addContact(const Contact& contact)
{
  const int newRow{static_cast<int>(this->m_contacts.size())};

  this->beginInsertRows(QModelIndex{}, newRow, newRow);
  this->m_contacts.append(contact);
  this->endInsertRows();

  emit this->countChanged();
  emit this->contactAdded(newRow);
}

void
ContactListModel::addContacts(const QVector<Contact>& contacts)
{
  if (contacts.isEmpty())
  {
    return;
  }

  const int firstRow{static_cast<int>(this->m_contacts.size())};
  const int lastRow{firstRow + static_cast<int>(contacts.size()) - 1};

  this->beginInsertRows(QModelIndex{}, firstRow, lastRow);
  this->m_contacts.append(contacts);
  this->endInsertRows();

  emit this->countChanged();
}

void
ContactListModel::addContact(
  const QString& firstName,
  const QString& lastName,
  const QString& email,
  const QString& phone
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

  this->addContact(contact);
}

void
ContactListModel::removeContact(const int& index)
{
  if (!this->isValidIndex(index))
  {
    return;
  }

  this->beginRemoveRows(QModelIndex{}, index, index);
  this->m_contacts.remove(index);
  this->endRemoveRows();

  emit this->countChanged();
  emit contactRemoved(index);
}

bool
ContactListModel::isValidIndex(const int& index) const
{
  return index >= 0 && index < this->m_contacts.size();
}

void
ContactListModel::emitDataChanged(const int& index)
{
  QModelIndex modelIndex{this->createIndex(index, 0)};
  emit this->dataChanged(modelIndex, modelIndex);
}

void
ContactListModel::clear()
{
  if (this->m_contacts.isEmpty())
  {
    return;
  }

  this->beginResetModel();
  this->m_contacts.clear();
  this->endResetModel();

  emit this->countChanged();
}

Contact
ContactListModel::getContact(const int& index) const
{
  if (!this->isValidIndex(index))
  {
    return Contact{};
  }

  return this->m_contacts.at(index);
}

QVector<Contact>
ContactListModel::getAllContacts() const
{
  return this->m_contacts;
}
