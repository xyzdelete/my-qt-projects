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
    color: "beige"

    Rectangle {
      id: containedRectId
      width: 100
      height: 100
      x: 50
      y: 50
      color: "Dodgerblue"

      PropertyAnimation {
        id: xAnimation
        target: containedRectId
        property: "x"
        to: 200
        duration: 2000
      }
      NumberAnimation {
        id: yAnimation
        target: containedRectId
        property: "y"
        to: 200
        duration: 2000
      }
      RotationAnimation {
        id: rotationAnimation
        target: containedRectId
        property: "rotation"
        to: 600
        duration: 2000
      }
    }

    MouseArea {
      anchors.fill: parent
      onPressed: function () {
        xAnimation.start();
        yAnimation.start();
        rotationAnimation.start();
      }
      onReleased: function () {
        xAnimation.stop();
        yAnimation.stop();
        rotationAnimation.stop();
      }
    }
  }
}
