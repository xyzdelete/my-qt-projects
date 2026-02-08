pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Column {
    MButton {
      color: "yellow"
      focus: false
    }
    MButton {
      color: "green"
      focus: true
    }
  }
}
