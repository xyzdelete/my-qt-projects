#pragma once

#include "colorpalette.hpp"
#include "spacinggroup.hpp"
#include <QObject>
#include <QtQml/qqmlregistration.h>

class Theme : public QObject
{
  Q_OBJECT
  QML_ELEMENT
  QML_SINGLETON
  Q_PROPERTY(ColorPalette* colors READ colors CONSTANT)
  Q_PROPERTY(SpacingGroup* spacing READ spacing CONSTANT)
public:
  explicit Theme(QObject* parent = nullptr);

  ColorPalette*
  colors() const;
  SpacingGroup*
  spacing() const;

private:
  ColorPalette* m_colors{new ColorPalette{this}};
  SpacingGroup* m_spacing{new SpacingGroup{this}};
};