#pragma once

#include <QObject>

class Movie : public QObject
{
  Q_OBJECT
  Q_PROPERTY(
    QString mainCharacter READ mainCharacter WRITE setMainCharacter NOTIFY
      mainCharacterChanged
  )
  Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
public:
  explicit Movie(QObject* const parent = nullptr);
  QString
  mainCharacter() const;
  void
  setMainCharacter(const QString& newMainCharacter);
  QString
  title() const;
  void
  setTitle(const QString& newTitle);
signals:
  void
  mainCharacterChanged();
  void
  titleChanged();

private:
  QString m_mainCharacter;
  QString m_title;
};