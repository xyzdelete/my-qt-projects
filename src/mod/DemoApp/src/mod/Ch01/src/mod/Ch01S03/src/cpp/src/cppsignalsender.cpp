#include "cppsignalsender.hpp"

CppSignalSender::CppSignalSender(QObject* const parent)
  : QObject{parent}
{
  connect(
    &this->m_timer,
    &QTimer::timeout,
    this,
    [this]()
    {
      ++this->m_value;
      emit this->cppTimer(QString::number(m_value));
    }
  );
  this->m_timer.start(1000);
}

void
CppSignalSender::cppSlot()
{
  emit this->callQml("Message from C++");
}