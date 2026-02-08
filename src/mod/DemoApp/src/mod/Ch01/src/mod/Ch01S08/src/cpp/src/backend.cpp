#include "backend.hpp"

Backend::Backend(QObject* const parent)
  : QObject{parent}
  , m_message{"Hello from C++ Backend!"}
  , m_counter{0}
{
}

QString
Backend::message() const
{
  return this->m_message;
}

void
Backend::setMessage(const QString& message)
{
  if (this->m_message != message)
  {
    this->m_message = message;
    emit this->messageChanged();
  }
}

int
Backend::counter() const
{
  return this->m_counter;
}

void
Backend::setCounter(int counter)
{
  if (this->m_counter != counter)
  {
    this->m_counter = counter;
    emit this->counterChanged();
  }
}

void
Backend::incrementCounter()
{
  this->setCounter(this->m_counter + 1);
}

void
Backend::resetCounter()
{
  this->setCounter(0);
}