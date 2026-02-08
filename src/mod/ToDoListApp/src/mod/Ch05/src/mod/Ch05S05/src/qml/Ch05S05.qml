pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  // Row {
  //   anchors.centerIn: parent

  //   Rectangle {
  //     id: firstRectId
  //     width: 100
  //     height: width
  //     border.color: "black"
  //     color: "red"
  //     focus: true

  //     onFocusChanged: function () {
  //       firstRectId.color = focus ? "red" : "gray";
  //     }

  //     Keys.onDigit5Pressed: function () {
  //       ApplicationWindow.window.title = "I am Rect1";
  //     }

  //     KeyNavigation.right: secondRectId
  //   }

  //   Rectangle {
  //     id: secondRectId
  //     width: 100
  //     height: width
  //     border.color: "black"
  //     color: "gray"
  //     onFocusChanged: function () {
  //       secondRectId.color = secondRectId.focus ? "red" : "gray";
  //     }

  //     Keys.onDigit5Pressed: function () {
  //       ApplicationWindow.window.title = "I am Rect2";
  //     }

  //     KeyNavigation.left: firstRectId
  //   }
  // }

  Grid {
    anchors.centerIn: parent
    columns: 2

    Rectangle {
      id: topLeft
      width: 100
      height: 100
      color: focus ? "red" : "lightgray"
      focus: true
      KeyNavigation.right: topRight
      KeyNavigation.down: bottomLeft
    }

    Rectangle {
      id: topRight
      width: 100
      height: 100
      color: focus ? "red" : "lightgray"

      KeyNavigation.left: topLeft
      KeyNavigation.down: bottomRight
    }

    Rectangle {
      id: bottomLeft
      width: 100
      height: 100
      color: focus ? "red" : "lightgray"

      KeyNavigation.right: bottomRight
      KeyNavigation.up: topLeft
    }

    Rectangle {
      id: bottomRight
      width: 100
      height: 100
      color: focus ? "red" : "lightgray"

      KeyNavigation.left: bottomLeft
      KeyNavigation.up: topRight
    }
  }
}
