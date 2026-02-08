#include "pulse.hpp"

Pulse::Pulse(QObject* parent)
  : QObject{parent}
{
  this->m_group->addAnimation(this->m_forward);
  this->m_group->addAnimation(this->m_reverse);
  m_group->setLoopCount(-1);

  auto writeTarget = [this](const QVariant& v)
  {
    if (this->m_target.isValid())
    {
      this->m_target.write(v);
    }
  };

  this->connect(
    this->m_forward, &QVariantAnimation::valueChanged, this, writeTarget
  );
  this->connect(m_reverse, &QVariantAnimation::valueChanged, this, writeTarget);

  this->rebuildAnimation();
}

Pulse::~Pulse() = default;

void
Pulse::setTarget(const QQmlProperty& property)
{
  this->m_target = property;
  this->rebuildAnimation();

  if (this->m_running)
  {
    this->m_group->start();
  }
}

qreal
Pulse::from() const
{
  return this->m_from;
}

void
Pulse::setFrom(const qreal& from)
{
  if (qFuzzyCompare(this->m_from, from))
  {
    return;
  }
  this->m_from = from;
  this->rebuildAnimation();
  emit this->fromChanged();
}

qreal
Pulse::to() const
{
  return this->m_to;
}

void
Pulse::setTo(const qreal& to)
{
  if (qFuzzyCompare(this->m_to, to))
  {
    return;
  }

  this->m_to = to;
  this->rebuildAnimation();
  emit this->toChanged();
}

int
Pulse::duration() const
{
  return this->m_duration;
}

void
Pulse::setDuration(const int& duration)
{
  if (this->m_duration == duration)
  {
    return;
  }

  this->m_duration = duration;
  this->rebuildAnimation();
  emit this->durationChanged();
}

bool
Pulse::running() const
{
  return this->m_running;
}

void
Pulse::setRunning(const bool& running)
{
  if (this->m_running == running)
  {
    return;
  }

  this->m_running = running;
  if (this->m_running)
  {
    this->m_group->start();
  }
  else
  {
    this->m_group->stop();
  }

  emit this->runningChanged();
}

void
Pulse::rebuildAnimation()
{
  const bool wasRunning{
    (this->m_group->state() == QAbstractAnimation::Running)
  };

  this->m_group->stop();

  this->m_forward->setStartValue(this->m_from);
  this->m_forward->setEndValue(this->m_to);
  this->m_forward->setDuration(this->m_duration / 2);
  this->m_forward->setEasingCurve(QEasingCurve::InOutSine);

  this->m_reverse->setStartValue(this->m_to);
  this->m_reverse->setEndValue(this->m_from);
  this->m_reverse->setDuration(this->m_duration / 2);
  this->m_reverse->setEasingCurve(QEasingCurve::InOutSine);

  if (wasRunning || (this->m_running && this->m_target.isValid()))
  {
    this->m_group->start();
  }
}