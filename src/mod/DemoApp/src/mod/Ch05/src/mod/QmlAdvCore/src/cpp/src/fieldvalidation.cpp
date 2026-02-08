#include "fieldvalidation.hpp"

FieldValidation::FieldValidation(QObject* parent)
  : QObject{parent}
{
}

bool
FieldValidation::required() const
{
  return this->m_required;
}

void
FieldValidation::setRequired(const bool& required)
{
  if (this->m_required == required)
  {
    return;
  }

  this->m_required = required;

  emit this->requiredChanged();
}

int
FieldValidation::minLength() const
{
  return this->m_minLength;
}

void
FieldValidation::setMinLength(const int& minLength)
{
  if (this->m_minLength == minLength)
  {
    return;
  }
  this->m_minLength = minLength;
  emit this->minLengthChanged();
}

int
FieldValidation::maxLength() const
{
  return this->m_maxLength;
}

void
FieldValidation::setMaxLength(const int& maxLength)
{
  if (this->m_maxLength == maxLength)
  {
    return;
  }

  this->m_maxLength = maxLength;
  emit this->maxLengthChanged();
}