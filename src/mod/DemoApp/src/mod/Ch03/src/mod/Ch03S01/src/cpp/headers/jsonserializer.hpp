#pragma once

#include "contact.hpp"
#include <QString>
#include <QVector>

class JsonSerializer
{
public:
  static bool
  saveContacts(const QVector<Contact>& contacts, const QString& filePath);
  static bool
  loadContacts(const QString& filePath, QVector<Contact>& contacts);
  static QString
  getDefaultFilePath();
  static bool
  fileExists(const QString& filePath);
  static QString
  lastError();

private:
  static QString s_lastError;
};