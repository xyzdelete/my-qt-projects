pragma ComponentBehavior: Bound
import QtQuick

Item {
  id: root

  readonly property string baseUrl: "http://localhost:3001"

  signal tasksLoaded(var tasks)
  signal taskCreated(var task)
  signal taskUpdated(var task)
  signal taskDeleted(string taskId)
  signal settingsLoaded(var settings)
  signal settingsUpdated(var settings)
  signal error(string message)

  Component.onCompleted: function () {
    root.checkConnection();
  }

  function checkConnection() {
    root.performRequest("GET", "/health", null, function (response) {
      print("API connection established");
    }, function (error) {
      print("API connection failed:", error);
      root.error("Cannot connect to API server at " + root.baseUrl);
    });
  }

  function loadTasks() {
    performRequest("GET", "/api/tasks", null, function (response) {
      try {
        let data = JSON.parse(response);
        let tasks = data.data || [];
        print("Tasks loaded from API:", tasks.length, "tasks");
        root.tasksLoaded(tasks);
      } catch (e) {
        print("Error parsing tasks response:", e);
        root.error("Failed to parse tasks data");
      }
    }, function (error) {
      print("Error loading tasks:", error);
      root.error("Failed to load tasks from server");
    });
  }

  function createTask(title) {
    if (!title || title.trim().length === 0) {
      root.error("Task title cannot be empty");
      return;
    }

    let taskData = {
      title: title.trim()
    };

    root.performRequest("POST", "/api/tasks", taskData, function (response) {
      try {
        let data = JSON.parse(response);
        let task = data.data;
        print("Task created:", task.title);
        root.taskCreated(task);
      } catch (e) {
        print("Error parsing create task response:", e);
        root.error("Failed to parse server response");
      }
    }, function (error) {
      print("Error creating task:", error);
      root.error("Failed to create task");
    });
  }

  function updateTask(taskId, updates) {
    if (!taskId) {
      root.error("Task ID is required for update");
      return;
    }

    performRequest("PUT", "/api/tasks/" + taskId, updates, function (response) {
      try {
        let data = JSON.parse(response);
        let task = data.data;
        print("Task updated:", task.id);
        root.taskUpdated(task);
      } catch (e) {
        print("Error parsing update task response:", e);
        root.error("Failed to parse server response");
      }
    }, function (error) {
      print("Error updating task:", error);
      root.error("Failed to update task");
    });
  }

  function deleteTask(taskId) {
    if (!taskId) {
      root.error("Task ID is required for deletion");
      return;
    }

    performRequest("DELETE", "/api/tasks/" + taskId, null, function (response) {
      print("Task deleted:", taskId);
      root.taskDeleted(taskId);
    }, function (error) {
      print("Error deleting task:", error);
      root.error("Failed to delete task");
    });
  }

  function loadSettings() {
    performRequest("GET", "/api/settings", null, function (response) {
      try {
        let data = JSON.parse(response);
        let settings = data.data;
        print("Settings loaded from API");
        root.settingsLoaded(settings);
      } catch (e) {
        print("Error parsing settings response", e);
        root.error("Failed to parse settings data");
      }
    }, function (error) {
      print("Error loading settings:", error);
      root.error("Failed to load settings from server");
    });
  }

  function updateSettings(settings) {
    performRequest("PUT", "/api/settings", settings, function (response) {
      try {
        let data = JSON.parse(response);
        let updatedSettings = data.data;
        print("Settings updated");
        root.settingsUpdated(updatedSettings);
      } catch (e) {
        print("Error parsing update settings response:", e);
        root.error("Failed to parse server response");
      }
    }, function (error) {
      print("Error updating settings:", error);
      root.error("Failed to update settings");
    });
  }

  function performRequest(method, endpoint, data, successCallback, errorCallback) {
    var xhr = new XMLHttpRequest();
    let url = root.baseUrl + endpoint;

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status >= 200 && xhr.status < 300) {
          if (successCallback) {
            successCallback(xhr.responseText);
          }
        } else {
          let errorMessage = "HTTP " + xhr.status;
          try {
            let errorData = JSON.parse(xhr.responseText);
            errorMessage = errorData.error || errorMessage;
          } catch (e) {
            // Use default error message
          }
          if (errorCallback) {
            errorCallback(errorMessage);
          }
        }
      }
    };

    xhr.open(method, url, true);
    xhr.setRequestHeader("Content-Type", "application/json");

    if (data) {
      xhr.send(JSON.stringify(data));
    } else {
      xhr.send();
    }
  }

  Rectangle {}
}
