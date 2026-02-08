pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Item {
  id: root
  height: 80

  required property color backgroundColor
  required property color textColor
  required property color primaryColor
  required property bool darkMode
  readonly property int fontPixelSize: 14
  readonly property int spacing: 10
  readonly property int margins: 10
  readonly property int radius: 10

  signal taskAdded(string taskText)

  Rectangle {
    id: background
    anchors.fill: parent
    color: root.backgroundColor

    Rectangle {
      anchors.fill: parent
      color: root.backgroundColor
      radius: root.radius
      border.color: root.darkMode ? "#ffffff" : "#000000"
      border.width: 1

      RowLayout {
        anchors.fill: parent
        anchors.margins: root.margins
        spacing: root.spacing

        // Add icon
        Button {
          Layout.alignment: Qt.AlignVCenter
          background: Rectangle {
            color: "transparent"
          }
          icon.source: "qrc:/qt/qml/Ch13S04/src/resrc/images/plus.svg"
          icon.color: '#2dad93'
        }

        // Text input
        TextField {
          id: taskInput
          Layout.fillWidth: true
          placeholderText: qsTr("Add a new task...")
          placeholderTextColor: root.textColor
          color: root.textColor
          font.pixelSize: root.fontPixelSize
          selectByMouse: true
          background: Rectangle {
            color: "transparent"
            border.color: "transparent"
          }

          Keys.onReturnPressed: function () {
            root.addTask();
          }
          Keys.onEnterPressed: function () {
            root.addTask();
          }
        }

        // Add button
        Button {
          id: addButton
          contentItem: Text {
            anchors.fill: parent
            text: "Add"
            font.pixelSize: root.fontPixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          enabled: taskInput.text.trim().length > 0
          opacity: enabled ? 1.0 : 0.4
          background: Rectangle {
            color: addButton.pressed ? "#2dad93" : (addButtonHoverHandler.hovered && addButton.enabled ? Qt.lighter("#2dad93", 1.1) : "#c4ced9")
            radius: root.radius
          }

          onClicked: function () {
            root.addTask();
          }

          HoverHandler {
            id: addButtonHoverHandler
            cursorShape: Qt.PointingHandCursor
          }
        }
      }
    }
  }
  function addTask() {
    if (taskInput.text.trim().length > 0) {
      root.taskAdded(taskInput.text.trim());
      taskInput.text = "";
      taskInput.focus = false;
    }
  }
}
