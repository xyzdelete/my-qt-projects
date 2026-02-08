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
    width: 300
    height: width
    border.color: "black"
    anchors.centerIn: parent

    Rectangle {
      id: topLeftRectId
      width: 100
      height: width
      color: "magenta"

      anchors.top: siblingRect.bottom
    }
  }
  Rectangle {
    id: siblingRect
    width: 200
    height: 200
    color: "black"
    anchors.right: containerRectId.left
  }
}
