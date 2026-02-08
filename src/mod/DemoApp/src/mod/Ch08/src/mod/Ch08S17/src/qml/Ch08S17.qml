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

  SplitView {
    anchors.fill: parent
    orientation: Qt.Horizontal

    Rectangle {
      SplitView.preferredWidth: 150
      SplitView.minimumWidth: 100
      color: "lightblue"
      Text {
        text: "View 1"
        anchors.centerIn: parent
      }
    }
    Rectangle {
      SplitView.preferredWidth: 100
      color: "lightgray"
      Text {
        text: "View 2"
        anchors.centerIn: parent
      }
    }
    Rectangle {
      SplitView.preferredWidth: 150
      color: "lightgreen"
      Text {
        text: "View 3"
        anchors.centerIn: parent
      }
    }
  }
}
