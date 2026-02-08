pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

// import Ch01
import Ch02
import Ch03

ApplicationWindow {
  id: rootApplicationWindow
  visible: true
  minimumWidth: 320
  minimumHeight: 640
  title: qsTr("DemoApp")
  color: "#000000"
  Material.theme: Material.Dark
  Material.background: "#000000"
  Material.foreground: "#ffffff"
  Rectangle {
    color: "#000000"
    anchors.fill: parent
    border.color: '#ff0000'
    border.width: 1

    // Chapter 1: Diving In
    // Ch01 {}

    // Chapter 2: REST API Client with Custom Types
    // Ch02 {}

    // Chapter 3: Custom Models for Real Data
    Ch03 {}
  }
}
