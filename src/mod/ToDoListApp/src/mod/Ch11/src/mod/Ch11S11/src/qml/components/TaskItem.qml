pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
  readonly property int itemHeight: 80
  readonly property int margins: 5
  readonly property int innerMargins: 10

  Rectangle {
    id: taskItemBackground
    anchors.fill: parent
    color: "transparent"

    Rectangle {
      id: itemBackground
      anchors.fill: parent
      anchors.margins: root.margins
      color: root.backgroundColor
      radius: 10
      border.color: root.darkMode ? "#ffffff" : "#000000"
      border.width: 1
      opacity: root.taskDone ? 0.7 : 1.0

      RowLayout {
        anchors.fill: parent
        anchors.margins: root.innerMargins
        spacing: 10

        // Checkbox
        Button {
          id: checkbox

          icon.source: root.taskDone ? "qrc:/qt/qml/Ch11S11/src/resrc/images/checkmark.svg" : "qrc:/qt/qml/Ch11S11/src/resrc/images/inprogress.svg"
          icon.width: 16
          icon.height: 16
          icon.color: root.taskDone ? '#2dad93' : root.darkMode ? "#ffffff" : '#4682d1'
          background: Rectangle {

            color: "transparent"
            radius: 5
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
          font.pixelSize: 16
          font.strikeout: root.taskDone
          wrapMode: Text.WordWrap

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

          opacity: itemBackgroundHoverHandler.hovered ? 1.0 : 0.4

          background: Rectangle {
            color: deleteButton.pressed ? Qt.darker(root.primaryColor, 1.2) : "#c4ced9"

            radius: 10
          }

          contentItem: Text {
            anchors.fill: parent
            text: "Delete"
            font.pixelSize: 16
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
