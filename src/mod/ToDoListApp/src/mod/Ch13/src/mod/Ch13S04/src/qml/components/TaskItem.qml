pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Item {
  id: root
  height: 100

  required property color backgroundColor
  required property color textColor
  required property color primaryColor
  required property bool darkMode
  required property string taskTitle
  required property bool taskDone

  signal toggleDone
  signal deleteTask

  // Constants for this component
  readonly property int fontPixelSize: 14
  readonly property int spacing: 10
  readonly property int itemHeight: 80
  readonly property int margins: 10
  readonly property int radius: 10
  readonly property int animationDuration: 250

  Rectangle {
    id: taskItemBackground
    anchors.fill: parent
    color: "transparent"

    Rectangle {
      id: itemBackground
      anchors.fill: parent
      anchors.margins: root.margins
      color: root.backgroundColor
      radius: root.radius
      border.color: root.darkMode ? "#ffffff" : "#000000"
      border.width: 1
      opacity: root.taskDone ? 0.7 : 1.0
      scale: itemBackgroundHoverHandler.hovered ? 1.02 : 1.0

      Behavior on opacity {
        NumberAnimation {
          duration: root.animationDuration
        }
      }

      Behavior on scale {
        NumberAnimation {
          duration: root.animationDuration
        }
      }

      RowLayout {
        anchors.fill: parent
        anchors.margins: root.margins
        spacing: root.spacing

        // Checkbox
        Button {
          id: checkbox

          icon.source: root.taskDone ? "qrc:/qt/qml/Ch13S04/src/resrc/images/checkmark.svg" : "qrc:/qt/qml/Ch13S04/src/resrc/images/inprogress.svg"
          icon.width: 16
          icon.height: 16
          icon.color: root.taskDone ? '#2dad93' : root.darkMode ? "#ffffff" : '#4682d1'
          background: Rectangle {
            color: "transparent"
          }

          Behavior on icon.color {
            ColorAnimation {
              duration: root.animationDuration
            }
          }

          onClicked: function () {
            root.toggleDone();
          }

          HoverHandler {
            id: checkboxHoverHandler
            cursorShape: Qt.PointingHandCursor
          }
        }

        // Task text
        Text {
          id: taskText
          Layout.fillWidth: true
          text: root.taskTitle
          color: root.taskDone ? Qt.lighter(root.textColor, 2.0) : root.textColor
          font.pixelSize: root.fontPixelSize
          font.strikeout: root.taskDone
          wrapMode: Text.WordWrap
          scale: root.taskDone ? 0.95 : 1
          Behavior on scale {
            NumberAnimation {
              duration: root.animationDuration
            }
          }

          Behavior on color {
            ColorAnimation {
              duration: root.animationDuration
            }
          }

          MouseArea {
            id: taskTextMouseArea
            anchors.fill: parent
            onClicked: function () {
              root.toggleDone();
            }
            cursorShape: Qt.PointingHandCursor
          }
        }

        // Delete button
        Button {
          id: deleteButton

          Behavior on opacity {
            NumberAnimation {
              duration: root.animationDuration
            }
          }
          background: Rectangle {
            color: deleteButton.pressed ? "#2dad93" : (deleteButtonHoverHandler.hovered ? Qt.lighter("#2dad93", 1.1) : "#c4ced9")
            radius: root.radius
          }

          contentItem: Text {
            anchors.fill: parent
            text: "Delete"
            font.pixelSize: root.fontPixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          onClicked: function () {
            root.deleteTask();
          }

          HoverHandler {
            id: deleteButtonHoverHandler
            cursorShape: Qt.PointingHandCursor
          }
        }
      }

      HoverHandler {
        id: itemBackgroundHoverHandler
        cursorShape: Qt.PointingHandCursor
      }
    }
  }
}
