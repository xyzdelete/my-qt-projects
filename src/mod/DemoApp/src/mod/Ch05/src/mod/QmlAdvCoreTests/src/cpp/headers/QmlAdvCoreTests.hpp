#pragma once

#include "spacinggroup.hpp"
#include "theme.hpp"
#include "version.hpp"
#include <QColor>
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

  void
  colorsIsNotNull()
  {
    Theme t;
    QVERIFY(t.colors() != nullptr);
  }

  void
  spacingIsNotNull()
  {
    Theme t;
    QVERIFY(t.spacing() != nullptr);
  }

  void
  primaryColorDefault()
  {
    Theme t;
    QCOMPARE(t.colors()->primary(), QColor{"#6750A4"});
  }

  void
  spacingSmallDefault()
  {
    Theme t;
    QCOMPARE(t.spacing()->small(), 8);
  };

  void
  setPrimaryColor()
  {
    ColorPalette palette;
    palette.setPrimary(QColor("red"));
    QCOMPARE(palette.primary(), QColor("red"));
  }
};

QTEST_MAIN(QmlAdvCoreTests)