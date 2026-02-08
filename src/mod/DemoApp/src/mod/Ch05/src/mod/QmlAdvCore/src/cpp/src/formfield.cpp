#include "formfield.hpp"

FormField::FormField(QObject* parent)
  : QObject{parent}
{
}

QString
FormField::label() const
{
  return this->m_label;
}

void
FormField::setLabel(const QString& label)
{
  if (this->m_label == label)
  {
    return;
  }

  this->m_label = label;
  emit this->labelChanged();
}

QString
FormField::placeholder() const
{
  return this->m_placeholder;
}

void
FormField::setPlaceholder(const QString& placeholder)
{
  if (this->m_placeholder == placeholder)
  {
    return;
  }

  this->m_placeholder = placeholder;
  emit this->placeholderChanged();
}

FieldValidation*
FormField::validation() const
{
  return this->m_validation;
}