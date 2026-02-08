pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId
  anchors.fill: parent

  // repositories, search, user
  property string currentView: "repositories"
  property string lastUpdated: ""
  property string lastSearchQuery: ""
  property string lastUsername: ""
  property real appWidth: ApplicationWindow.window.width
  property real appHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)
  property real appWindowSafeAreaTopMargin: ApplicationWindow.window.SafeArea.margins.top
  GitHubService {
    id: gitHubServiceId
    onRepositoriesChanged: function () {
      rootId.lastUpdated = new Date().toLocaleTimeString(Qt.locale(), "hh:mm");
    }
  }
  DrawerMenu {
    id: drawerMenuId

    gitHubService: gitHubServiceId
    currentView: rootId.currentView

    drawerWidth: rootId.appWidth
    drawerHeight: rootId.appHeight

    drawer.x: 0
    drawer.y: rootId.appWindowSafeAreaTopMargin

    onViewChanged: function (view) {
      rootId.lastSearchQuery = drawerMenuId.lastSearchQuery;
      rootId.lastUsername = drawerMenuId.lastUsername;
      rootId.currentView = view;
    }

    onRefreshRequested: function () {
      switch (rootId.currentView) {
      case "search":
        if (rootId.lastSearchQuery.length > 0) {
          gitHubServiceId.searchRepositories(rootId.lastSearchQuery);
        }
        break;
      case "user":
        if (rootId.lastUsername.length > 0) {
          gitHubServiceId.fetchUserRepositories(rootId.lastUsername);
        }
        break;
      case "myrepos":
        gitHubServiceId.fetchAuthenticatedUserRepositories();
        break;
      default:
        gitHubServiceId.searchRepositories("stars:>200000", "stars", "desc");
      }
      drawerMenuId.drawer.close();
    }
  }

  StackLayout {
    anchors.fill: parent

    currentIndex: drawerMenuId.selectedPageIndex

    RepositoriesPage {
      gitHubService: gitHubServiceId
      drawerMenu: drawerMenuId
      currentView: rootId.currentView
      lastUpdated: rootId.lastUpdated
      lastSearchQuery: rootId.lastSearchQuery
      lastUsername: rootId.lastUsername
    }

    IssuesPage {}

    UsersPage {}
  }
}
