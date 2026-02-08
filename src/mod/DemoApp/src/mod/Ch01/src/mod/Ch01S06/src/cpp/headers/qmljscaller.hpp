#pragma once

#include <QObject>

class QmlJSCaller : public QObject
{
  Q_OBJECT
public:
  explicit QmlJSCaller(QObject* const parent = nullptr);
  Q_INVOKABLE void
  cppMethod(QString parameter);
  void
  setQmlRoostObject(QObject* value);

private:
  void
           callJSMethod(QString param);
  QObject* qmlRootObject;
};