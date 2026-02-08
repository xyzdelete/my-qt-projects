#include "version.hpp"

Version::Version(QObject* parent)
  : QObject{parent}
{
}

QString
Version::string() const
{
  return QStringLiteral("1.0.0.0");
}