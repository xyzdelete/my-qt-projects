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
  property color cardColor: darkMode ? '#394470' : '#e9edf1'
  property color dangerColor: "#2dad93"
  property bool darkMode: false

  TaskListModel {
    id: taskModel
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
    anchors.margins: 10
    spacing: 10

    AddTaskBar {
      id: addTaskBar
      Layout.fillWidth: true
      Layout.preferredHeight: addTaskBar.height
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
      radius: 10
      border.width: 1
      border.color: root.textColor

      ScrollView {
        anchors.fill: parent
        anchors.margins: 1
        clip: true

        ListView {
          id: taskListView
          model: taskModel
          spacing: 10
          anchors.margins: 10

          displaced: Transition {
            NumberAnimation {
              properties: "x,y,opacity"
              duration: 250
            }
          }

          add: Transition {
            NumberAnimation {
              properties: "x,y,opacity"
              duration: 250
            }
          }

          remove: Transition {
            NumberAnimation {
              properties: "opacity"
              duration: 250
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
              spacing: 10

              Button {
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                  color: "transparent"
                }
                icon.source: "qrc:/qt/qml/Ch12S13/src/resrc/images/tasks.svg"
                icon.color: "transparent"

                SequentialAnimation on y {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0
                    to: -5
                    duration: 1000
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: -5
                    to: 0
                    duration: 1000
                    easing.type: Easing.InOutSine
                  }
                }
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No tasks")
                color: root.textColor
                font.pixelSize: 18
                font.weight: Font.Medium
                opacity: 0.3

                SequentialAnimation on opacity {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0.4
                    to: 1.0
                    duration: 2000
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: 1.0
                    to: 0.4
                    duration: 2000
                    easing.type: Easing.InOutSine
                  }
                }
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add a task above to get started")
                color: root.textColor
                font.pixelSize: 14
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.3

                SequentialAnimation on opacity {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0.4
                    to: 1
                    duration: 2000
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: 1
                    to: 0.4
                    duration: 2000
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
      Layout.preferredHeight: taskStatsId.height
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
