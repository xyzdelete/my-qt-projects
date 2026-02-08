pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  // width: mGridLayoutId.implicitWidth
  // height: mGridLayoutId.implicitHeight

  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  GridLayout {
    id: mGridLayoutId
    anchors.fill: parent
    columns: 3
    layoutDirection: Qt.RightToLeft

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
      Layout.alignment: Qt.AlignRight | Qt.AlignTop
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.maximumWidth: 150
      Layout.maximumHeight: 150
    }
    Rectangle {
      id: topCenterRectId
      width: 100
      height: width
      color: "red"
      Text {
        text: "2"
        anchors.centerIn: parent
        font.pointSize: 20
      }
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.columnSpan: 2
    }
    // Rectangle {
    //   id: topRightRectId
    //   width: 100
    //   height: width
    //   color: "blue"
    //   Text {
    //     text: "3"
    //     anchors.centerIn: parent
    //     font.pointSize: 20
    //   }
    //   Layout.fillWidth: true
    //   Layout.fillHeight: true
    // }
    Rectangle {
      id: centerLeftRectId
      width: 100
      height: width
      color: "beige"
      Text {
        text: "4"
        anchors.centerIn: parent
        font.pointSize: 20
      }
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.rowSpan: 2
    }
    Rectangle {
      id: centerCenterRectId
      width: 100
      height: width
      color: "pink"
      Text {
        text: "5"
        anchors.centerIn: parent
        font.pointSize: 20
      }
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
    Rectangle {
      id: centerRightRectId
      width: 100
      height: width
      color: "yellow"
      Text {
        text: "6"
        anchors.centerIn: parent
        font.pointSize: 20
      }
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
    // Rectangle {
    //   id: bottomLeftRectId
    //   width: 100
    //   height: width
    //   color: "magenta"
    //   Text {
    //     text: "7"
    //     anchors.centerIn: parent
    //     font.pointSize: 20
    //   }
    //   Layout.fillWidth: true
    //   Layout.fillHeight: true
    // }
    Rectangle {
      id: bottomCenterRectId
      width: 100
      height: width
      color: "yellowgreen"
      Text {
        text: "8"
        anchors.centerIn: parent
        font.pointSize: 20
      }
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
    Rectangle {
      id: bottomRightRectId
      width: 100
      height: width
      color: "dodgerblue"
      Text {
        text: "9"
        anchors.centerIn: parent
        font.pointSize: 20
      }
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
  }
}
