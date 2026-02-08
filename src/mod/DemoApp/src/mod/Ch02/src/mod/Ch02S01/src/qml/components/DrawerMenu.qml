pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property GitHubService gitHubService
  required property string currentView
  required property real drawerWidth
  required property real drawerHeight

  property alias drawer: drawerId
  property int selectedPageIndex: -1

  property string lastSearchQuery
  property string lastUsername

  readonly property string authToken: gitHubService.authToken
  readonly property bool hasToken: authToken.length > 0

  signal refreshRequested
  signal viewChanged(string view)

  width: rootId.drawerWidth
  height: rootId.drawerHeight

  Drawer {
    id: drawerId

    width: parent.width
    height: parent.height

    background: Rectangle {
      color: Theme.backgroundGlass
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10

      SearchBar {
        id: searchBarId

        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 50
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/searchIcon.svg"
        onSearchRequested: function (query) {
          if (query.trim().length > 0) {
            rootId.lastSearchQuery = query;
            rootId.gitHubService.searchRepositories(query);
            rootId.viewChanged("search");

            rootId.selectedPageIndex = 0;

            drawerId.close();
          }
        }
        onUserSearchRequested: function (username) {
          if (username.trim().length > 0) {
            rootId.lastUsername = username;
            rootId.gitHubService.fetchUserRepositories(username);
            rootId.viewChanged("user");

            rootId.selectedPageIndex = 0;

            drawerId.close();
          }
        }
        onSearchButtonClicked: function () {
          rootId.selectedPageIndex = 0;

          drawerId.close();
        }
      }

      TokenInput {
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 50
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/tokenInputIcon.svg"
        onTokenChanged: function (token) {
          rootId.gitHubService.authToken = token;
        }
        onTokenInputButtonClicked: function () {
          rootId.gitHubService.fetchAuthenticatedUserRepositories();

          rootId.selectedPageIndex = 0;

          drawerId.close();
        }
      }

      CustomButton {
        id: popularButtonId

        Layout.preferredWidth: 100
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        onClicked: function () {
          rootId.lastSearchQuery = "";
          rootId.lastUsername = "";
          rootId.viewChanged("repositories");
          rootId.gitHubService.searchRepositories("stars:>200000", "stars", "desc");

          rootId.selectedPageIndex = 0;

          drawerId.close();
        }

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0

        contentItem: RowLayout {
          spacing: 5
          Item {
            Layout.fillWidth: true
          }
          Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/starIcon.svg"
            sourceSize: Qt.size(10, 10)
          }
          Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "Popular"
            color: Theme.textPrimary
            font.pixelSize: 14
            font.weight: Font.Bold

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
      }

      CustomButton {
        id: refreshButtonId

        Layout.preferredWidth: 100
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        onClicked: function () {
          rootId.selectedPageIndex = 0;

          rootId.refreshRequested();
        }

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0

        contentItem: RowLayout {
          Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "Refresh"
            color: Theme.textPrimary
            font.pixelSize: 14
            font.weight: Font.Bold

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }
      }

      CustomButton {
        id: myReposButtonId

        Layout.preferredWidth: 100
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        visible: rootId.hasToken

        onClicked: function () {
          rootId.lastSearchQuery = "";
          rootId.lastUsername = "";
          rootId.viewChanged("myrepos");
          rootId.gitHubService.fetchAuthenticatedUserRepositories();

          rootId.selectedPageIndex = 0;

          drawerId.close();
        }

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0

        contentItem: RowLayout {
          Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "My Repos"
            color: Theme.textPrimary
            font.pixelSize: 14
            font.weight: Font.Bold

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }
      }

      // View status
      Text {
        Layout.alignment: Qt.AlignHCenter
        text: {
          switch (rootId.currentView) {
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
        color: Theme.textPrimary
        font.pixelSize: 12

        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Available pages"
        font.pointSize: 16
        color: Theme.textPrimary
      }
      ListView {
        id: pagesListViewContainerId
        Layout.fillWidth: true
        Layout.preferredHeight: 150
        clip: true
        model: ["Repositories", "Issues", "Users"]
        delegate: RowLayout {
          id: pagesListContainerId

          required property string modelData
          required property int index

          width: pagesListViewContainerId.width
          CustomButton {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignHCenter

            onClicked: function () {
              rootId.selectedPageIndex = pagesListContainerId.index;

              drawerId.close();
            }

            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0

            contentItem: RowLayout {
              Text {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: pagesListContainerId.modelData
                color: Theme.textPrimary
                font.pixelSize: 14
                font.weight: Font.Bold

                Behavior on color {
                  ColorAnimation {
                    duration: Theme.animationDuration
                  }
                }
              }
            }
          }
        }
        ScrollBar.vertical: ScrollBar {
          policy: ScrollBar.AlwaysOn

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

      Item {
        Layout.fillHeight: true
      }

      CustomButton {
        id: menuCloseButton

        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/menuCloseIcon.svg"

        onClicked: function () {
          drawerId.close();
        }
      }
    }
  }
}
