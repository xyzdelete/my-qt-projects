#pragma once

#include "formattached.hpp"
#include <QObject>
#include <QtQml/qqml.h>
#include <QtQml/qqmlregistration.h>

class Form : public QObject
{
  Q_OBJECT
  QML_ELEMENT
public:
  explicit Form(QObject* parent = nullptr);

  static FormAttached*
  qmlAttachedProperties(QObject* object);
};
QML_DECLARE_TYPEINFO(Form, QML_HAS_ATTACHED_PROPERTIES)