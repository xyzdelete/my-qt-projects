pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  anchors.fill: parent
  color: "#000000"
  border.color: appTheme.border
  border.width: 1
  // repositories, search, user
  property string currentView: "repositories"

  property string lastUpdated: ""
  property string lastSearchQuery: ""
  property string lastUsername: ""

  GitHubService {
    id: githubServiceId

    onRepositoriesChanged: function () {
      root.lastUpdated = new Date().toLocaleTimeString(Qt.locale(), "hh:mm");
    }
  }

  Behavior on color {
    ColorAnimation {
      duration: appTheme.animationDuration
    }
  }

  Theme {
    id: appTheme
  }

  // Header
  readonly property Item appHeader: Header {
    id: headerId
    height: 140 + ApplicationWindow.window.SafeArea.margins.top
    width: ApplicationWindow.window.width
    theme: appTheme
    onAppLogoClicked: function () {
      Qt.openUrlExternally("https://github.com/xyzdelete/");
    }
    onThemeToggled: function () {
      appTheme.toggleTheme();
    }
    onDrawerMenuOpened: function () {
      drawerMenu.drawer.open();
    }
  }

  // Footer
  readonly property Item appFooter: StatusBar {
    id: statusBarId
    width: ApplicationWindow.window.width
    height: 100 + ApplicationWindow.window.SafeArea.margins.bottom

    theme: appTheme
    repositoryCount: githubServiceId.repositories.length
    currentView: root.currentView
    isLoading: githubServiceId.isLoading
    lastUpdated: root.lastUpdated
  }

  Component.onCompleted: function () {
    ApplicationWindow.window.header = root.appHeader;
    ApplicationWindow.window.footer = root.appFooter;
  }

  ColumnLayout {
    id: contentItem
    anchors.fill: parent
    spacing: 0

    RepositoryGrid {
      Layout.fillWidth: true
      Layout.fillHeight: true
      theme: appTheme
      githubService: githubServiceId
      currentView: root.currentView

      onRepositoryClicked: function (repositoryData) {
        if (repositoryData.htmlUrl) {
          Qt.openUrlExternally(repositoryData.htmlUrl);
        }
      }
    }

    DrawerMenu {
      id: drawerMenu
      theme: appTheme
      githubService: githubServiceId
      currentView: root.currentView

      drawerWidth: ApplicationWindow.window.width * 0.9
      drawerHeight: ApplicationWindow.window.height

      onViewChanged: function (view) {
        root.lastSearchQuery = drawerMenu.lastSearchQuery;
        root.lastUsername = drawerMenu.lastUsername;
        root.currentView = view;
      }

      onRefreshRequested: function () {
        ApplicationWindow.window.title = "root.lastSearchQuery: " + root.lastSearchQuery + " " + "root.lastUsername: " + root.lastUsername;
        switch (root.currentView) {
        case "search":
          if (root.lastSearchQuery.length > 0) {
            githubServiceId.searchRepositories(root.lastSearchQuery);
          }
          break;
        case "user":
          if (root.lastUsername.length > 0) {
            githubServiceId.fetchUserRepositories(root.lastUsername);
          }
          break;
        case "myrepos":
          githubServiceId.fetchAuthenticatedUserRepositories();
          break;
        default:
          githubServiceId.searchRepositories("stars:>200000", "stars", "desc");
        }
        drawerMenu.drawer.close();
      }
    }
  }
}
