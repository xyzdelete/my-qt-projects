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

  ColumnLayout {
    anchors.left: parent.left
    anchors.right: parent.right

    Button {
      id: button1
      text: "Button1"
      Layout.fillWidth: true
      onClicked: function () {
        ApplicationWindow.window.title = "Clicked on button1";
      }
    }

    Button {
      id: button2
      text: "Button2"
      Layout.fillWidth: true
      onClicked: function () {
        ApplicationWindow.window.title = "Clicked on button2";
      }
    }
  }
}
