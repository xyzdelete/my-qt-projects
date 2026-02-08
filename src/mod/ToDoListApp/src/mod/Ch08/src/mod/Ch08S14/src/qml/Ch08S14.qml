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

  Page {
    id: pageId
    anchors.fill: parent

    header: Rectangle {
      width: parent.width
      height: 50
      color: "yellowgreen"
      Text {
        text: "Some header text"
        anchors.centerIn: parent
      }
    }

    SwipeView {
      id: swipeViewId
      anchors.fill: parent
      currentIndex: tabBarId.currentIndex

      Image {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/qt/qml/Ch08S14/src/resrc/images/1.png"
      }
      Image {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/qt/qml/Ch08S14/src/resrc/images/2.png"
      }
      Image {
        fillMode: Image.PreserveAspectFit
        source: "qrc:/qt/qml/Ch08S14/src/resrc/images/3.png"
      }
    }

    footer: TabBar {
      id: tabBarId
      currentIndex: swipeViewId.currentIndex

      TabButton {
        text: "First"
      }
      TabButton {
        text: "Second"
      }
      TabButton {
        text: "Third"
      }
    }
  }
}
