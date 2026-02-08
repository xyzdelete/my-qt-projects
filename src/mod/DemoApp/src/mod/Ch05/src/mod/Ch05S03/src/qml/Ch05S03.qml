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
    id: containerRectId
    width: parent.width
    height: 200
    color: "beige"

    Rectangle {
      id: movingRectId
      width: 50
      height: width
      color: "blue"
    }

    MouseArea {
      anchors.fill: parent
      onClicked: function (mouse) {
        ApplicationWindow.window.title = mouse.x;
        movingRectId.x = mouse.x;
      }

      onWheel: function (wheel) {
        ApplicationWindow.window.title = "x: " + wheel.x + ", y: " + wheel.y + ", angleData: " + wheel.angleDelta;
      }

      hoverEnabled: true

      onHoveredChanged: function () {
        if (containsMouse) {
          containerRectId.color = "red";
        } else {
          containerRectId.color = "green";
        }
      }
    }
  }

  Rectangle {
    id: dragContainerId
    width: parent.width
    height: 200
    color: "beige"
    y: 250

    Rectangle {
      id: draggableRect
      width: 50
      height: width
      color: "blue"

      onXChanged: {
        ApplicationWindow.window.title = "X Coordinate is: " + x;
      }

      MouseArea {
        anchors.fill: parent
        drag.target: draggableRect
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: dragContainerId.width - draggableRect.width
      }
    }
  }
}
