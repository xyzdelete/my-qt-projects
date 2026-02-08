#pragma once

#include "contactlistmodel.hpp"
#include <QObject>
#include <QQmlEngine>

class ContactManager : public QObject
{
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(ContactListModel* contactModel READ contactModel CONSTANT)
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
  ContactListModel* const m_contactModel;
  void
  setupConnections();
  void
  updateStatistics();
};