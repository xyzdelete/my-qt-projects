pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Rectangle {
  id: rootId

  anchors.fill: parent
  // color: "#000000"
  border.color: '#4b4a7f'
  border.width: 1

  Column {
    anchors.centerIn: parent
    spacing: Theme.spacing.medium

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "QmlAdvCore"
      font.weight: Font.Bold
      font.pixelSize: 20
      color: Theme.colors.primary
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "Version: " + Version.string
      font.pixelSize: 16
      color: Theme.colors.primary
    }

    Rectangle {
      anchors.horizontalCenter: parent.horizontalCenter
      width: 180
      height: 40
      radius: 8
      color: Theme.colors.primary

      Text {
        anchors.centerIn: parent
        text: "Theme.colors.primary"
        font.pixelSize: 12
        color: Theme.colors.onPrimary
      }
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "Primary: " + Theme.colors.primary
      font.pixelSize: 14
      color: "#49454F"
    }

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: "Spacing medium: " + Theme.spacing.medium
      font.pixelSize: 14
      color: "#49454F"
    }
  }
}
