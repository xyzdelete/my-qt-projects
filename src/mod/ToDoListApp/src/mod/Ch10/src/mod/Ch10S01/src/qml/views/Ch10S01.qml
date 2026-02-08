pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  // Theme properties
  property color backgroundColor: darkMode ? '#414864' : "#f0f2f5"
  property color primaryColor: '#a6b2bf'
  property color textColor: darkMode ? "#ffffff" : "#000000"
  property color cardColor: darkMode ? '#54739f' : '#e9edf1'
  property bool darkMode: false

  Component {
    id: headerComponent
    AppHeader {
      id: header
      // Layout.fillWidth: true
      textColor: root.textColor
      darkMode: root.darkMode
      backgroundColor: root.backgroundColor
      onToggleDarkMode: function () {
        root.darkMode = !root.darkMode;
      }
    }
  }

  // Background
  Rectangle {
    anchors.fill: parent
    color: root.backgroundColor
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    AddTaskBar {
      id: addTaskBar
      Layout.fillWidth: true
      Layout.preferredHeight: height
      backgroundColor: root.backgroundColor
      textColor: root.textColor
      primaryColor: root.primaryColor
      darkMode: root.darkMode
    }

    TaskItem {
      id: testTaskItem
      Layout.fillWidth: true
      Layout.preferredHeight: height
      taskTitle: "Sample Task Item"
      taskDone: false
      backgroundColor: root.cardColor
      textColor: root.textColor
      primaryColor: root.primaryColor
      darkMode: root.darkMode
      onToggleDone: function () {
        testTaskItem.taskDone = !testTaskItem.taskDone;
      }
      onDeleteTask: function () {
        ApplicationWindow.window.title = "Delete task clicked";
      }
    }

    // Add a spacer to push things up
    Item {
      Layout.fillHeight: true
    }
  }

  Component.onCompleted: function () {
    const win = ApplicationWindow.window;
    if (win) {
      win.header = headerComponent.createObject(win);
    }
  }
}
