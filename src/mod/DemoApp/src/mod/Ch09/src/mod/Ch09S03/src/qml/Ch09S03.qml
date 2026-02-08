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
      text: "Choose folder"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        folderDialogId.open();
      }
    }

    Text {
      id: textId
      text: "User hasn't chosen yet"
      wrapMode: Text.Wrap
    }

    FolderDialog {
      id: folderDialogId
      title: "Choose folder"
      onAccepted: function () {
        textId.text = selectedFolder;
      }
      onRejected: function () {
        textId.text = "Dialog rejected";
      }
    }
  }
}
