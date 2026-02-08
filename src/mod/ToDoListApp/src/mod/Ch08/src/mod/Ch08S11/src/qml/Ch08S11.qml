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

  Flickable {
    width: parent.width
    height: parent.height
    contentHeight: mColumnId.implicitHeight
    Column {
      id: mColumnId
      anchors.fill: parent

      Rectangle {
        color: "red"
        width: parent.width
        height: 200
        Text {
          anchors.centerIn: parent
          text: "Element 1"
          font.pointSize: 30
          color: "white"
        }
      }

      Rectangle {
        color: "blue"
        width: parent.width
        height: 200
        Text {
          anchors.centerIn: parent
          text: "Element 2"
          font.pointSize: 30
          color: "white"
        }
      }
      Rectangle {
        color: "yellow"
        width: parent.width
        height: 200
        Text {
          anchors.centerIn: parent
          text: "Element 3"
          font.pointSize: 30
          color: "white"
        }
      }
      Rectangle {
        color: "magenta"
        width: parent.width
        height: 200
        Text {
          anchors.centerIn: parent
          text: "Element 4"
          font.pointSize: 30
          color: "white"
        }
      }
      Rectangle {
        color: "yellowgreen"
        width: parent.width
        height: 200
        Text {
          anchors.centerIn: parent
          text: "Element 5"
          font.pointSize: 30
          color: "white"
        }
      }
    }
    ScrollBar.vertical: ScrollBar {}
  }
}
