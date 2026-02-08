#include "movie.hpp"

Movie::Movie(QObject* const parent)
  : QObject{parent}
{
}

QString
Movie::mainCharacter() const
{
  return this->m_mainCharacter;
}

void
Movie::setMainCharacter(const QString& newMainCharacter)
{
  if (this->m_mainCharacter == newMainCharacter)
  {
    return;
  }
  this->m_mainCharacter = newMainCharacter;
  emit this->mainCharacterChanged();
}

QString
Movie::title() const
{
  return this->m_title;
}

void
Movie::setTitle(const QString& newTitle)
{
  if (this->m_title == newTitle)
  {
    return;
  }
  this->m_title = newTitle;
  emit this->titleChanged();
}