pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ListModel {
  id: root

  // Add some sample tasks
  Component.onCompleted: function () {
    root.addTask("Learn Qt Qml");
    root.addTask("Build a ToDoTasksApp");
    root.addTask("Practice QML components");
  }

  function addTask(title) {
    if (title && title.trim().length > 0) {
      root.append({
        "title": title.trim(),
        "completed": false,
        "id": root.generateId()
      });
    }
  }

  function toggleTask(index) {
    if (index >= 0 && index < root.count) {
      root.setProperty(index, "completed", !root.get(index).completed);
    }
  }

  function deleteTask(index) {
    if (index >= 0 && index < count) {
      root.remove(index);
    }
  }

  function deleteTaskById(taskId) {
    for (let i = 0; i < root.count; i++) {
      if (root.get(i).id === taskId) {
        root.remove(i);
        break;
      }
    }
  }

  function clearCompletedTasks() {
    for (let i = root.count - 1; i >= 0; i--) {
      if (root.get(i).completed) {
        root.remove(i);
      }
    }
  }

  function getStats() {
    let total = root.count;
    let completed = 0;

    for (let i = 0; i < total; i++) {
      if (root.get(i).completed) {
        completed++;
      }
    }

    return {
      "total": total,
      "completed": completed,
      "remaining": total - completed
    };
  }

  function hasCompletedTasks() {
    for (let i = 0; i < root.count; i++) {
      if (root.get(i).completed) {
        return true;
      }
    }
    return false;
  }

  function generateId() {
    return Date.now() + Math.random().toString(36).substr(2, 9);
  }
}
