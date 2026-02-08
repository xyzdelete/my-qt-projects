#pragma once

#include "contact.hpp"
#include <QAbstractListModel>
#include <QVector>

class ContactListModel : public QAbstractListModel
{
  Q_OBJECT

  Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
  // Custom roles for QML access
  enum class ContactRoles : int
  {
    IdRole = Qt::UserRole + 1,
    FirstNameRole,
    LastNameRole,
    FullNameRole,
    EmailRole,
    PhoneRole,
    CompanyRole,
    JobTitleRole,
    AddressRole,
    NotesRole,
    AvatarUrlRole,
    TagsRole,
    IsFavoriteRole,
    DateAddedRole,
    DateModififedRole,
    ContactFrequencyRole,
    InitialsRole,
    AvatarColorIndexRole,
    AvatarColorRole
  };

  explicit ContactListModel(QObject* const parent = nullptr);
  ~ContactListModel() override = default;

  int
  count() const
  {
    return this->m_contacts.size();
  }

  // Required overrides
  int
  rowCount(const QModelIndex& parent = QModelIndex{}) const override;
  QVariant
  data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
  QHash<int, QByteArray>
  roleNames() const override;

  // Edit
  bool
  setData(
    const QModelIndex& index, const QVariant& value, int role = Qt::EditRole
  ) override;
  Qt::ItemFlags
  flags(const QModelIndex& index) const override;

  // C++ Advanced operations
  void
  addContact(const Contact& contact);
  void
  addContacts(const QVector<Contact>& contacts);
  void
  updateContact(const int& index, const Contact& contact);
  QVector<Contact>
  getAllContacts() const;

  // QML-accessible methods
  Q_INVOKABLE void
  toggleFavorite(const int& row);
  Q_INVOKABLE void
  addContact(
    const QString& firstName,
    const QString& lastName,
    const QString& email = QString{},
    const QString& phone = QString{}
  );
  Q_INVOKABLE void
  removeContact(const int& index);
  Q_INVOKABLE void
  clear();
  Q_INVOKABLE Contact
  getContact(const int& index) const;

signals:
  void
  countChanged();
  void
  contactAdded(const int& index);
  void
  contactRemoved(const int& index);
  void
  contactUpdated(const int& index);

private:
  QVector<Contact> m_contacts{};
  bool
  isValidIndex(const int& index) const;
  void
  emitDataChanged(const int& index);
};