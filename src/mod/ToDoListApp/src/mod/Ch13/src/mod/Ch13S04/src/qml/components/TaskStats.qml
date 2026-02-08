pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Item {
  id: root
  height: 100

  required property int totalTasks
  required property int completedTasks
  required property int remainingTasks
  required property bool hasCompleted
  required property color backgroundColor
  required property color textColor
  required property color primaryColor
  required property color dangerColor
  required property bool darkMode

  readonly property int fontPixelSize: 14
  readonly property int spacing: 10
  readonly property int margins: 10
  readonly property int radius: 10
  readonly property int animationDuration: 250

  signal clearCompleted

  Rectangle {
    anchors.fill: parent
    color: root.backgroundColor
    radius: root.radius
    border.color: root.textColor
    border.width: 1

    RowLayout {
      anchors.fill: parent
      anchors.margins: root.margins
      spacing: root.spacing

      // Statistics text
      Column {
        Layout.fillWidth: true
        spacing: root.spacing

        Text {
          text: root.totalTasks === 1 ? qsTr("%1 task:").arg(root.totalTasks) : qsTr("%1 tasks:").arg(root.totalTasks)
          color: root.textColor
          font.pixelSize: root.fontPixelSize
          font.weight: Font.Medium
        }
        Text {
          text: root.completedTasks > 0 ? qsTr("%1 completed\n%2 remaining").arg(root.completedTasks).arg(root.remainingTasks) : qsTr("0 completed")
          color: root.textColor
          font.pixelSize: root.fontPixelSize
        }
      }
      Button {
        id: clearButton
        text: qsTr("Clear Completed")
        enabled: root.hasCompleted
        Behavior on enabled {
          NumberAnimation {
            duration: root.animationDuration
          }
        }
        opacity: root.hasCompleted ? 1.0 : 0.4
        Behavior on opacity {
          NumberAnimation {
            duration: root.animationDuration
          }
        }
        background: Rectangle {
          color: clearButton.pressed ? "#2dad93" : (clearButtonHoverHandler.hovered && clearButton.enabled ? Qt.lighter("#2dad93", 1.1) : "#c4ced9")

          border.color: root.dangerColor
          border.width: 1
          radius: root.radius
        }

        contentItem: Text {
          anchors.fill: parent
          text: "Clear Completed"
          font.pixelSize: root.fontPixelSize
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
