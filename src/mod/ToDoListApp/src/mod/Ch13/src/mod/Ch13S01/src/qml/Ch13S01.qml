pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore

Rectangle {
  id: rootId
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: rectId
    anchors.fill: parent
    color: "red"

    MouseArea {
      anchors.fill: parent
      onClicked: {
        colorDialogId.open();
      }
    }
    ColorDialog {
      id: colorDialogId
      title: "Please choose a color"
      onAccepted: function () {
        textId.text = "The new color is: " + selectedColor;
        rectId.color = selectedColor;
      }
      onRejected: function () {
        textId.text = "Canceled";
      }
    }

    Text {
      id: textId
    }
  }

  Settings {
    category: "colors"
    property alias rectColor: rectId.color
  }
}
