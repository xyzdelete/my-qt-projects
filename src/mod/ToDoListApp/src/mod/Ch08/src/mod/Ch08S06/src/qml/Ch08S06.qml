pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Frame {
    anchors.centerIn: parent

    ColumnLayout {
      Button {
        text: "Button1"
      }
      Button {
        text: "Button2"
      }
      Button {
        text: "Button3"
      }
    }
  }
}
