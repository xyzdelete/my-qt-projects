pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  signal clicked
  MouseArea {
    anchors.fill: parent
    onClicked: rootRectangle.clicked()
  }
}
