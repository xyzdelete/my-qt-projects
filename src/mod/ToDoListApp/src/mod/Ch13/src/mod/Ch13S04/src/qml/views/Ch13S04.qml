pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Rectangle {
  id: root
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  // Theme properties
  readonly property color backgroundColor: darkMode ? '#414864' : "#f0f2f5"
  readonly property color primaryColor: '#a6b2bf'
  readonly property color textColor: darkMode ? "#ffffff" : "#000000"
  readonly property color cardColor: darkMode ? '#394470' : '#e9edf1'
  readonly property color dangerColor: "#2dad93"
  readonly property int spacing: 10
  readonly property int margins: 10
  readonly property int radius: 10
  readonly property int animationDuration: 250

  property bool darkMode: false

  TaskListModel {
    id: taskModel

    onStorageInitialized: function () {
      root.darkMode = taskModel.loadDarkMode();
    }
  }

  onDarkModeChanged: function () {
    taskModel.saveDarkMode(root.darkMode);
  }

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
    anchors.margins: root.margins
    spacing: root.spacing

    AddTaskBar {
      id: addTaskBar
      Layout.fillWidth: true
      backgroundColor: Qt.lighter(root.cardColor, 1.05)
      textColor: root.textColor
      primaryColor: root.primaryColor
      darkMode: root.darkMode

      onTaskAdded: function (taskText) {
        taskModel.addTask(taskText);
      }
    }

    // Tasks list
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: root.darkMode ? "#343e66" : root.cardColor
      radius: root.radius
      border.width: 1
      border.color: root.textColor

      ScrollView {
        anchors.fill: parent
        clip: true

        ListView {
          id: taskListView
          model: taskModel.model

          displaced: Transition {
            NumberAnimation {
              properties: "x,y,opacity"
              duration: root.animationDuration
            }
          }

          add: Transition {
            NumberAnimation {
              properties: "x,y,opacity"
              duration: root.animationDuration
            }
          }

          remove: Transition {
            NumberAnimation {
              properties: "opacity"
              duration: root.animationDuration
              to: 0
            }
          }

          delegate: TaskItem {
            required property int index
            required property string title
            required property bool completed

            width: taskListView.width
            taskTitle: title
            taskDone: completed
            backgroundColor: Qt.lighter(root.cardColor, 1.05)
            textColor: root.textColor
            primaryColor: root.primaryColor
            darkMode: root.darkMode

            onToggleDone: function () {
              taskModel.toggleTask(index);
            }

            onDeleteTask: function () {
              taskModel.deleteTask(index);
            }
          }

          // Empty state
          Rectangle {
            anchors.centerIn: parent
            width: parent.width - 40
            height: 120
            color: "transparent"
            visible: taskListView.count === 0

            Column {
              anchors.centerIn: parent
              spacing: root.spacing

              Button {
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                  color: "transparent"
                }
                icon.source: "qrc:/qt/qml/Ch13S04/src/resrc/images/tasks.svg"
                icon.color: "transparent"

                SequentialAnimation on y {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0
                    to: -5
                    duration: root.animationDuration * 4
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: -5
                    to: 0
                    duration: root.animationDuration * 4
                    easing.type: Easing.InOutSine
                  }
                }
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No tasks")
                color: root.textColor
                font.pixelSize: 24
                font.weight: Font.Medium
                opacity: 0.3

                SequentialAnimation on opacity {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0.4
                    to: 1.0
                    duration: root.animationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: 1.0
                    to: 0.4
                    duration: root.animationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                }
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add a task above to get started")
                color: root.textColor
                font.pixelSize: 16
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.4

                SequentialAnimation on opacity {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0.4
                    to: 1
                    duration: root.animationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: 1
                    to: 0.4
                    duration: root.animationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                }
              }
            }
          }
        }
      }
    }

    // Task statistics
    TaskStats {
      id: taskStatsId
      Layout.fillWidth: true
      backgroundColor: Qt.lighter(root.cardColor, 1.05)
      textColor: root.textColor
      primaryColor: root.primaryColor
      dangerColor: root.dangerColor
      darkMode: root.darkMode
      totalTasks: taskModel.getStats().total
      completedTasks: taskModel.getStats().completed
      remainingTasks: taskModel.getStats().remaining
      hasCompleted: taskModel.hasCompletedTasks()

      onClearCompleted: function () {
        taskModel.clearCompletedTasks();
      }
    }
  }

  Component.onCompleted: function () {
    const win = ApplicationWindow.window;
    if (win) {
      win.header = headerComponent.createObject(win);
    }
  }
}
