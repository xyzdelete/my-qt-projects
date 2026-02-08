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
    MouseArea {
      anchors.fill: parent
      onClicked: function () {
        rect1Id.x = 50;
        rect2Id.rotation = 0;
        rect3Id.scale = 1;
        rect3Id.rotation = 0;
      }
    }
  }

  ClickableRect {
    id: rect1Id
    width: 100
    height: 100
    x: 50
    y: 100
    color: "red"
    onClicked: function () {
      // Translation on x
      x += 20;
    }
  }

  ClickableRect {
    id: rect2Id
    width: 100
    height: 100
    transformOrigin: Item.TopRight
    x: 250
    y: 100
    color: "green"
    onClicked: function () {
      // Rotation
      rotation += 15;
    }
  }

  ClickableRect {
    id: rect3Id
    width: 100
    height: 100
    transformOrigin: Item.BottomLeft
    x: 250
    y: 250
    color: "blue"
    onClicked: function () {
      scale += 0.05;
      rotation += 15;
    }
  }
}
