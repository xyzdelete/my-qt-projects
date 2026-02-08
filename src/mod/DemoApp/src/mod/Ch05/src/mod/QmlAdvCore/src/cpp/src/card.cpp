#include "card.hpp"

Card::Card(QQuickItem* parent)
  : QQuickItem{parent}
{
}

QQmlListProperty<QQuickItem>
Card::contentItems()
{
  return QQmlListProperty<QQuickItem>{
    this,
    &this->m_items,
    &Card::appendItem,
    &Card::itemCount,
    &Card::itemAt,
    &Card::clearItems
  };
}

int
Card::padding() const
{
  return this->m_padding;
}

void
Card::setPadding(const int& padding)
{
  if (this->m_padding == padding)
  {
    return;
  }
  this->m_padding = padding;
  emit this->paddingChanged();
  this->polish();
}

int
Card::spacing() const
{
  return this->m_spacing;
}

void
Card::setSpacing(const int& spacing)
{
  if (this->m_spacing == spacing)
  {
    return;
  }

  this->m_spacing = spacing;
  emit this->spacingChanged();
  this->polish();
}

void
Card::componentComplete()
{
  QQuickItem::componentComplete();
  this->layoutItems();
}

void
Card::geometryChange(const QRectF& newGeometry, const QRectF& oldGeometry)
{
  QQuickItem::geometryChange(newGeometry, oldGeometry);
  if (newGeometry.width() != oldGeometry.width())
  {
    this->polish();
  }
}

void
Card::updatePolish()
{
  this->layoutItems();
}

void
Card::layoutItems()
{
  if (!this->isComponentComplete())
  {
    return;
  }

  qreal       y{static_cast<qreal>(this->m_padding)};
  const qreal contentWidth{this->width() - 2.0 * this->m_padding};

  for (QQuickItem* item : std::as_const(this->m_items))
  {
    if (!item->isVisible())
    {
      continue;
    }

    item->setX(this->m_padding);
    item->setY(y);
    if (contentWidth > 0)
    {
      item->setWidth(contentWidth);
    }

    y += item->height() + this->m_spacing;
  }

  if (!m_items.isEmpty())
  {
    this->setImplicitHeight(y - this->m_spacing + this->m_padding);
  }
}

void
Card::appendItem(QQmlListProperty<QQuickItem>* list, QQuickItem* item)
{
  auto* card{qobject_cast<Card*>(list->object)};

  item->setParentItem(card);
  item->setParent(card);
  card->m_items.append(item);
  emit card->contentItemsChanged();
  card->polish();
}

qsizetype
Card::itemCount(QQmlListProperty<QQuickItem>* list)
{
  return qobject_cast<Card*>(list->object)->m_items.size();
}

QQuickItem*
Card::itemAt(QQmlListProperty<QQuickItem>* list, qsizetype index)
{
  return qobject_cast<Card*>(list->object)->m_items.at(index);
}

void
Card::clearItems(QQmlListProperty<QQuickItem>* list)
{
  auto* card{qobject_cast<Card*>(list->object)};
  for (QQuickItem* item : std::as_const(card->m_items))
  {
    item->setParentItem(nullptr);
    item->setParent(nullptr);
  }
  qDeleteAll(card->m_items);
  card->m_items.clear();
  emit card->contentItemsChanged();
  card->polish();
}