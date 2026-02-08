#include "theme.hpp"

Theme::Theme(QObject* parent)
  : QObject{parent}
{
}

ColorPalette*
Theme::colors() const
{
  return this->m_colors;
}

SpacingGroup*
Theme::spacing() const
{
  return this->m_spacing;
}