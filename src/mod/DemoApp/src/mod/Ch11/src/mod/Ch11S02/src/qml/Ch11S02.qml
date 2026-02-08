pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: rootId
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  ListView {
    id: mListViewId
    anchors.fill: parent
    model: 15
    delegate: Rectangle {
      id: rectangleId
      required property int modelData
      width: rootId.width
      height: 50
      color: "beige"
      border.color: "yellowgreen"
      radius: 10

      Text {
        id: textId
        anchors.centerIn: parent
        font.pointSize: 20
        text: rectangleId.modelData
      }

      MouseArea {
        anchors.fill: parent
        onClicked: function () {
          ApplicationWindow.window.title = "Clicked on: " + rectangleId.modelData;
        }
      }
    }
  }
}
