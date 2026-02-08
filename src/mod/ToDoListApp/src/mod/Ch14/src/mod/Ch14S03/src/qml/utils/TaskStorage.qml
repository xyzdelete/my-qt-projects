pragma ComponentBehavior: Bound
import QtQuick
import QtCore

Item {
  id: root

  signal tasksLoaded(var tasks)

  Settings {
    id: settings
    category: "Tasks"

    property string tasksData: "[]"
    property bool darkMode: false
  }

  function saveTasks(tasks) {
    try {
      // Convert ListModel data to a proper array
      let taskArray = [];
      for (let i = 0; i < tasks.count; i++) {
        let task = tasks.get(i);
        taskArray.push({
          id: task.id,
          title: task.title,
          completed: task.completed
        });
      }

      settings.tasksData = JSON.stringify(taskArray);
      settings.sync(); // Force save

      print("Tasks saved to storage:", taskArray.length, "tasks");
    } catch (error) {
      print("Error saving tasks:", error);
    }
  }

  function loadTasks() {
    try {
      if (settings.tasksData && settings.tasksData !== "[]") {
        let taskArray = JSON.parse(settings.tasksData);
        print("Tasks loaded from storage:", taskArray.length, "tasks");
        root.tasksLoaded(taskArray);
        return taskArray;
      } else {
        print("No saved tasks found, starting with empty list");
        root.tasksLoaded([]);
        return [];
      }
    } catch (error) {
      print("Error loading tasks:", error);
      root.tasksLoaded([]);
      return [];
    }
  }

  function saveDarkMode(darkMode) {
    settings.darkMode = darkMode;
    settings.sync();
    print("Theme setting saved");
  }

  function loadDarkMode() {
    return settings.darkMode;
  }

  function clearStorage() {
    settings.tasksData = "[]";
    settings.darkMode = false;
    settings.sync();
    print("Storage cleared");
  }
}
