pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  property bool running: false

  Rectangle {
    id: containerRectId
    anchors.fill: parent
    color: "beige"

    Rectangle {
      id: containedRectId
      width: 100
      height: 100
      x: 50
      y: 50
      color: "Dodgerblue"
      PropertyAnimation on x {
        to: 230
        duration: 2000
        running: rootRectangle.running
      }

      NumberAnimation on y {
        to: 300
        duration: 2000
        running: rootRectangle.running
      }

      RotationAnimation on rotation {
        to: 600
        duration: 2000
        running: rootRectangle.running
      }
    }

    MouseArea {
      anchors.fill: parent
      onPressed: function () {
        rootRectangle.running = true;
      }
      onReleased: function () {
        rootRectangle.running = false;
      }
    }
  }
}
