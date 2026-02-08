pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Item {
    id: containerItemId
    x: 50
    y: 50
    width: 300
    height: 300

    Image {
      x: 10
      y: 50
      width: 100
      height: 100

      source: "qrc:/qt/qml/Ch03S02/src/resrc/images/LearnQt.png"
    }
  }
}
