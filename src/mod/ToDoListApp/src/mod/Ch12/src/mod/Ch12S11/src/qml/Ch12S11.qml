pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  property int pendulumAngle: 30
  property int anim_duration: 900

  Rectangle {
    id: pendulumId
    width: 20
    height: 200
    color: "black"
    x: (parent.width - width) / 2
    y: 50
    transformOrigin: Item.Top

    Rectangle {
      id: bobId
      width: 50
      height: 50
      color: "red"
      radius: width / 2
      x: (pendulumId.width - width) / 2
      y: pendulumId.height
      transformOrigin: Item.Top
      rotation: pendulumId.rotation
    }

    SequentialAnimation {
      loops: Animation.Infinite
      running: true

      NumberAnimation {
        id: rightToLeftId
        target: pendulumId
        property: "rotation"
        from: -rootRectangle.pendulumAngle
        to: rootRectangle.pendulumAngle
        duration: rootRectangle.anim_duration
        easing.type: Easing.InOutQuad
      }

      NumberAnimation {
        id: leftToRightId
        target: pendulumId
        property: "rotation"
        from: rootRectangle.pendulumAngle
        to: -rootRectangle.pendulumAngle
        duration: rootRectangle.anim_duration
        easing.type: Easing.InOutQuad
      }
    }
  }
}
