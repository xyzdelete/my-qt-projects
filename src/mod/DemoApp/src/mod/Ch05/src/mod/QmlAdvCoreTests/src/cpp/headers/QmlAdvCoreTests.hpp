#pragma once

#include "card.hpp"
#include "fieldvalidation.hpp"
#include "form.hpp"
#include "formattached.hpp"
#include "formfield.hpp"
#include "formgroup.hpp"
#include "pulse.hpp"
#include "spacinggroup.hpp"
#include "theme.hpp"
#include "toastmanager.hpp"
#include "undostack.hpp"
#include "version.hpp"
#include <QColor>
#include <QGuiApplication>
#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QRegularExpression>
#include <QSignalSpy>
#include <QTest>

// Test pulse
class TargetObject : public QObject
{
  Q_OBJECT
  Q_PROPERTY(qreal value READ value WRITE setValue NOTIFY valueChanged)
public:
  explicit TargetObject(QObject* parent = nullptr)
    : QObject{parent}
  {
  }

  qreal
  value() const
  {
    return this->m_value;
  }

  void
  setValue(qreal v)
  {
    if (!qFuzzyCompare(this->m_value + 1.0, v + 1.0))
    {
      this->m_value = v;
      emit this->valueChanged();
    }
  }

signals:
  void
  valueChanged();

private:
  qreal m_value{0.0};
};

class QmlAdvCoreTests : public QObject

{
  Q_OBJECT

private slots:

  // Version tests
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

  // Theme tests
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

  // ThemeFormGroup tests
  void
  emptyGroupHasZeroFields()
  {
    FormGroup g;
    QCOMPARE(g.fieldCount(), 0);
  }

  void
  appendedFieldIsCountedAndRetrievable()
  {
    FormGroup g;
    auto*     f{new FormField{&g}};
    f->setLabel("Username");
    auto                                        list = g.fields();
    QQmlListProperty<FormField>::AppendFunction append{list.append};
    append(&list, f);
    QCOMPARE(g.fieldCount(), 1);
  }

  void
  appendMultipleFields()
  {
    FormGroup g;
    auto      list{g.fields()};
    for (int i{0}; i < 5; ++i)
    {
      auto* f{new FormField{&g}};
      f->setLabel(QString{"Field %1"}.arg(i));
      list.append(&list, f);
    }
    QCOMPARE(g.fieldCount(), 5);
  }

  void
  fieldAtReturnsCorrectField()
  {
    FormGroup g;
    auto      list{g.fields()};
    auto*     f0{new FormField{&g}};
    f0->setLabel("First");
    auto* f1{new FormField{&g}};
    f1->setLabel("Second");
    list.append(&list, f0);
    list.append(&list, f1);
    QCOMPARE(g.fieldAt(0)->label(), QStringLiteral("First"));
    QCOMPARE(g.fieldAt(1)->label(), QStringLiteral("Second"));
  }

  void
  fieldAtOutOfBoundsReturnsNull()
  {
    FormGroup g;
    QVERIFY(g.fieldAt(0) == nullptr);
    QVERIFY(g.fieldAt(-1) == nullptr);
  }

  void
  clearRemovesAllFields()
  {
    FormGroup g;
    auto      list{g.fields()};
    for (int i{0}; i < 3; ++i)
    {
      auto* f{new FormField{&g}};
      list.append(&list, f);
    }
    QCOMPARE(g.fieldCount(), 3);
    list.clear(&list);
    QCOMPARE(g.fieldCount(), 0);
  }

  void
  titleRoundtrip()
  {
    FormGroup g;
    g.setTitle("Login");
    QCOMPARE(g.title(), QStringLiteral("Login"));
  }

  void
  titleChangedSignalEmitted()
  {
    FormGroup  g;
    QSignalSpy spy{&g, &FormGroup::titleChanged};
    g.setTitle("Registration");
    QCOMPARE(spy.count(), 1);
    g.setTitle("Registration");
    QCOMPARE(spy.count(), 1);
  }

  void
  appendSetsFieldParent()
  {
    FormGroup g;
    auto      list{g.fields()};
    auto*     f{new FormField{&g}};
    list.append(&list, f);
    QCOMPARE(f->parent(), &g);
  }

  // void
  // formFieldPropertiesRoundtrip()
  // {
  //   FormField f;
  //   f.setLabel("Email");
  //   f.setPlaceholder("user@example.com");
  //   f.setRequired(true);

  //   QCOMPARE(f.label(), QStringLiteral("Email"));
  //   QCOMPARE(f.placeholder(), QStringLiteral("user@example.com"));
  //   QVERIFY(f.required());
  // }

  // void
  // requiredDefaultIsFalse()
  // {
  //   FormField f;
  //   QVERIFY(!f.required());
  // }

  // Card tests
  void
  defaultPadding()
  {
    Card card;
    QCOMPARE(card.padding(), 8);
  }

  void
  defaultSpacing()
  {
    Card card;
    QCOMPARE(card.spacing(), 8);
  }

  void
  setPaddingRoundtrip()
  {
    Card card;
    card.setPadding(16);
    QCOMPARE(card.padding(), 16);
  }

  void
  setSpacingRoundtrip()
  {
    Card card;
    card.setSpacing(12);
    QCOMPARE(card.spacing(), 12);
  }

  void
  paddingChangedEmitted()
  {
    Card       card;
    QSignalSpy spy{&card, &Card::paddingChanged};
    card.setPadding(24);
    QCOMPARE(spy.count(), 1);
  }

  void
  spacingChangedEmitted()
  {
    Card       card;
    QSignalSpy spy{&card, &Card::spacingChanged};
    card.setSpacing(4);
    QCOMPARE(spy.count(), 1);
  }

  void
  paddingNotEmittedForSameValue()
  {
    Card card;
    card.setPadding(20);
    QSignalSpy spy{&card, &Card::paddingChanged};
    card.setPadding(20);
    QCOMPARE(spy.count(), 0);
  }

  void
  appendItemIncreasesCount()
  {
    Card  card;
    auto  list{card.contentItems()};
    auto* item{new QQuickItem{&card}};
    list.append(&list, item);
    QCOMPARE(list.count(&list), 1);
  }

  void
  itemAtReturnsCorrectItem()
  {
    Card  card;
    auto  list{card.contentItems()};
    auto* item0{new QQuickItem{&card}};
    auto* item1{new QQuickItem{&card}};
    list.append(&list, item0);
    list.append(&list, item1);
    QCOMPARE(list.at(&list, 0), item0);
    QCOMPARE(list.at(&list, 1), item1);
  }

  void
  clearRemovesAllItems()
  {
    Card card;
    auto list{card.contentItems()};
    list.append(&list, new QQuickItem);
    list.append(&list, new QQuickItem);
    QCOMPARE(list.count(&list), 2);
    list.clear(&list);
    QCOMPARE(list.count(&list), 0);
  }

  void
  appendSetsParentItem()
  {
    Card  card;
    auto  list{card.contentItems()};
    auto* item{new QQuickItem{&card}};
    list.append(&list, item);
    QCOMPARE(item->parentItem(), &card);
  }

  void
  contentItemsChangedOnAppend()
  {
    Card       card;
    QSignalSpy spy{&card, &Card::contentItemsChanged};
    auto       list{card.contentItems()};
    list.append(&list, new QQuickItem{&card});
    QCOMPARE(spy.count(), 1);
  }

  void
  contentItemsChangedOnClear()
  {
    Card card;
    auto list{card.contentItems()};
    list.append(&list, new QQuickItem(&card));
    QSignalSpy spy{&card, &Card::contentItemsChanged};
    list.clear(&list);
    QCOMPARE(spy.count(), 1);
  }

  // FieldValidation tests
  void
  defaultRequired()
  {
    FieldValidation v;
    QVERIFY(!v.required());
  }

  void
  defaultMinLength()
  {
    FieldValidation v;
    QCOMPARE(v.minLength(), 0);
  }

  void
  defaultMaxLength()
  {
    FieldValidation v;
    QCOMPARE(v.maxLength(), 0);
  }

  void
  setRequiredRoundtrip()
  {
    FieldValidation v;
    v.setRequired(true);
    QVERIFY(v.required());
    v.setRequired(false);
    QVERIFY(!v.required());
  }

  void
  setMinLengthRoundtrip()
  {
    FieldValidation v;
    v.setMinLength(5);
    QCOMPARE(v.minLength(), 5);
  }

  void
  setMaxLengthRoundtrip()
  {
    FieldValidation v;
    v.setMaxLength(100);
    QCOMPARE(v.maxLength(), 100);
  }

  void
  requiredChangedEmitted()
  {
    FieldValidation v;
    QSignalSpy      spy(&v, &FieldValidation::requiredChanged);
    v.setRequired(true);
    QCOMPARE(spy.count(), 1);
  }

  void
  minLengthChangedEmitted()
  {
    FieldValidation v;
    QSignalSpy      spy(&v, &FieldValidation::minLengthChanged);
    v.setMinLength(3);
    QCOMPARE(spy.count(), 1);
  }

  void
  maxLengthChangedEmitted()
  {
    FieldValidation v;
    QSignalSpy      spy(&v, &FieldValidation::maxLengthChanged);
    v.setMaxLength(50);
    QCOMPARE(spy.count(), 1);
  }

  void
  notEmittedForSameValue()
  {
    FieldValidation v;
    v.setRequired(true);
    QSignalSpy spy(&v, &FieldValidation::requiredChanged);
    v.setRequired(true);
    QCOMPARE(spy.count(), 0);
  }

  void
  formFieldValidationIsNotNull()
  {
    FormField f;
    QVERIFY(f.validation() != nullptr);
  }

  void
  formFieldValidationIsOwnedByField()
  {
    FormField f;
    QCOMPARE(f.validation()->parent(), &f);
  }

  // FormAttached tests
  void
  qmlAttachedPropertiesReturnsNonNull()
  {
    QObject       attachee;
    FormAttached* att = Form::qmlAttachedProperties(&attachee);
    QVERIFY(att != nullptr);
    delete att; // we own it (created outside the QML engine)
  }

  void
  attachedObjectOwnedByAttachee()
  {
    QObject       attachee;
    FormAttached* att = Form::qmlAttachedProperties(&attachee);
    QCOMPARE(att->parent(), &attachee);
    // att is deleted when attachee goes out of scope via parent-child ownership
  }

  void
  differentObjectsGetDifferentInstances()
  {
    QObject       a, b;
    FormAttached* attA = Form::qmlAttachedProperties(&a);
    FormAttached* attB = Form::qmlAttachedProperties(&b);
    QVERIFY(attA != attB);
    delete attA;
    delete attB;
  }

  void
  validateClearsErrorForOptionalEmptyField()
  {
    FormAttached a;
    a.setLabel(QStringLiteral("Display Name"));
    a.setRequired(false);
    a.validate(QStringLiteral(""));
    QVERIFY(a.error().isEmpty());
  }

  void
  validateSetsErrorForRequiredEmptyField()
  {
    FormAttached a;
    a.setLabel(QStringLiteral("Email"));
    a.setRequired(true);
    a.validate(QStringLiteral(""));
    QCOMPARE(a.error(), QStringLiteral("Email is required"));
  }

  void
  validateClearsErrorWhenFieldFilled()
  {
    FormAttached a;
    a.setLabel(QStringLiteral("Email"));
    a.setRequired(true);
    a.validate(QStringLiteral(""));
    QVERIFY(!a.error().isEmpty());
    a.validate(QStringLiteral("user@example.com"));
    QVERIFY(a.error().isEmpty());
  }

  void
  errorChangedEmittedOnValidate()
  {
    FormAttached a;
    a.setLabel(QStringLiteral("Password"));
    a.setRequired(true);
    QSignalSpy spy(&a, &FormAttached::errorChanged);
    a.validate(QStringLiteral("")); // triggers error
    QCOMPARE(spy.count(), 1);
    a.validate(QStringLiteral("ok")); // clears error
    QCOMPARE(spy.count(), 2);
  }

  void
  errorNotEmittedWhenErrorUnchanged()
  {
    FormAttached a;
    a.setLabel(QStringLiteral("Email"));
    a.setRequired(true);
    a.validate(QStringLiteral("")); // sets error
    QSignalSpy spy(&a, &FormAttached::errorChanged);
    a.validate(QStringLiteral("")); // same error — no signal
    QCOMPARE(spy.count(), 0);
  }

  // Test pulse
  void
  defaultFrom()
  {
    Pulse p;
    QCOMPARE(p.from(), 0.2);
  }

  void
  defaultTo()
  {
    Pulse p;
    QCOMPARE(p.to(), 1.0);
  }

  void
  defaultDuration()
  {
    Pulse p;
    QCOMPARE(p.duration(), 1000);
  }

  void
  defaultRunning()
  {
    Pulse p;
    QVERIFY(p.running());
  }

  void
  setFromRoundtrip()
  {
    Pulse p;
    p.setFrom(0.0);
    QCOMPARE(p.from(), 0.0);
    p.setFrom(0.5);
    QCOMPARE(p.from(), 0.5);
  }

  void
  setToRoundtrip()
  {
    Pulse p;
    p.setTo(0.8);
    QCOMPARE(p.to(), 0.8);
  }

  void
  setDurationRoundtrip()
  {
    Pulse p;
    p.setDuration(2000);
    QCOMPARE(p.duration(), 2000);
  }

  void
  fromChangedEmitted()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::fromChanged);
    p.setFrom(0.0);
    QCOMPARE(spy.count(), 1);
  }

  void
  toChangedEmitted()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::toChanged);
    p.setTo(0.9);
    QCOMPARE(spy.count(), 1);
  }

  void
  durationChangedEmitted()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::durationChanged);
    p.setDuration(500);
    QCOMPARE(spy.count(), 1);
  }

  void
  runningChangedEmitted()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::runningChanged);
    p.setRunning(false);
    QCOMPARE(spy.count(), 1);
    p.setRunning(true);
    QCOMPARE(spy.count(), 2);
  }

  void
  fromNotEmittedForSameValue()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::fromChanged);
    p.setFrom(p.from());
    QCOMPARE(spy.count(), 0);
  }

  void
  toNotEmittedForSameValue()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::toChanged);
    p.setTo(p.to());
    QCOMPARE(spy.count(), 0);
  }

  void
  durationNotEmittedForSameValue()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::durationChanged);
    p.setDuration(p.duration());
    QCOMPARE(spy.count(), 0);
  }

  void
  runningNotEmittedForSameValue()
  {
    Pulse      p;
    QSignalSpy spy(&p, &Pulse::runningChanged);
    p.setRunning(p.running());
    QCOMPARE(spy.count(), 0);
  }

  void
  setRunningFalseStopsAnimation()
  {
    Pulse p;
    p.setRunning(false);
    QVERIFY(!p.running());
  }

  void
  setRunningTrueStartsAnimation()
  {
    Pulse p;
    p.setRunning(false);
    p.setRunning(true);
    QVERIFY(p.running());
  }

  void
  setTargetKeepsRunningFlag()
  {
    TargetObject obj;
    QQmlEngine   engine;
    QQmlProperty prop(&obj, QStringLiteral("value"), &engine);
    QVERIFY(prop.isValid());

    Pulse p;
    p.setTarget(prop);
    QVERIFY(p.running());
  }

  void
  setTargetWritesPropertyEventually()
  {
    TargetObject obj;
    QQmlEngine   engine;
    QQmlProperty prop(&obj, QStringLiteral("value"), &engine);
    QVERIFY(prop.isValid());

    Pulse p;
    p.setFrom(0.0);
    p.setTo(1.0);
    p.setDuration(200);
    p.setTarget(prop);

    QTest::qWait(60);

    const qreal v = obj.value();
    QVERIFY2(
      v >= 0.0 && v <= 1.0, qPrintable(QString("value %1 out of [0,1]").arg(v))
    );
  }

  // ToastManager tests
  void
  showSetsVisible()
  {
    ToastManager tm;
    tm.show("hello");
    QVERIFY(tm.visible());
  }

  void
  showSetsMessage()
  {
    ToastManager tm;
    tm.show("test message");
    QCOMPARE(tm.message(), QStringLiteral("test message"));
  }

  void
  showEmitsVisibleChanged()
  {
    ToastManager tm;
    QSignalSpy   spy(&tm, &ToastManager::visibleChanged);
    tm.show("hi");
    QCOMPARE(spy.count(), 1);
  }

  void
  showEmitsMessageChanged()
  {
    ToastManager tm;
    QSignalSpy   spy(&tm, &ToastManager::messageChanged);
    tm.show("msg");
    QVERIFY(spy.count() >= 1);
  }

  void
  showWithCustomDuration()
  {
    ToastManager tm;
    tm.show("quick", 100);
    QVERIFY(tm.visible());
    QCOMPARE(tm.duration(), 3000);
    QTest::qWait(250);
    QVERIFY(!tm.visible());
  }

  void
  dismissClearsVisible()
  {
    ToastManager tm;
    tm.show("x");
    QVERIFY(tm.visible());
    tm.dismiss();
    QVERIFY(!tm.visible());
  }

  void
  dismissEmitsVisibleChanged()
  {
    ToastManager tm;
    tm.show("x");
    QSignalSpy spy(&tm, &ToastManager::visibleChanged);
    tm.dismiss();
    QCOMPARE(spy.count(), 1);
  }

  void
  dismissWhenAlreadyHiddenIsNoop()
  {
    ToastManager tm;
    QSignalSpy   spy(&tm, &ToastManager::visibleChanged);
    tm.dismiss();
    QCOMPARE(spy.count(), 0);
    QVERIFY(!tm.visible());
  }

  void
  setDurationEmitsSignal()
  {
    ToastManager tm;
    QSignalSpy   spy(&tm, &ToastManager::durationChanged);
    tm.setDuration(1500);
    QCOMPARE(spy.count(), 1);
  }

  void
  setDurationSameValueNoSignal()
  {
    ToastManager tm;
    QSignalSpy   spy(&tm, &ToastManager::durationChanged);
    tm.setDuration(tm.duration());
    QCOMPARE(spy.count(), 0);
  }

  void
  autoDismissAfterDuration()
  {
    ToastManager tm;
    tm.setDuration(150);
    tm.show("auto");
    QVERIFY(tm.visible());
    QTest::qWait(350);
    QVERIFY(!tm.visible());
  }

  void
  repeatedShowRestartsTimer()
  {
    ToastManager tm;
    tm.setDuration(200);
    tm.show("first");
    QTest::qWait(100);
    tm.show("second");
    QTest::qWait(100);
    QVERIFY(tm.visible());
    QTest::qWait(200);
    QVERIFY(!tm.visible());
  }

  // UndoStack tests
  void
  pushIncreasesCount()
  {
    UndoStack s;
    s.push("a");
    QCOMPARE(s.count(), 1);
    s.push("b");
    QCOMPARE(s.count(), 2);
  }

  void
  pushMakesCanUndoTrue()
  {
    UndoStack s;
    s.push("x");
    QVERIFY(s.canUndo());
  }

  void
  pushSetsUndoText()
  {
    UndoStack s;
    s.push("Delete item");
    QCOMPARE(s.undoText(), QStringLiteral("Delete item"));
  }

  void
  pushClearsRedoHistory()
  {
    UndoStack s;
    s.push("a");
    s.push("b");
    s.undo();
    QVERIFY(s.canRedo());
    s.push("c");
    QVERIFY(!s.canRedo());
    QCOMPARE(s.count(), 2);
  }

  void
  pushEmitsCountChanged()
  {
    UndoStack  s;
    QSignalSpy spy(&s, &UndoStack::countChanged);
    s.push("x");
    QCOMPARE(spy.count(), 1);
  }

  void
  pushEmitsCanUndoChanged()
  {
    UndoStack  s;
    QSignalSpy spy(&s, &UndoStack::canUndoChanged);
    s.push("x");
    QCOMPARE(spy.count(), 1);
    s.push("y");
    QCOMPARE(spy.count(), 1);
  }

  void
  pushEmitsUndoTextChanged()
  {
    UndoStack  s;
    QSignalSpy spy(&s, &UndoStack::undoTextChanged);
    s.push("first");
    QCOMPARE(spy.count(), 1);
    s.push("second");
    QCOMPARE(spy.count(), 2);
  }

  void
  undoDecrementsIndex()
  {
    UndoStack s;
    s.push("a");
    s.push("b");
    s.undo();
    QCOMPARE(s.undoText(), QStringLiteral("a"));
  }

  void
  undoEmitsUndoneSignal()
  {
    UndoStack s;
    s.push("Delete row");
    QSignalSpy spy(&s, &UndoStack::undone);
    s.undo();
    QCOMPARE(spy.count(), 1);
    const QList<QVariant> args = spy.takeFirst();
    QCOMPARE(args.at(0).toString(), QStringLiteral("Delete row"));
  }

  void
  undoMakesCanRedoTrue()
  {
    UndoStack s;
    s.push("x");
    s.undo();
    QVERIFY(s.canRedo());
  }

  void
  undoWhenEmptyIsNoop()
  {
    UndoStack  s;
    QSignalSpy spy(&s, &UndoStack::undone);
    s.undo();
    QCOMPARE(spy.count(), 0);
    QVERIFY(!s.canUndo());
  }

  void
  undoTextUpdatesAfterUndo()
  {
    UndoStack s;
    s.push("a");
    s.push("b");
    s.undo();
    QCOMPARE(s.undoText(), QStringLiteral("a"));
    s.undo();
    QVERIFY(s.undoText().isEmpty());
    QVERIFY(!s.canUndo());
  }

  void
  redoIncrementsIndex()
  {
    UndoStack s;
    s.push("a");
    s.undo();
    s.redo();
    QVERIFY(s.canUndo());
    QVERIFY(!s.canRedo());
  }

  void
  redoEmitsRedonedSignal()
  {
    UndoStack s;
    s.push("Add row");
    s.undo();
    QSignalSpy spy(&s, &UndoStack::redone);
    s.redo();
    QCOMPARE(spy.count(), 1);
    const QList<QVariant> args = spy.takeFirst();
    QCOMPARE(args.at(0).toString(), QStringLiteral("Add row"));
  }

  void
  redoWhenNothingToRedoIsNoop()
  {
    UndoStack s;
    s.push("x");
    QSignalSpy spy(&s, &UndoStack::redone);
    s.redo();
    QCOMPARE(spy.count(), 0);
  }

  void
  redoAfterUndoRestoresCanUndo()
  {
    UndoStack s;
    s.push("x");
    s.undo();
    QVERIFY(!s.canUndo());
    s.redo();
    QVERIFY(s.canUndo());
  }

  void
  clearResetsAll()
  {
    UndoStack s;
    s.push("a");
    s.push("b");
    s.clear();
    QCOMPARE(s.count(), 0);
    QVERIFY(!s.canUndo());
    QVERIFY(!s.canRedo());
    QVERIFY(s.undoText().isEmpty());
    QVERIFY(s.redoText().isEmpty());
  }

  void
  clearWhenEmptyIsNoop()
  {
    UndoStack  s;
    QSignalSpy spy(&s, &UndoStack::countChanged);
    s.clear();
    QCOMPARE(spy.count(), 0);
  }

  void
  clearEmitsCountChanged()
  {
    UndoStack s;
    s.push("x");
    QSignalSpy spy(&s, &UndoStack::countChanged);
    s.clear();
    QCOMPARE(spy.count(), 1);
  }

  void
  undoRedoSequence()
  {
    UndoStack s;
    s.push("step1");
    s.push("step2");
    s.push("step3");

    QCOMPARE(s.undoText(), QStringLiteral("step3"));
    s.undo();
    QCOMPARE(s.undoText(), QStringLiteral("step2"));
    QCOMPARE(s.redoText(), QStringLiteral("step3"));
    s.undo();
    QCOMPARE(s.undoText(), QStringLiteral("step1"));
    s.redo();
    QCOMPARE(s.undoText(), QStringLiteral("step2"));
    QCOMPARE(s.redoText(), QStringLiteral("step3"));
  }

  void
  pushAfterUndoDiscardsRedo()
  {
    UndoStack s;
    s.push("a");
    s.push("b");
    s.undo();
    QCOMPARE(s.redoText(), QStringLiteral("b"));
    s.push("c");
    QVERIFY(!s.canRedo());
    QCOMPARE(s.undoText(), QStringLiteral("c"));
    QCOMPARE(s.count(), 2);
  }

  void
  payloadRoundtrip()
  {
    UndoStack  s;
    QSignalSpy spy(&s, &UndoStack::undone);
    s.push("Delete", QVariant(42));
    s.undo();
    QCOMPARE(spy.count(), 1);
    const QList<QVariant> args = spy.takeFirst();
    QCOMPARE(args.at(1).toInt(), 42);
  }

  // Gui app test
  void
  isGuiApp()
  {
    QVERIFY(qGuiApp != nullptr);
  }
};

QTEST_MAIN(QmlAdvCoreTests)