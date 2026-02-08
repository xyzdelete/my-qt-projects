#include "cachemanager.hpp"

CacheManager::CacheManager(QObject* parent)
  : QObject{parent}
{
  this->m_worker->moveToThread(&m_thread);

  this->connect(
    this, &CacheManager::saveRequested, this->m_worker, &CacheWorker::save
  );

  this->connect(
    this, &CacheManager::loadRequested, this->m_worker, &CacheWorker::load
  );

  this->connect(
    this->m_worker, &CacheWorker::loaded, this, &CacheManager::loaded
  );

  // Super important
  this->connect(
    &this->m_thread, &QThread::finished, this->m_worker, &QObject::deleteLater
  );

  this->m_thread.setObjectName("CacheWorkerThread");
  this->m_thread.start();
}

CacheManager::~CacheManager()
{
  this->m_thread.quit();
  this->m_thread.wait();
}

CacheManager*
CacheManager::create(QQmlEngine*, QJSEngine*)
{
  static CacheManager* instance{new CacheManager{QCoreApplication::instance()}};

  return instance;
}

void
CacheManager::requestLoad(const QString& key)
{
  emit this->loadRequested(key);
}

void
CacheManager::requestSave(const QString& key, const QByteArray& body)
{
  emit this->saveRequested(key, body);
}