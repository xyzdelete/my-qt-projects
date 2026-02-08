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
      text: "Push me"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        messageDialog.open();
      }
    }

    MessageDialog {
      id: messageDialog
      title: "Message"
      text: "Lie down and watch the sky."
      buttons: MessageDialog.Ok | MessageDialog.Close
      informativeText: "informativeText"
      detailedText: "detailedText"
      onAccepted: function () {
        rootRectangle.appWindow.title = "Dialog accpted.";
      }

      onRejected: {
        rootRectangle.appWindow.title = "Dialog rejected.";
      }
    }
  }
}
