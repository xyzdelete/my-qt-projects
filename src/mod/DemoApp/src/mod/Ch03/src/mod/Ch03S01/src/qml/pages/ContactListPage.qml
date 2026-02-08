pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
  id: rootId

  required property ContactManager contactManager

  readonly property ContactFilterProxyModel proxyModel: contactManager.proxyModel

  readonly property Item appHeader: Header {
    id: appHeaderId

    height: 150

    onAppLogoClicked: function () {
      Qt.openUrlExternally("https://github.com/xyzdelete/my-qt-projects/");
    }
    onThemeToggled: function () {
      Theme.toggleTheme();
    }
    onDrawerMenuOpened: function () {
      filterPanelId.drawer.open();
    }
    onAddContactRequested: function () {
      addContactDialogId.drawer.open();
    }
  }
  readonly property Item appFooter: StatusBar {
    id: appFooterId

    contactManager: rootId.contactManager
    height: 75
  }

  header: appHeaderId
  footer: appFooterId

  background: Rectangle {
    color: Theme.backgroundGlass
    border.width: 1
    border.color: Theme.glassBorder
  }

  contentItem: Rectangle {
    color: Theme.backgroundGlass

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      Rectangle {
        color: Theme.backgroundGlass
        Layout.fillWidth: true
        Layout.preferredHeight: 80

        ColumnLayout {
          id: toolBarLayoutId

          anchors.fill: parent
          spacing: 10

          ToolBar {
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: Rectangle {
              color: Theme.backgroundGlass
            }

            contentItem: ColumnLayout {
              spacing: 10
              SearchBar {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                contactManager: rootId.contactManager
                iconSource: "/qt/qml/Ch03S01/src/resrc/assets/icons/searchIcon.svg"
              }
              Text {
                Layout.alignment: Qt.AlignHCenter
                text: rootId.proxyModel.count === 1 ? rootId.proxyModel.count + " contact" : rootId.proxyModel.count + " contacts"
                font.pixelSize: 14
                color: Theme.textSecondary
              }
            }
          }
        }
      }

      Divider {
        Layout.fillWidth: true
      }

      Rectangle {
        color: Theme.backgroundGlass
        Layout.fillWidth: true
        Layout.fillHeight: true

        // Contact list
        ColumnLayout {
          spacing: 10
          anchors.fill: parent
          ListView {
            id: contactListViewId

            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true
            spacing: 10
            flickableDirection: Flickable.VerticalFlick
            visible: rootId.proxyModel.count > 0

            model: rootId.proxyModel

            delegate: ContactDelegate {
              id: contactDelegateId

              onFavoriteToggled: function () {
                rootId.contactManager.toggleFavorite(rootId.proxyModel.mapToSourceIndex(contactDelegateId.index));
              }
              onViewContactRequested: function () {
                viewContactDialogId.setContact(contactDelegateId);
                viewContactDialogId.drawer.open();
              }
              onEditRequested: function () {
                editContactDialogId.setContact(contactDelegateId);
                editContactDialogId.drawer.open();
              }
              onDeleteRequested: function () {
                deleteConfirmationDialogId.setContact(contactDelegateId);
                deleteConfirmationDialogId.drawer.open();
              }
            }

            ScrollBar.vertical: ScrollBar {
              policy: ScrollBar.AsNeeded

              background: Rectangle {
                color: Theme.backgroundGlass
                implicitWidth: 1
                Behavior on color {
                  ColorAnimation {
                    duration: Theme.animationDuration
                  }
                }
              }

              contentItem: Rectangle {
                color: Theme.accentGlassHover
                implicitWidth: 1
                Behavior on color {
                  ColorAnimation {
                    duration: Theme.animationDuration
                  }
                }
              }
            }
          }

          EmptyState {
            Layout.preferredHeight: 200
            Layout.preferredWidth: 250
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            visible: rootId.proxyModel.count === 0
          }
        }
      }
    }

    FilterPanel {
      id: filterPanelId

      contactManager: rootId.contactManager
      drawerWidth: ApplicationWindow.window.width
      drawerHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)

      drawer.x: 0
      drawer.y: ApplicationWindow.window.SafeArea.margins.top
    }

    AddContactDialog {
      id: addContactDialogId

      contactManager: rootId.contactManager
      drawerWidth: ApplicationWindow.window.width
      drawerHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)

      drawer.x: 0
      drawer.y: ApplicationWindow.window.SafeArea.margins.top
      interactive: false
    }

    DeleteConfirmationDialog {
      id: deleteConfirmationDialogId

      contactManager: rootId.contactManager
      drawerWidth: ApplicationWindow.window.width
      drawerHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)

      drawer.x: 0
      drawer.y: ApplicationWindow.window.SafeArea.margins.top
      interactive: false
    }

    ViewContactDialog {
      id: viewContactDialogId

      contactManager: rootId.contactManager
      drawerWidth: ApplicationWindow.window.width
      drawerHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)

      drawer.x: 0
      drawer.y: ApplicationWindow.window.SafeArea.margins.top
      interactive: false

      onEditRequested: function (contact: ContactDelegate): void {
        editContactDialogId.setContact(contact);
        editContactDialogId.drawer.open();
      }
    }

    EditContactDialog {
      id: editContactDialogId

      contactManager: rootId.contactManager
      drawerWidth: ApplicationWindow.window.width
      drawerHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)

      drawer.x: 0
      drawer.y: ApplicationWindow.window.SafeArea.margins.top
      interactive: false
    }
  }
}
