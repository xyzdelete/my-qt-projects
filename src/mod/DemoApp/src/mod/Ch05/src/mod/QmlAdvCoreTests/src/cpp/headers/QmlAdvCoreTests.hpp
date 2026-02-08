#pragma once

#include "version.hpp"
#include <QObject>
#include <QRegularExpression>
#include <QTest>

class QmlAdvCoreTests : public QObject
{
  Q_OBJECT

private slots:

  void
  stringReturnExpectedVersion()
  {
    Version v{};
    QCOMPARE(v.string(), QStringLiteral("1.0.0.0"));
  };

  void
  stringIsNotEmpty()
  {
    Version v{};
    QVERIFY(!v.string().isEmpty());
  };

  void
  stringIsSemVer()
  {
    Version                  v;
    const QRegularExpression semver(R"(\d+\.\d+\.\d+\.\d+)");
    QVERIFY(semver.match(v.string()).hasMatch());
  };
};

QTEST_MAIN(QmlAdvCoreTests)