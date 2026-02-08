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

      Behavior on x {
        NumberAnimation {
          duration: 1000
        }
      }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: function (mouse) {
        containedRectId.x = mouse.x;
      }
    }
  }
}
