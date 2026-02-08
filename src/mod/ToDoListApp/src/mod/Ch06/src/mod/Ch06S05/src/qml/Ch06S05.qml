pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import "utilities1.js" as Utilities1

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    width: 200
    height: 100
    color: "yellowgreen"
    anchors.centerIn: parent

    Text {
      text: "Click Me"
      anchors.centerIn: parent
    }

    MouseArea {
      anchors.fill: parent
      onClicked: function () {
        ApplicationWindow.window.title = "The ages yield: " + Utilities1.add(33, 17);
      }
    }
  }
}
