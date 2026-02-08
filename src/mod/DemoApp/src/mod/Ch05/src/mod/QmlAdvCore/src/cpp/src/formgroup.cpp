#include "formgroup.hpp"

FormGroup::FormGroup(QObject* parent)
  : QObject{parent}
{
}

QString
FormGroup::title() const
{
  return this->m_title;
}

void
FormGroup::setTitle(const QString& title)
{
  if (this->m_title == title)
  {
    return;
  }

  this->m_title = title;
  emit this->titleChanged();
}

QQmlListProperty<FormField>
FormGroup::fields()
{
  return QQmlListProperty<FormField>(
    this,
    &m_fields,
    &FormGroup::appendField,
    &FormGroup::fieldCount,
    &FormGroup::fieldAt,
    &FormGroup::clearFields
  );
}

int
FormGroup::fieldCount() const
{
  return this->m_fields.size();
}

FormField*
FormGroup::fieldAt(const int& index) const
{
  if (index < 0 || index >= this->m_fields.size())
  {
    return nullptr;
  }
  return this->m_fields.at(index);
}

void
FormGroup::appendField(QQmlListProperty<FormField>* list, FormField* field)
{
  auto* group{qobject_cast<FormGroup*>(list->object)};
  field->setParent(group);
  group->m_fields.append(field);
  emit group->fieldsChanged();
}

qsizetype
FormGroup::fieldCount(QQmlListProperty<FormField>* list)
{
  return qobject_cast<FormGroup*>(list->object)->m_fields.size();
}

FormField*
FormGroup::fieldAt(QQmlListProperty<FormField>* list, qsizetype index)
{
  return qobject_cast<FormGroup*>(list->object)->m_fields.at(index);
}

void
FormGroup::clearFields(QQmlListProperty<FormField>* list)
{
  auto* group{qobject_cast<FormGroup*>(list->object)};
  qDeleteAll(group->m_fields);
  group->m_fields.clear();
  emit group->fieldsChanged();
}