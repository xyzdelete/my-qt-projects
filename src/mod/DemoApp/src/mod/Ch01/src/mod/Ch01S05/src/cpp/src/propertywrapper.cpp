#include "propertywrapper.hpp"
#include <cstdlib>
#include <ctime>

PropertyWrapper::PropertyWrapper(QObject* const parent)
  : QObject{parent}
  , m_lastname{"LastName"}
  , m_firstname{"FirstName"}
  , m_timer{new QTimer{this}}
  , m_random_number{0}
{
  std::srand(static_cast<unsigned int>(time(nullptr)));
  QStringList list;
  list << "Steward" << "Johanson" << "Oliver" << "David" << "Snowden" << "Kevin"
       << "Mathson" << "Gray";

  connect(
    this->m_timer,
    &QTimer::timeout,
    [this, list]()
    {
      this->m_random_number = std::rand() % list.size();
      this->setFirstname(list[this->m_random_number]);
    }
  );

  this->m_timer->start(1000);
}

QString
PropertyWrapper::lastname() const
{
  return this->m_lastname;
}

QString
PropertyWrapper::firstname() const
{
  return this->m_firstname;
}

void
PropertyWrapper::setLastname(QString lastname)
{
  if (this->m_lastname != lastname)
  {
    this->m_lastname = lastname;
    emit this->lastnameChanged(this->m_lastname);
  }
}

void
PropertyWrapper::setFirstname(QString firstname)
{
  if (this->m_firstname != firstname)
  {
    this->m_firstname = firstname;
    emit this->firstnameChanged(this->m_firstname);
  }
}