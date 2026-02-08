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
    width: getHeight()
    height: 100
    color: x > 100 ? "red" : "green"
    onXChanged: function () {
      ApplicationWindow.window.title = "Current value of x: " + x;
    }

    function getHeight() {
      return height * 2;
    }
  }
  MouseArea {
    anchors.fill: parent
    drag.target: containerRectId
    drag.axis: Drag.XAxis
    drag.minimumX: 0
    drag.maximumX: parent.width - containerRectId.width
  }
}
