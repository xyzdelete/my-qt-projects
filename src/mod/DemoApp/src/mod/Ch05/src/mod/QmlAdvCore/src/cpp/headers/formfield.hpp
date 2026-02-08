#pragma once

#include "fieldvalidation.hpp"
#include <QObject>
#include <QString>
#include <QtQml/qqmlregistration.h>

class FormField : public QObject
{
  Q_OBJECT
  QML_ELEMENT
  Q_PROPERTY(QString label READ label WRITE setLabel NOTIFY labelChanged)
  Q_PROPERTY(
    QString placeholder READ placeholder WRITE setPlaceholder NOTIFY
      placeholderChanged
  )
  Q_PROPERTY(FieldValidation* validation READ validation CONSTANT)
public:
  explicit FormField(QObject* parent = nullptr);

  QString
  label() const;
  void
  setLabel(const QString& label);

  QString
  placeholder() const;
  void
  setPlaceholder(const QString& placeholder);

  FieldValidation*
  validation() const;

signals:
  void
  labelChanged();
  void
  placeholderChanged();

private:
  QString          m_label;
  QString          m_placeholder;
  FieldValidation* m_validation{new FieldValidation{this}};
};