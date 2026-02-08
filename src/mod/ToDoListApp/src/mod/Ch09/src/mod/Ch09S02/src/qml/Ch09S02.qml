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
      text: "Choose file"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        fileDialogId.open();
      }
    }

    Text {
      id: textId
      text: "User hasn't chosen yet"
      wrapMode: Text.Wrap
    }

    FileDialog {
      id: fileDialogId
      title: "Choose file"
      nameFilters: ["Text files (*.txt)", "HTML files (*.html *.html)", "Images (*.jpg *.png)"]
      onAccepted: function () {
        textId.text = selectedFile;
      }
      onRejected: function () {
        textId.text = "Dialog rejected";
      }
    }
  }
}
