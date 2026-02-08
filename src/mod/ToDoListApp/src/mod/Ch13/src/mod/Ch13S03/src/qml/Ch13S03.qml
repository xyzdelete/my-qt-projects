pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore
import QtQuick.LocalStorage
import "js/Database.mjs" as JS

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

  Component.onCompleted: function () {
    // Read data
    JS.dbInit(LocalStorage);
    JS.readData(rectId);
  }

  Component.onDestruction: function () {
    JS.storeData(rectId);
  }
}
