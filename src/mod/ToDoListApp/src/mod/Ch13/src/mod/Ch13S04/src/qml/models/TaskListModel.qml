pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Item {
  id: root

  signal storageInitialized

  property alias model: taskListModel
  property alias count: taskListModel.count

  property bool autoSave: true

  ListModel {
    id: taskListModel
  }

  TaskStorage {
    id: storage

    onTasksLoaded: function (tasks) {
      root.loadTasksFromArray(tasks);
    }

    Component.onCompleted: {
      root.storageInitialized();
      storage.loadTasks();
    }
  }

  function saveToStorage() {
    if (autoSave) {
      storage.saveTasks(taskListModel);
    }
  }

  function loadTasksFromArray(taskArray) {
    taskListModel.clear();
    for (let i = 0; i < taskArray.length; i++) {
      let task = taskArray[i];
      taskListModel.append({
        "id": task.id || generateId(),
        "title": task.title || "",
        "completed": task.completed || false
      });
    }
  }

  function addTask(title) {
    if (title && title.trim().length > 0) {
      taskListModel.append({
        "title": title.trim(),
        "completed": false,
        "id": root.generateId()
      });
      root.saveToStorage();
    }
  }

  function toggleTask(index) {
    if (index >= 0 && index < taskListModel.count) {
      taskListModel.setProperty(index, "completed", !taskListModel.get(index).completed);
      root.saveToStorage();
    }
  }

  function deleteTask(index) {
    if (index >= 0 && index < taskListModel.count) {
      taskListModel.remove(index);
      root.saveToStorage();
    }
  }

  function deleteTaskById(taskId) {
    for (let i = 0; i < taskListModel.count; i++) {
      if (taskListModel.get(i).id === taskId) {
        taskListModel.remove(i);
        root.saveToStorage();
        break;
      }
    }
  }

  function clearCompletedTasks() {
    for (let i = taskListModel.count - 1; i >= 0; i--) {
      if (taskListModel.get(i).completed) {
        taskListModel.remove(i);
      }
    }
    root.saveToStorage();
  }

  function getStats() {
    let total = taskListModel.count;
    let completed = 0;

    for (let i = 0; i < total; i++) {
      if (taskListModel.get(i).completed) {
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
    for (let i = 0; i < taskListModel.count; i++) {
      if (taskListModel.get(i).completed) {
        return true;
      }
    }
    return false;
  }

  function get(index) {
    return taskListModel.get(index);
  }

  function generateId() {
    return Date.now() + Math.random().toString(36).substr(2, 9);
  }

  function clearAllData() {
    storage.clearStorage();
    taskListModel.clear();
  }

  function saveDarkMode(darkMode) {
    storage.saveDarkMode(darkMode);
  }

  function loadDarkMode() {
    return storage.loadDarkMode();
  }
}
