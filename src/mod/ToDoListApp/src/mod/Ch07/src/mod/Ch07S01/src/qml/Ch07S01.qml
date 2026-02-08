pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: containerRectId
    width: 300
    height: width
    border.color: "black"
    anchors.centerIn: parent

    Rectangle {
      id: topLeftRectId
      width: 100
      height: width
      color: "magenta"

      Text {
        anchors.centerIn: parent
        text: "1"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: topCenterRectId
      width: 100
      height: width
      color: "yellowgreen"
      anchors.left: topLeftRectId.right

      Text {
        anchors.centerIn: parent
        text: "2"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: topRightRectId
      width: 100
      height: width
      color: "dodgerblue"
      anchors.left: topCenterRectId.right

      Text {
        anchors.centerIn: parent
        text: "3"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: centerLeftRectId
      width: 100
      height: width
      color: "red"
      anchors.top: topLeftRectId.bottom
      anchors.left: containerRectId.left

      Text {
        anchors.centerIn: parent
        text: "4"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: centerCenterRectId
      width: 100
      height: width
      color: "green"
      // anchors.left: centerLeftRectId.right
      // anchors.top: topRightRectId.bottom

      // anchors.horizontalCenter: parent.horizontalCenter
      // anchors.verticalCenter: parent.verticalCenter

      anchors.centerIn: parent

      Text {
        anchors.centerIn: parent
        text: "5"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: centerRightRectId
      width: 100
      height: width
      color: "blue"
      anchors.left: centerCenterRectId.right
      anchors.top: topRightRectId.bottom
      Text {
        anchors.centerIn: parent
        text: "6"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: bottomLeftRectId
      width: 100
      height: width
      color: "royalblue"
      anchors.right: centerCenterRectId.left
      anchors.top: centerCenterRectId.bottom
      Text {
        anchors.centerIn: parent
        text: "7"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: bottomCenterRectId
      width: 100
      height: width
      color: "yellow"
      anchors.left: centerCenterRectId.left
      anchors.top: centerCenterRectId.bottom
      Text {
        anchors.centerIn: parent
        text: "8"
        font.pointSize: 20
      }
    }

    Rectangle {
      id: bottomRightRectId
      width: 100
      height: width
      color: "pink"
      anchors.left: centerCenterRectId.right
      anchors.top: centerCenterRectId.bottom
      Text {
        anchors.centerIn: parent
        text: "9"
        font.pointSize: 20
      }
    }
  }
}
