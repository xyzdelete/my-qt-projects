pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  height: 80

  required property color backgroundColor
  required property color textColor
  required property color primaryColor
  required property bool darkMode

  signal taskAdded(string taskText)

  Rectangle {
    id: background
    anchors.fill: parent
    color: root.backgroundColor

    Rectangle {
      anchors.fill: parent
      color: root.backgroundColor
      radius: 10
      border.color: root.darkMode ? "#ffffff" : "#000000"
      border.width: 1

      RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 12

        // Add icon
        Button {
          Layout.alignment: Qt.AlignVCenter
          background: Rectangle {
            color: "transparent"
          }
          icon.source: "qrc:/qt/qml/Ch11S11/src/resrc/images/plus.svg"
          icon.color: '#2dad93'
        }

        // Text input
        TextField {
          id: taskInput
          Layout.fillWidth: true
          Layout.preferredHeight: 36
          placeholderText: qsTr("Add a new task...")
          placeholderTextColor: root.textColor
          color: root.textColor
          font.pixelSize: 16
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
          Layout.preferredWidth: 80
          Layout.preferredHeight: 36
          contentItem: Text {
            anchors.fill: parent
            text: "Add"
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          enabled: taskInput.text.trim().length > 0
          opacity: enabled ? 1.0 : 0.4
          background: Rectangle {
            color: addButton.enabled ? (addButton.pressed ? Qt.darker(root.primaryColor, 1.2) : "#c4ced9") : "#c4ced9"
            radius: 10
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
