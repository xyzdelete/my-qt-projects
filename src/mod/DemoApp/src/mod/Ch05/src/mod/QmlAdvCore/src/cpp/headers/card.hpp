#pragma once

#include <QQmlListProperty>
#include <QQuickItem>
#include <QtQml/qqmlregistration.h>

class Card : public QQuickItem
{
  Q_OBJECT
  QML_ELEMENT
  Q_CLASSINFO("DefaultProperty", "contentItems")

  Q_PROPERTY(
    QQmlListProperty<QQuickItem> contentItems READ contentItems NOTIFY
      contentItemsChanged
  )
  Q_PROPERTY(int padding READ padding WRITE setPadding NOTIFY paddingChanged)
  Q_PROPERTY(int spacing READ spacing WRITE setSpacing NOTIFY spacingChanged)
public:
  explicit Card(QQuickItem* parent = nullptr);
  QQmlListProperty<QQuickItem>
  contentItems();

  int
  padding() const;
  void
  setPadding(const int& padding);

  int
  spacing() const;
  void
  setSpacing(const int& spacing);

signals:
  void
  contentItemsChanged();
  void
  paddingChanged();
  void
  spacingChanged();

protected:
  void
  componentComplete() override;
  void
  geometryChange(const QRectF& newGeometry, const QRectF& oldGeometry) override;
  void
  updatePolish() override;

private:
  void
  layoutItems();

  QList<QQuickItem*> m_items;
  int                m_padding{8};
  int                m_spacing{8};

  static void
  appendItem(QQmlListProperty<QQuickItem>* list, QQuickItem* item);

  static qsizetype
  itemCount(QQmlListProperty<QQuickItem>* list);
  static QQuickItem*
  itemAt(QQmlListProperty<QQuickItem>* list, qsizetype index);
  static void
  clearItems(QQmlListProperty<QQuickItem>* list);
};