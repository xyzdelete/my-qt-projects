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

  SwipeView {
    id: swipeViewId
    anchors.fill: parent
    currentIndex: pageIndicatorId.currentIndex
    anchors.bottomMargin: 20

    Image {
      id: image1
      fillMode: Image.PreserveAspectFit
      source: "qrc:/qt/qml/Ch08S08/src/resrc/images/1.png"
    }
    Image {
      id: image2
      fillMode: Image.PreserveAspectFit
      source: "qrc:/qt/qml/Ch08S08/src/resrc/images/2.png"
    }
    Image {
      id: image3
      fillMode: Image.PreserveAspectFit
      source: "qrc:/qt/qml/Ch08S08/src/resrc/images/3.png"
    }
  }

  PageIndicator {
    id: pageIndicatorId
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter

    currentIndex: swipeViewId.currentIndex
    interactive: true
    count: swipeViewId.count
  }
}
