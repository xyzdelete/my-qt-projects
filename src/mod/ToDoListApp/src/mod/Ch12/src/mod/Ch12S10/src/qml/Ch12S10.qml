pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  property int animationDuration: 500
  property bool going_down: false

  function animateCircle() {
    if (going_down === false) {
      // Go down
      going_down = true;
      xAnimationId.from = 0;
      xAnimationId.to = rootRectangle.width - circleId.width;
      yAnimationId.from = 0;
      yAnimationId.to = rootRectangle.height - circleId.height;
    } else {
      // Go up
      going_down = false;
      xAnimationId.from = rootRectangle.width - circleId.width;
      xAnimationId.to = 0;
      yAnimationId.from = rootRectangle.height - circleId.height;
      yAnimationId.to = 0;
    }
    groupedAnimId.start();
  }

  Rectangle {
    anchors.fill: parent
    color: "lightgray"
    Rectangle {
      id: circleId
      width: 100
      height: 100
      radius: 50
      color: "yellowgreen"
    }

    // SequentialAnimation {
    ParallelAnimation {
      id: groupedAnimId

      // Animate X
      NumberAnimation {
        id: xAnimationId
        target: circleId
        property: "x"
        duration: rootRectangle.animationDuration
      }
      // Animate y
      NumberAnimation {
        id: yAnimationId
        easing.type: Easing.OutBounce
        target: circleId
        property: "y"
        duration: rootRectangle.animationDuration
      }
    }
    MouseArea {
      anchors.fill: parent
      onClicked: function () {
        rootRectangle.animateCircle();
      }
    }
  }
}
