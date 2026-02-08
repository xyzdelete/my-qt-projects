#include "formattached.hpp"

FormAttached::FormAttached(QObject* parent)
  : QObject{parent}
{
  qDebug() << "[FormAttached] Attached object created, parent:" << parent;
}

QString
FormAttached::field() const
{
  return this->m_field;
}

void
FormAttached::setField(const QString& field)
{
  if (m_field == field)
  {
    return;
  }
  this->m_field = field;
  emit this->fieldChanged();
}

QString
FormAttached::label() const
{
  return this->m_label;
}

void
FormAttached::setLabel(const QString& label)
{
  if (m_label == label)
  {
    return;
  }
  this->m_label = label;
  emit this->labelChanged();
}

bool
FormAttached::required() const
{
  return this->m_required;
}

void
FormAttached::setRequired(bool required)
{
  if (m_required == required)
  {
    return;
  }
  this->m_required = required;
  emit this->requiredChanged();
}

QString
FormAttached::hint() const
{
  return this->m_hint;
}

void
FormAttached::setHint(const QString& hint)
{
  if (m_hint == hint)
  {
    return;
  }
  this->m_hint = hint;
  emit this->hintChanged();
}

QString
FormAttached::error() const
{
  return this->m_error;
}

void
FormAttached::validate(const QString& value)
{
  qDebug() << "[FormAttached] validate() called on field:" << m_field
           << "  value:" << value << "  required:" << m_required;

  QString newError{};
  if (this->m_required && value.trimmed().isEmpty())
    newError = this->m_label + " is required";

  if (this->m_error == newError)
  {
    return;
  }
  this->m_error = newError;
  qDebug() << "[FormAttached] errorChanged emitted, error:" << this->m_error;
  emit this->errorChanged();
}