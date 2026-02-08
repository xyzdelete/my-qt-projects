pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

// import Ch01
import Ch02

ApplicationWindow {
  id: rootApplicationWindow
  visible: true
  minimumWidth: 320
  minimumHeight: 640
  title: qsTr("DemoApp")

  Rectangle {
    color: "transparent"
    anchors.fill: parent
    border.color: '#ff0000'
    border.width: 1

    // Chapter 1: Diving In
    // Ch01 {}

    // Chapter 2: REST API Client with Custom Types
    Ch02 {}
  }
}
