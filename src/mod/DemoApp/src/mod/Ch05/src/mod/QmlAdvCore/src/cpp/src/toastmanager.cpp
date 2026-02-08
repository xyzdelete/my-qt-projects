#include "toastmanager.hpp"

ToastManager::ToastManager(QObject* parent)
  : QObject(parent)
{
  this->m_timer = new QTimer(this);
  this->m_timer->setSingleShot(true);
  this->connect(m_timer, &QTimer::timeout, this, &ToastManager::dismiss);
}

void
ToastManager::show(const QString& message, const int& duration)
{
  this->m_message = message;

  const int effectiveDuration{(duration > 0) ? duration : this->m_duration};
  this->m_timer->start(effectiveDuration);

  if (!this->m_visible)
  {
    this->m_visible = true;
    emit this->visibleChanged();
  }
  emit this->messageChanged();
}

void
ToastManager::dismiss()
{
  this->m_timer->stop();
  if (!this->m_visible)
  {
    return;
  }
  this->m_visible = false;
  emit this->visibleChanged();
}

QString
ToastManager::message() const
{
  return this->m_message;
}

bool
ToastManager::visible() const
{
  return this->m_visible;
}

int
ToastManager::duration() const
{
  return this->m_duration;
}

void
ToastManager::setDuration(const int& ms)
{
  if (this->m_duration == ms)
  {
    return;
  }
  this->m_duration = ms;
  emit this->durationChanged();
}