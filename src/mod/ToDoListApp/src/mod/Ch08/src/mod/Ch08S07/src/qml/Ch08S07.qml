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
    spacing: 10
    anchors.fill: parent

    Label {
      width: parent.width
      wrapMode: Label.Wrap
      horizontalAlignment: Qt.AlignHCenter
      text: "A GroupBox wrapping around RadioButton."
    }

    GroupBox {
      title: "Choose bonus"
      anchors.horizontalCenter: parent.horizontalCenter

      Column {
        RadioButton {
          text: "Coke"
          onCheckedChanged: function () {
            if (checked) {
              ApplicationWindow.window.title = "Coke button checked";
            } else {
              ApplicationWindow.window.title = "Coke button is NOT checked";
            }
          }
        }
        RadioButton {
          text: "Green Tea"
        }
        RadioButton {
          text: "Ice Cream"
        }
      }
    }

    Label {
      width: parent.width
      wrapMode: Label.Wrap
      horizontalAlignment: Qt.AlignHCenter
      text: "A GroupBox wrapping around CheckBoxes."
    }

    GroupBox {
      title: "Choose a Qt supported Desktop Platform"
      anchors.horizontalCenter: parent.horizontalCenter

      Column {
        CheckBox {
          text: "Windows"
          onCheckedChanged: function () {
            if (checked) {
              ApplicationWindow.window.title = "Windows button checked";
            } else {
              ApplicationWindow.window.title = "Windows button is NOT checked";
            }
          }
        }
        CheckBox {
          text: "macOS"
        }
        CheckBox {
          text: "Linux"
        }
      }
    }
  }
}
