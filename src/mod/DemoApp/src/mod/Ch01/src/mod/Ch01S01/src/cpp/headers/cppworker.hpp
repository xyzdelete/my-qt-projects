#pragma once

#include <QObject>

class CppWorker : public QObject
{
  Q_OBJECT
public:
  explicit CppWorker(QObject* const parent = nullptr);

  Q_INVOKABLE void
  regularMethod();
  Q_INVOKABLE QString
  regularMethodWithReturn(QString name, int age);
public slots:
  // Slots are callable-from-QML by default
  void
  cppSlot();
};