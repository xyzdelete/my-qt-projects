pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  anchors.fill: parent
  color: appTheme.backgroundGlass
  border.color: '#0400ff'
  border.width: 1

  Theme {
    id: appTheme
  }

  ContactListPage {
    id: contactListPage
    anchors.fill: parent
    theme: appTheme
    contactManager: ContactManager {
      id: contactManager
    }

    onContactSelected: function (index) {
      ApplicationWindow.window.title = "Contact selected: " + index;
    }

    onAddContactRequested: function () {
      ApplicationWindow.window.title = "Add contact requested";
    }
  }
}
