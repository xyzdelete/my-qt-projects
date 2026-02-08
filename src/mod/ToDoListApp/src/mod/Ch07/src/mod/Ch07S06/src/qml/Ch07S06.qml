pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "lightgray"
  border.color: '#0400ff'
  border.width: 1

  Flow {
    id: containerFlowId
    anchors.fill: parent
    flow: Flow.TopToBottom
    layoutDirection: Qt.RightToLeft
    spacing: 10

    Rectangle {
      id: topLeftRectId
      width: 70
      height: width
      color: "green"
      Text {
        text: "1"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: topCenterRectId
      width: 100
      height: width
      color: "beige"
      Text {
        text: "2"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: topRightRectId
      width: 100
      height: width
      color: "dodgerblue"
      Text {
        text: "3"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: leftCenterRectId
      width: 100
      height: width
      color: "magenta"
      Text {
        text: "4"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: centerRectId
      width: 100
      height: width
      color: "red"
      Text {
        text: "5"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: rightCenterId
      width: 100
      height: width
      color: "yellow"
      Text {
        text: "6"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: bottomLeftRectId
      width: 100
      height: width
      color: "royalblue"
      Text {
        text: "7"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: bottomCenterRect
      width: 100
      height: width
      color: "greenyellow"
      Text {
        text: "8"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
    Rectangle {
      id: bottomRightRectId
      width: 100
      height: width
      color: "blue"
      Text {
        text: "9"
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
  }
}
