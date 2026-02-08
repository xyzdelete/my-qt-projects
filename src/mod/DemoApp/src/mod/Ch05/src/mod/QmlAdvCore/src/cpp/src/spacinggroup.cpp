#include "spacinggroup.hpp"

SpacingGroup::SpacingGroup(QObject* parent)
  : QObject{parent}
{
}

int
SpacingGroup::small() const
{
  return this->m_small;
}

void
SpacingGroup::setSmall(const int& value)
{
  if (this->m_small == value)
  {
    return;
  }

  this->m_small = value;
  emit this->smallChanged();
};

int
SpacingGroup::medium() const
{
  return this->m_medium;
}

void
SpacingGroup::setMedium(const int& value)
{
  if (this->m_medium == value)
  {
    return;
  }

  this->m_medium = value;
  emit this->mediumChanged();
}

int
SpacingGroup::large() const
{
  return this->m_large;
}

void
SpacingGroup::setLarge(const int& value)
{
  if (this->m_large == value)
  {
    return;
  }

  this->m_large = value;
  emit this->largeChanged();
}