pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  height: 120

  required property int totalTasks
  required property int completedTasks
  required property int remainingTasks
  required property bool hasCompleted
  required property color backgroundColor
  required property color textColor
  required property color primaryColor
  required property color dangerColor
  required property bool darkMode

  signal clearCompleted

  Rectangle {
    anchors.fill: parent
    color: root.backgroundColor
    radius: 10
    border.color: root.textColor
    border.width: 1

    RowLayout {
      anchors.fill: parent
      anchors.margins: 15
      spacing: 15

      // Statistics text
      Column {
        Layout.fillWidth: true
        spacing: 5

        Text {
          text: root.totalTasks === 1 ? qsTr("%1 task").arg(root.totalTasks) : qsTr("%1 tasks").arg(root.totalTasks)
          color: root.textColor
          font.pixelSize: 16
          font.weight: Font.Medium
        }
        Text {
          text: root.completedTasks > 0 ? qsTr("%1 completed, %2 remaining").arg(root.completedTasks).arg(root.remainingTasks) : qsTr("No tasks completed")
          color: root.textColor
          font.pixelSize: 14
        }

        Button {
          id: clearButton
          text: qsTr("Clear Completed")
          enabled: root.hasCompleted
          Behavior on enabled {
            NumberAnimation {
              duration: 250
            }
          }
          opacity: root.hasCompleted ? 1.0 : 0.4
          Behavior on opacity {
            NumberAnimation {
              duration: 250
            }
          }
          background: Rectangle {
            color: clearButton.pressed ? "#2dad93" : (clearButtonHoverHandler.hovered && clearButton.enabled ? Qt.lighter("#2dad93", 1.1) : "#c4ced9")

            border.color: root.dangerColor
            border.width: 1
            radius: 10
          }

          contentItem: Text {
            anchors.fill: parent
            text: "Clear Completed"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          onClicked: function () {
            root.clearCompleted();
          }

          HoverHandler {
            id: clearButtonHoverHandler
            cursorShape: Qt.PointingHandCursor
          }
        }
      }
    }
  }
}
