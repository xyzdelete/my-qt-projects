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
      text: "Change font"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        fontDialogId.open();
      }
    }

    Text {
      id: textId
      text: "Hello world"
      wrapMode: Text.Wrap
    }

    FontDialog {
      id: fontDialogId
      title: "Choose folder"
      currentFont: Qt.font({
        family: "Arial",
        pointSize: 24,
        weight: Font.Normal
      })
      onAccepted: function () {
        textId.font = fontDialogId.selectedFont;
      }
      onRejected: function () {
        textId.text = "Dialog rejected";
      }
    }
  }
}
