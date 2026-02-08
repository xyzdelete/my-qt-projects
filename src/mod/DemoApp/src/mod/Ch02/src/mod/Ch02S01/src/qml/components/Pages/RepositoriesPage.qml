pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
  id: rootId

  required property GitHubService gitHubService
  required property DrawerMenu drawerMenu

  // repositories, search, user
  property string currentView: "repositories"
  property string lastUpdated: ""
  property string lastSearchQuery: ""
  property string lastUsername: ""
  property real appWidth: ApplicationWindow.window.width
  property real appWindowSafeAreaTopMargin: ApplicationWindow.window.SafeArea.margins.top
  property real appWindowSafeAreaBottomMargin: ApplicationWindow.window.SafeArea.margins.bottom

  // Header
  readonly property Item appHeader: Header {
    id: appHeaderId

    safeAreaTopMargin: rootId.appWindowSafeAreaTopMargin
    height: 150 + appHeaderId.safeAreaTopMargin
    width: rootId.appWidth

    onAppLogoClicked: function () {
      Qt.openUrlExternally("https://github.com/xyzdelete/my-qt-projects/");
    }
    onThemeToggled: function () {
      Theme.toggleTheme();
    }
    onDrawerMenuOpened: function () {
      rootId.drawerMenu.drawer.open();
    }
  }

  // Footer
  readonly property Item appFooter: StatusBar {
    id: appFooterId

    safeAreaBottomMargin: rootId.appWindowSafeAreaBottomMargin
    height: 100 + appFooterId.safeAreaBottomMargin
    width: rootId.appWidth

    repositoryCount: rootId.gitHubService.repositories.length
    currentView: rootId.currentView
    isLoading: rootId.gitHubService.isLoading
    lastUpdated: rootId.lastUpdated
  }

  Component.onCompleted: function () {
    ApplicationWindow.window.header = appHeaderId;
    ApplicationWindow.window.footer = appFooterId;
  }

  ColumnLayout {
    id: contentItemId

    anchors.fill: parent
    spacing: 0

    RepositoryGrid {
      Layout.fillWidth: true
      Layout.fillHeight: true
      gitHubService: rootId.gitHubService
      currentView: rootId.currentView

      onRepositoryClicked: function (repositoryData) {
        if (repositoryData.htmlUrl) {
          Qt.openUrlExternally(repositoryData.htmlUrl);
        }
      }
    }
  }
}
