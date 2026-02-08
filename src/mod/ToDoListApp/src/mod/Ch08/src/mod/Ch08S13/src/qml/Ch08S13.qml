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
    width: parent.width

    spacing: 20

    Switch {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "WiFi"
      checked: true
      onCheckedChanged: function () {
        if (checked) {
          ApplicationWindow.window.title = "WiFi switch is turned ON";
        } else {
          ApplicationWindow.window.title = "WiFi switch is turned OFF";
        }
      }
    }

    Switch {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "Bluetooth"
    }

    Switch {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "NFC"
      enabled: false
    }
  }
}
