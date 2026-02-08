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
      x: rootRectangle.width / 2 - 50
      y: rootRectangle.height - 100
      color: "dodgerblue"
      radius: 80

      PathAnimation {
        id: pathAnimationId
        target: containedRectId
        duration: 1000
        anchorPoint: Qt.point(50, 50)
        path: Path {
          // Bottom: Starting Point
          startX: rootRectangle.width / 2
          startY: rootRectangle.height - 50

          // Towards Left
          PathCubic {
            x: 50
            y: rootRectangle.height / 2

            control1X: rootRectangle.width / 2 - rootRectangle.width / 8
            control1Y: rootRectangle.height
            control2X: 0
            control2Y: rootRectangle.height / 2 + rootRectangle.height / 8
          }

          // Towards Top
          PathCubic {
            x: rootRectangle.width / 2
            y: 50
            control1X: 0
            control1Y: (rootRectangle.height / 2 - rootRectangle.height / 8)
            control2X: (rootRectangle.width / 2 - rootRectangle.width / 8)
            control2Y: 0
          }

          // Towards Right
          PathCubic {
            x: rootRectangle.width - 50
            y: rootRectangle.height / 2
            control1X: rootRectangle.width / 2 + rootRectangle.width / 8
            control1Y: 0
            control2X: rootRectangle.width
            control2Y: rootRectangle.height / 2 - rootRectangle.height / 8
          }

          // Towards Bottom
          PathCubic {
            x: rootRectangle.width / 2
            y: rootRectangle.height - 50
            control1X: rootRectangle.width
            control1Y: rootRectangle.height - 50
            control2X: rootRectangle.width / 2 + rootRectangle.width / 8
            control2Y: rootRectangle.height
          }
        }
      }
    }
    MouseArea {
      anchors.fill: parent
      onClicked: function (mouse) {
        pathAnimationId.start();
      }
    }
  }
}
