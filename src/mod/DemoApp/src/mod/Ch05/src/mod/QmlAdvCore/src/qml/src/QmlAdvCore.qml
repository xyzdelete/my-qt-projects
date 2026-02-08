pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Rectangle {
  id: rootId

  anchors.fill: parent
  color: "#000000"
  border.color: '#4b4a7f'
  border.width: 1

  Text {
    anchors.centerIn: parent
    color: Theme.textPrimary
    text: "Version: " + Version.string
    font.pointSize: 20
  }
}
