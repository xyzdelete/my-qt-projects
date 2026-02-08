pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: containedRect
    anchors.centerIn: parent
    width: 300
    height: 50
    color: "dodgerblue"
    focus: true

    Keys.onDigit5Pressed: function (event) {
      if (event.modifiers === Qt.ControlModifier) {
        ApplicationWindow.window.title = "Pressed Control + 5";
      } else {
        ApplicationWindow.window.title = "Pressed regular 5";
      }
      event.accepted = true;
    }

    Keys.onPressed: function (event) {
      if ((event.key === Qt.Key_5) && (event.modifiers & Qt.ControlModifier)) {
        ApplicationWindow.window.title = "General Signal: Presset Control + 5";
      } else if (event.key === Qt.Key_5) {
        ApplicationWindow.window.title = "General Signal: Key 5 was pressed alone.";
      }
    }
  }
}
