pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
  id: rootRectangle
  readonly property Window appWindow: ApplicationWindow.window
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Column {
    spacing: 20
    anchors.centerIn: parent

    Button {
      text: "Choose color"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        colorDialogId.open();
      }
    }

    Rectangle {
      id: rectangleId
      width: 200
      height: 200
      border.color: "black"
      border.width: 8
      anchors.horizontalCenter: parent.horizontalCenter
    }

    ColorDialog {
      id: colorDialogId
      title: "Please Choose a Color"
      onAccepted: function () {
        rootRectangle.appWindow.title = "User chose color: " + selectedColor;
        rectangleId.color = selectedColor;
      }
      onRejected: function () {
        rootRectangle.appWindow.title = "User rejected dialog";
      }
    }
  }
}
