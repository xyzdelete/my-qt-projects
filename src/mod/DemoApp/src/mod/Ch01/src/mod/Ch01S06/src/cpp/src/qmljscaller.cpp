#include "qmljscaller.hpp"

#include <QDebug>
#include <QVariant>

QmlJSCaller::QmlJSCaller(QObject* const parent)
  : QObject{parent}
{
}

void
QmlJSCaller::cppMethod(QString parameter)
{
  qDebug() << "This is C++ talking, calling QML Javascript function";
  this->callJSMethod(parameter);
}

void
QmlJSCaller::setQmlRoostObject(QObject* value)
{
  this->qmlRootObject = value;
}

void
QmlJSCaller::callJSMethod(QString param)
{
  QVariant returnedValue;
  QVariant cppParameter = QVariant::fromValue(param);

  QMetaObject::invokeMethod(
    this->qmlRootObject,
    "qmlJSFunction",
    Q_RETURN_ARG(QVariant, returnedValue),
    Q_ARG(QVariant, cppParameter)
  );

  qDebug() << "C++ talking, done calling QML JavaScript, return value is:"
           << returnedValue.toString();
}