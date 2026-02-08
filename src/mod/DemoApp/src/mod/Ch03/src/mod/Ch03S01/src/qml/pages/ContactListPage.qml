pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
  id: root
  required property var theme
  required property ContactManager contactManager
  signal contactSelected(int index)
  signal addContactRequested

  property string searchText: ""
  property bool showFavoritesOnly: false
  property var selectedTags: []
  property string sortOrder: "asc"

  background: Rectangle {
    color: root.theme.backgroundGlass
    border.width: 1
    border.color: root.theme.glassBorder
  }

  readonly property Item appHeader: Header {
    id: headerId
    theme: root.theme
    height: 140

    onAppLogoClicked: function () {
      Qt.openUrlExternally("https://github.com/xyzdelete/");
    }
    onThemeToggled: function () {
      root.theme.toggleTheme();
    }
    onDrawerMenuOpened: function () {
      drawerMenuFilterPanel.drawer.open();
    }
    onAddContactRequested: function () {
      drawerAddContactDialogPanel.drawer.open();
    }
  }
  readonly property Item appFooter: StatusBar {
    id: statusBarId
    theme: root.theme
    contactManager: root.contactManager
    height: 70
  }
  header: appHeader
  footer: appFooter

  contentItem: Rectangle {
    color: root.theme.backgroundGlass
    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      Rectangle {
        color: root.theme.backgroundGlass
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
              color: root.theme.backgroundGlass
            }

            contentItem: ColumnLayout {
              spacing: 10
              SearchBar {
                Layout.fillWidth: true
                Layout.preferredHeight: 50
                theme: root.theme
                iconSource: "/qt/qml/Ch03S01/src/resrc/assets/icons/searchIcon.svg"

                onSearchTextChanged: function (text) {
                  root.searchText = text;
                }
              }
              Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.contactManager.totalContacts === 1 ? root.contactManager.totalContacts + " contact" : root.contactManager.totalContacts + "contacts"
                font.pixelSize: 14
                color: root.theme.textSecondary
              }
            }
          }
        }
      }

      Divider {
        theme: root.theme
        Layout.fillWidth: true
      }

      Rectangle {
        color: root.theme.backgroundGlass
        Layout.fillWidth: true
        Layout.fillHeight: true

        // Contact list
        ColumnLayout {
          spacing: 10
          anchors.fill: parent
          ListView {
            id: contactListView
            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true
            spacing: 10
            visible: root.selectedTags.length === 0
            model: root.contactManager.contactModel

            delegate: ContactDelegate {
              id: contactDelegateId
              required property var model
              theme: root.theme

              firstName: model.firstName
              lastName: model.lastName
              email: model.email
              isFavorite: model.isFavorite
              avatarColor: model.avatarColor
              tags: model.tags

              onClicked: function () {
                root.contactSelected(model.index);
              }
              onFavoriteToggled: function () {
                root.contactManager.toggleFavorite(model.index);
                ApplicationWindow.window.title = "isFavorite: " + root.contactManager.favoritesCount;
              }
            }

            ScrollBar.vertical: ScrollBar {
              policy: ScrollBar.AsNeeded

              background: Rectangle {
                color: root.theme.backgroundGlass
                implicitWidth: 6
                radius: 3
                border.width: 1
                border.color: root.theme.glassBorder
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }

              contentItem: Rectangle {
                color: root.theme.accentGlassHover
                implicitWidth: 4
                radius: 2
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          EmptyState {
            theme: root.theme
            Layout.preferredHeight: 200
            Layout.preferredWidth: 250
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            visible: root.contactManager.totalContacts === 0
          }
        }
      }
    }

    DrawerMenu {
      id: drawerMenuFilterPanel
      theme: root.theme
      width: ApplicationWindow.window.width
      height: ApplicationWindow.window.height

      onFavoritesToggled: function (enabled) {
        root.showFavoritesOnly = enabled;
      }

      onSortChanged: function (sortBy, ascending) {
        root.sortOrder = ascending ? "asc" : "desc";
      }

      onTagToggled: function (tag) {
        root.selectedTags = drawerMenuFilterPanel.selectedTags;
      }
    }

    DrawerAddContactDialog {
      id: drawerAddContactDialogPanel
      theme: root.theme
      width: ApplicationWindow.window.width
      height: ApplicationWindow.window.height
      interactive: false
    }
  }
}
