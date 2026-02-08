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

  Column {
    spacing: 20
    anchors.centerIn: parent

    Row {
      spacing: 30
      width: 300

      Label {
        width: 100
        height: 50
        wrapMode: Label.Wrap
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        text: "First Name: "
      }

      TextField {
        id: textFieldId
        width: 200
        height: 50

        placeholderText: "Type your First Name"

        onEditingFinished: function () {
          ApplicationWindow.window.title = "Text Edit Finished: " + text;
        }
      }
    }

    Button {
      text: "Click"
      onClicked: function () {
        ApplicationWindow.window.title = "Text is: " + textFieldId.text;
      }
    }
  }
}
