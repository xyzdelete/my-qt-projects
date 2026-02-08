#pragma once

#include "cacheworker.hpp"
#include <QByteArray>
#include <QCoreApplication>
#include <QObject>
#include <QString>
#include <QThread>
#include <qqml.h>

class CacheManager : public QObject
{
  Q_OBJECT
  QML_ELEMENT
  QML_SINGLETON

public:
  explicit CacheManager(QObject* parent = nullptr);
  ~CacheManager() override;
  static CacheManager*
  create(QQmlEngine*, QJSEngine*);
public slots:
  void
  requestLoad(const QString& key);
  void
  requestSave(const QString& key, const QByteArray& body);
signals:
  void
  loaded(const QString& key, const QByteArray& body, const bool& found);

  void
  saveRequested(const QString& key, const QByteArray& body);
  void
  loadRequested(const QString& key);

private:
  QThread m_thread;
  // No parent on purpose
  CacheWorker* m_worker{new CacheWorker};
};