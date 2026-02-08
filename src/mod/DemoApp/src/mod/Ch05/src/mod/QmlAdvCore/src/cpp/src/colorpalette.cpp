#include "colorpalette.hpp"

ColorPalette::ColorPalette(QObject* parent)
  : QObject{parent}
{
}

QColor
ColorPalette::primary() const
{
  return this->m_primary;
}

void
ColorPalette::setPrimary(const QColor& color)
{
  if (this->m_primary == color)
  {
    return;
  }

  this->m_primary = color;
  emit this->primaryChanged();
}

QColor
ColorPalette::secondary() const
{
  return this->m_secondary;
}

void
ColorPalette::setSecondary(const QColor& color)
{
  if (this->m_secondary == color)
  {
    return;
  }

  this->m_secondary = color;
  emit this->secondaryChanged();
}

QColor
ColorPalette::surface() const
{
  return this->m_surface;
}

void
ColorPalette::setSurface(const QColor& color)
{
  if (this->m_surface == color)
  {
    return;
  }

  this->m_surface = color;
  emit this->surfaceChanged();
}

QColor
ColorPalette::onPrimary() const
{
  return this->m_onPrimary;
}

void
ColorPalette::setOnPrimary(const QColor& color)
{
  if (this->m_onPrimary == color)
  {
    return;
  }

  this->m_onPrimary = color;
  emit this->onPrimaryChanged();
}