pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Rectangle {
  id: rootId

  anchors.fill: parent
  color: Theme.backgroundGlass
  border.color: '#0400ff'
  border.width: 1


  ContactListPage {
    id: contactListPageId
    anchors.fill: parent
    contactManager: ContactManager {
      id: contactManager
    }
  }
}
