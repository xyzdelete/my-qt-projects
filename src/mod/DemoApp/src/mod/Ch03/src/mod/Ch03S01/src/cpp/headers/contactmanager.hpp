#pragma once

#include "contactfilterproxymodel.hpp"
#include "contactlistmodel.hpp"
#include "jsonserializer.hpp"
#include <QObject>
#include <QQmlEngine>

class ContactManager : public QObject
{
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(ContactListModel* contactModel READ contactModel CONSTANT)
  Q_PROPERTY(ContactFilterProxyModel* proxyModel READ proxyModel CONSTANT)
  Q_PROPERTY(int totalContacts READ totalContacts NOTIFY totalContactsChanged)
  Q_PROPERTY(
    int favoritesCount READ favoritesCount NOTIFY favoritesCountChanged
  )
public:
  explicit ContactManager(QObject* const parent = nullptr);

  // Property getters
  ContactListModel*
  contactModel() const
  {
    return this->m_contactModel;
  }

  ContactFilterProxyModel*
  proxyModel() const
  {
    return this->m_proxyModel;
  }

  int
  totalContacts() const;
  int
  favoritesCount() const;

  // Contact management (availbale to QML)
  Q_INVOKABLE void
  addContact(
    const QString& firstName,
    const QString& lastName,
    const QString& email = QString{},
    const QString& phone = QString{}
  );

  Q_INVOKABLE void
  addContactFull(
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
  );

  Q_INVOKABLE void
  removeContact(const int& index);
  Q_INVOKABLE void
  toggleFavorite(const int& index);
  Q_INVOKABLE void
  clearAllContacts();

  // Bulk operations
  Q_INVOKABLE void
  generateSampleContacts();

  Q_INVOKABLE QVariantMap
  getContactData(const int& index) const;
  Q_INVOKABLE void
  updateContactFull(
    const int&         index,
    const QString&     fristName,
    const QString&     lastName,
    const QString&     email,
    const QString&     phone,
    const QString&     company,
    const QString&     jobTitle,
    const QString&     address,
    const QString&     notes,
    const bool&        isFavorite,
    const QStringList& tags
  );

signals:
  void
  totalContactsChanged();
  void
  favoritesCountChanged();
private slots:
  void
  onContactAdded();
  void
  onContactRemoved();
  void
  onContactUpdated();

private:
  ContactListModel* const        m_contactModel{new ContactListModel{this}};
  ContactFilterProxyModel* const m_proxyModel{
    new ContactFilterProxyModel{this}
  };
  QString m_dataFilePath{JsonSerializer::getDefaultFilePath()};

  void
  setupConnections();
  void
  updateStatistics();
  void
  loadContacts();
  void
  saveContacts();
};