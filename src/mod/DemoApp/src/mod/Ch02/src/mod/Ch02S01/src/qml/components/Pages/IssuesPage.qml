pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
  id: rootId

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundGlass
    border.color: "Green"
    border.width: 2

    Text {
      anchors.centerIn: parent
      text: "IssuesPage"
      font.pointSize: 20
      color: Theme.textPrimary
    }
  }
}
