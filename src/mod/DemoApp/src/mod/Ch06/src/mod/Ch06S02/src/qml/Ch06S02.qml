pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  function min(a, b) {
    return Math.min(a, b);
  }

  Rectangle {
    id: mRectId
    width: rootRectangle.min(300, 200)
    height: 100
    anchors.centerIn: parent
    color: "blue"
  }

  MouseArea {
    id: mMouseAreaId
    anchors.fill: parent

    function sayMessage() {
      ApplicationWindow.window.title = "Hello there";
    }

    onClicked: function () {
      sayMessage();
      ApplicationWindow.window.title = rootRectangle.min(10, 12);
    }
  }

  Component.onCompleted: {
    ApplicationWindow.window.title = "The width of the rectangle is: " + rootRectangle.min(300, 200);
    mMouseAreaId.sayMessage();
  }
}
