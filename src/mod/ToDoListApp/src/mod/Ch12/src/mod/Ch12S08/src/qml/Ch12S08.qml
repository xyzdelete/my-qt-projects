pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: rectId
    width: 100
    height: 100
    color: "red"

    ColorAnimation {
      id: colorAnimationId
      target: rectId
      property: "color"
      from: rectId.color
      to: "blue"
      duration: 1000
    }
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      colorAnimationId.start();
    }
  }
}
