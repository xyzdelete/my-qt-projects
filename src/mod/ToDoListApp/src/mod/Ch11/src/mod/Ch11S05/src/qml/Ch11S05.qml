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

  Flickable {
    contentHeight: columnId.implicitHeight
    anchors.fill: parent

    Column {
      id: columnId
      anchors.fill: parent
      spacing: 2

      Repeater {
        id: repeaterId
        model: ["Jan", "Feb", "March"]

        delegate: Rectangle {
          id: rectId
          required property string modelData
          width: parent.width
          height: 50
          color: "dodgerblue"
          Text {
            anchors.centerIn: parent
            text: rectId.modelData
            font.pointSize: 20
          }
          MouseArea {
            anchors.fill: parent
            onClicked: function () {
              ApplicationWindow.window.title = "Clicked on: " + rectId.modelData + " count: " + repeaterId.count;
            }
          }
        }
      }
    }
  }
}
