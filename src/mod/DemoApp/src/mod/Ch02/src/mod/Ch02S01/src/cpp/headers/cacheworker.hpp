#pragma once

#include <QByteArray>
#include <QCryptographicHash>
#include <QDir>
#include <QFile>
#include <QObject>
#include <QStandardPaths>
#include <QString>

class CacheWorker : public QObject
{
  Q_OBJECT
public:
  explicit CacheWorker(QObject* parent = nullptr);

public slots:
  void
  save(const QString& key, const QByteArray& body) const;
  void
  load(const QString& key);

signals:
  void
  loaded(const QString& key, const QByteArray& body, const bool& found);

private:
  QString
  fileForKey(const QString& key) const;
  QString
  cacheDir() const;
};