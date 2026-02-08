pragma ComponentBehavior: Bound
import QtQuick

Item {
  id: root

  signal storageInitialized

  // This signal should be used when useRESTServerBasedStorage: true
  // signal settingsLoaded(bool darkMode)

  property alias model: taskListModel
  property alias count: taskListModel.count

  required property bool useRESTServerBasedStorage

  ListModel {
    id: taskListModel
  }

  // useRESTServerBasedStorage: false
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

  // useRESTServerBasedStorage: true
  // RestStorage {
  //   id: storage

  //   onTasksLoaded: function (tasks) {
  //     root.loadTasksFromArray(tasks);
  //   }

  //   onTaskCreated: function (task) {
  //     taskListModel.append({
  //       "id": task.id,
  //       "title": task.title,
  //       "completed": task.completed || false
  //     });
  //   }

  //   onTaskUpdated: function (task) {
  //     for (let i = 0; i < taskListModel.count; i++) {
  //       if (taskListModel.get(i).id === task.id) {
  //         if (task.title !== undefined) {
  //           taskListModel.setProperty(i, "title", task.title);
  //         }
  //         if (task.completed !== undefined) {
  //           taskListModel.setProperty(i, "completed", task.completed);
  //         }
  //         break;
  //       }
  //     }
  //   }

  //   onTaskDeleted: function (taskId) {
  //     for (let i = 0; i < taskListModel.count; i++) {
  //       if (taskListModel.get(i).id === taskId) {
  //         taskListModel.remove(i);
  //         break;
  //       }
  //     }
  //   }

  //   onSettingsLoaded: function (settings) {
  //     print("Settings loaded:", JSON.stringify(settings));
  //     root.settingsLoaded(settings.darkMode || false);
  //   }

  //   onSettingsUpdated: function (settings) {
  //     print("Settings updated:", JSON.stringify(settings));
  //     root.settingsLoaded(settings.darkMode || false);
  //   }

  //   Component.onCompleted: {
  //     root.storageInitialized();
  //     storage.loadTasks();
  //   }
  // }

  function saveToStorage() {
    // LocalStorage
    storage.saveTasks(taskListModel);
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
      if (!root.useRESTServerBasedStorage) {
        // LocalStorage
        taskListModel.append({
          "title": title.trim(),
          "completed": false,
          "id": root.generateId()
        });
        root.saveToStorage();
      } else {
        // REST
        storage.createTask(title.trim());
      }
    }
  }

  function toggleTask(index) {
    if (index >= 0 && index < taskListModel.count) {
      if (!root.useRESTServerBasedStorage) {
        // LocalStorage
        taskListModel.setProperty(index, "completed", !taskListModel.get(index).completed);
        root.saveToStorage();
      } else {
        // REST
        let task = taskListModel.get(index);
        let newCompleted = !task.completed;
        storage.updateTask(task.id, {
          completed: newCompleted
        });
      }
    }
  }

  function deleteTask(index) {
    if (index >= 0 && index < taskListModel.count) {
      if (!root.useRESTServerBasedStorage) {
        // LocalStorage
        taskListModel.remove(index);
        root.saveToStorage();
      } else {
        // REST
        let task = taskListModel.get(index);
        storage.deleteTask(task.id);
      }
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
    if (!root.useRESTServerBasedStorage) {
      // LocalStorage
      for (let i = taskListModel.count - 1; i >= 0; i--) {
        if (taskListModel.get(i).completed) {
          taskListModel.remove(i);
        }
      }
      root.saveToStorage();
    } else {
      // REST
      let completedTasks = [];
      let i;
      for (i = 0; i < taskListModel.count; i++) {
        if (taskListModel.get(i).completed) {
          completedTasks.push(taskListModel.get(i).id);
        }
      }
      for (i = 0; i < completedTasks.length; i++) {
        root.deleteTask(i);
      }
    }
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
    // LocalStorage
    storage.clearStorage();
    taskListModel.clear();
  }

  function saveDarkMode(darkMode) {
    if (!root.useRESTServerBasedStorage) {
      // LocalStorage
      storage.saveDarkMode(darkMode);
    } else {
      // REST
      storage.updateSettings({
        darkMode: darkMode
      });
    }
  }

  function loadDarkMode() {
    if (!root.useRESTServerBasedStorage) {
      // LocalStorage
      return storage.loadDarkMode();
    } else {
      // REST
      storage.loadSettings();
    }
  }
}
