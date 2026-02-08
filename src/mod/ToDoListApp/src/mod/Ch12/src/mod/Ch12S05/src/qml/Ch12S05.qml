pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: containerRectId
    anchors.fill: parent
    color: "gray"

    Rectangle {
      id: containedRectId
      width: 60
      height: 60
      x: rect1.x - 5
      y: rect1.y - 5
      color: "green"

      Behavior on x {
        SmoothedAnimation {
          velocity: 200
        }
      }
      Behavior on y {
        SmoothedAnimation {
          velocity: 200
        }
      }
    }
    Rectangle {
      id: rect1
      width: 50
      height: 50
      color: "red"
    }
    focus: true
    Keys.onRightPressed: function () {
      rect1.x = rect1.x + 100;
    }
    Keys.onLeftPressed: function () {
      rect1.x = rect1.x - 100;
    }
    Keys.onUpPressed: function () {
      rect1.y = rect1.y - 100;
    }
    Keys.onDownPressed: function () {
      rect1.y = rect1.y + 100;
    }
  }
}
