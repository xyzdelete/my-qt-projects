pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

// import Ch01
// import Ch02
// import Ch03
// import Ch04
// import Ch05
// import Ch06
// import Ch07
// import Ch08
// import Ch09
// import Ch10
import Ch11

ApplicationWindow {
  id: rootApplicationWindow
  visible: true
  width: 360
  height: 720
  minimumWidth: 320
  minimumHeight: 640
  title: qsTr("DemoApp")

  Rectangle {
    color: "transparent"
    anchors.fill: parent
    border.color: '#ff0000'
    border.width: 1

    // Chapter 1: First Steps with Qt QML
    //Ch01 {}

    // Chapter 2: Dissecting the QML Syntax
    // Ch02 {}

    // Chapter 3: Basic QML Elements
    // Ch03 {}

    // Chapter 4: Signals and Handlers
    // Ch04 {}

    // Chapter 5: User Input
    // Ch05 {}

    // Chapter 6: Chapter 6: JavaScript
    // Ch06 {}

    // Chapter 7: Positioning
    // Ch07 {}

    // Chapter 8: QtQuick Controls
    // Ch08 {}

    // Chapter 9: Dialogs
    // Ch09 {}

    // Chapter 10: Todo List Application
    // Ch10 {}

    // Chapter 11: The Model View Architecture
    Ch11 {}
  }
}
