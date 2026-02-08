#include "movie.hpp"

#include <QDebug>

Movie::Movie(QObject* const parent)
  : QObject{parent}
  , m_title{"Movie Title"}
  , m_mainCharacter("Main Character")
{
  qDebug() << "Creating Movie Object...";
}

QString
Movie::mainCharacter() const
{
  qDebug() << "Getting the main character";
  return this->m_mainCharacter;
}

void
Movie::setMainCharacter(QString mainCharacter)
{
  qDebug() << "Setting the main character";
  if (this->m_mainCharacter == mainCharacter)
  {
    return;
  }

  this->m_mainCharacter = mainCharacter;
  emit this->mainCharacterChanged(this->m_mainCharacter);
}

QString
Movie::title() const
{
  qDebug() << "Getting the title";
  return this->m_title;
}

void
Movie::setTitle(QString title)
{
  qDebug() << "Setting the title";
  if (this->m_title == title)
  {
    return;
  }

  this->m_title = title;
  emit this->titleChanged(this->m_title);
}