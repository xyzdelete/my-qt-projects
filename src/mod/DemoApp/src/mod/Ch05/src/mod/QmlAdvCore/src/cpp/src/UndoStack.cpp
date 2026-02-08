#include "undostack.hpp"

UndoStack::UndoStack(QObject* parent)
  : QObject(parent)
{
}

void
UndoStack::push(const QString& description, const QVariant& data)
{
  const bool    prevCanUndo{this->canUndo()};
  const bool    prevCanRedo{this->canRedo()};
  const QString prevUndoText{this->undoText()};
  const QString prevRedoText{this->redoText()};
  const int     prevCount{this->count()};

  while (this->m_stack.size() > m_index + 1)
  {
    this->m_stack.removeLast();
  }

  this->m_stack.append({description, data});
  this->m_index = m_stack.size() - 1;

  this->emitStateChange(
    prevCanUndo, prevCanRedo, prevUndoText, prevRedoText, prevCount
  );
}

void
UndoStack::undo()
{
  if (!this->canUndo())
  {
    return;
  }

  const bool    prevCanUndo{this->canUndo()};
  const bool    prevCanRedo{this->canRedo()};
  const QString prevUndoText{this->undoText()};
  const QString prevRedoText{this->redoText()};
  const int     prevCount{this->count()};

  const Command& cmd{m_stack.at(m_index)};
  const QString  desc{cmd.description};
  const QVariant dat{cmd.data};
  --this->m_index;

  this->emitStateChange(
    prevCanUndo, prevCanRedo, prevUndoText, prevRedoText, prevCount
  );
  emit this->undone(desc, dat);
}

void
UndoStack::redo()
{
  if (!this->canRedo())
  {
    return;
  }

  const bool    prevCanUndo{this->canUndo()};
  const bool    prevCanRedo{this->canRedo()};
  const QString prevUndoText{this->undoText()};
  const QString prevRedoText{this->redoText()};
  const int     prevCount{this->count()};

  ++this->m_index;
  const Command& cmd{m_stack.at(this->m_index)};
  const QString  desc{cmd.description};
  const QVariant dat{cmd.data};

  this->emitStateChange(
    prevCanUndo, prevCanRedo, prevUndoText, prevRedoText, prevCount
  );
  emit this->redone(desc, dat);
}

void
UndoStack::clear()
{
  if (this->m_stack.isEmpty())
  {
    return;
  }

  const bool    prevCanUndo{this->canUndo()};
  const bool    prevCanRedo{this->canRedo()};
  const QString prevUndoText{this->undoText()};
  const QString prevRedoText{this->redoText()};
  const int     prevCount{this->count()};

  this->m_stack.clear();
  this->m_index = -1;

  this->emitStateChange(
    prevCanUndo, prevCanRedo, prevUndoText, prevRedoText, prevCount
  );
}

bool
UndoStack::canUndo() const
{
  return this->m_index >= 0;
}

bool
UndoStack::canRedo() const
{
  return this->m_index < this->m_stack.size() - 1;
}

QString
UndoStack::undoText() const
{
  return this->canUndo() ? this->m_stack.at(this->m_index).description
                         : QString{};
}

QString
UndoStack::redoText() const
{
  return this->canRedo() ? this->m_stack.at(this->m_index + 1).description
                         : QString{};
}

int
UndoStack::count() const
{
  return this->m_stack.size();
}

void
UndoStack::emitStateChange(
  bool           prevCanUndo,
  bool           prevCanRedo,
  const QString& prevUndoText,
  const QString& prevRedoText,
  int            prevCount
)
{
  if (this->canUndo() != prevCanUndo)
  {
    emit this->canUndoChanged();
  }
  if (this->canRedo() != prevCanRedo)
  {
    emit this->canRedoChanged();
  }
  if (this->undoText() != prevUndoText)
  {
    emit this->undoTextChanged();
  }
  if (this->redoText() != prevRedoText)
  {
    emit this->redoTextChanged();
  }
  if (this->count() != prevCount)
  {
    emit this->countChanged();
  }
}