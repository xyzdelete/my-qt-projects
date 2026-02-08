pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Row {
    spacing: 20
    anchors.centerIn: parent

    Rectangle {
      id: redRect
      width: 100
      height: 100
      color: "red"

      MouseArea {
        id: redMouseArea
        anchors.fill: parent
        onClicked: function () {
          print("Red rectangle clicked");
        }
      }
    }
    Rectangle {
      id: greenRect
      width: 100
      height: 100
      color: "green"

      Connections {
        // target: id of the element we want to steal the signal from
        target: redMouseArea
        function onClicked() {
          print("Green rectangle heard the click!");
        }
      }
    }
    Rectangle {
      id: blueRect
      width: 100
      height: 100
      color: "blue"

      Connections {
        target: redMouseArea
        function onClicked() {
          print("Blue rectangle heard the click too!");
        }
      }
    }
  }
}
