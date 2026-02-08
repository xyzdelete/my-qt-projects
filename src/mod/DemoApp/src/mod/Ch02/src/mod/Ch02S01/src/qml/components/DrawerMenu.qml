pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  required property var theme
  required property var githubService
  required property var currentView
  required property var drawerWidth
  required property var drawerHeight
  property alias drawer: drawerId

  property string lastSearchQuery
  property string lastUsername

  signal refreshRequested
  signal viewChanged(string view)

  Drawer {
    id: drawerId
    width: root.drawerWidth
    height: root.drawerHeight

    background: Rectangle {
      anchors.fill: parent
      anchors.topMargin: ApplicationWindow.window.SafeArea.margins.top
      anchors.bottomMargin: ApplicationWindow.window.SafeArea.margins.bottom
      color: root.theme.backgroundGlass
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10

      SearchBar {
        id: searchBar
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 50
        theme: root.theme
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/searchIcon.svg"
        onSearchRequested: function (query) {
          if (query.trim().length > 0) {
            root.lastSearchQuery = query;
            root.githubService.searchRepositories(query);
            root.viewChanged("search");

            drawerId.close();
          }
        }
        onUserSearchRequested: function (username) {
          if (username.trim().length > 0) {
            root.lastUsername = username;
            root.githubService.fetchUserRepositories(username);
            root.viewChanged("user");

            drawerId.close();
          }
        }
        onSearchButtonClicked: function () {
          drawerId.close();
        }
      }

      TokenInput {
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 50
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/tokenInputIcon.svg"
        theme: root.theme
        onTokenChanged: function (token) {
          root.githubService.authToken = token;
        }
        onTokenInputButtonClicked: function () {
          root.githubService.fetchAuthenticatedUserRepositories();
          drawerId.close();
        }
      }

      CustomButton {
        id: popularButton
        Layout.preferredWidth: 120
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: root.theme

        onClicked: function () {
          root.lastSearchQuery = "";
          root.lastUsername = "";
          root.viewChanged("repositories");
          root.githubService.searchRepositories("stars:>200000", "stars", "desc");
          drawerId.close();
        }
        contentItem: Text {
          anchors.centerIn: parent
          text: "⭐ Popular"
          color: root.theme.textPrimary
          font.pixelSize: 14
          font.weight: Font.Bold

          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }

      CustomButton {
        id: refreshButton
        Layout.preferredWidth: 120
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: root.theme

        onClicked: function () {
          root.refreshRequested();
        }
        contentItem: Text {
          anchors.centerIn: parent
          text: "🔄 Refresh"
          color: root.theme.textPrimary
          font.pixelSize: 14
          font.weight: Font.Bold

          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }

      CustomButton {
        id: myReposButton
        Layout.preferredWidth: 120
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: root.theme
        visible: root.githubService.authToken.length > 0

        onClicked: function () {
          root.lastSearchQuery = "";
          root.lastUsername = "";
          root.viewChanged("myrepos");
          root.githubService.fetchAuthenticatedUserRepositories();
          drawerId.close();
        }
        contentItem: Text {
          anchors.centerIn: parent
          text: "🏠 My Repos"
          color: root.theme.textPrimary
          font.pixelSize: 14
          font.weight: Font.Bold

          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }

      // View status
      Text {
        Layout.alignment: Qt.AlignHCenter
        text: {
          switch (root.currentView) {
          case "search":
            return "Close menu to view repositories";
          case "user":
            return "Close menu to view user repositories";
          case "myrepos":
            return "Close menu to view your repositories";
          default:
            return "";
          }
        }
        color: root.theme.textPrimary
        font.pixelSize: 12

        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }

      Item {
        Layout.fillHeight: true
      }

      CustomButton {
        id: menuCloseButton
        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: root.theme
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/menuCloseIcon.svg"

        onClicked: function () {
          drawerId.close();
        }
      }
    }
  }
}
