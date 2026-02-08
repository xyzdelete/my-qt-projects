pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId
  anchors.fill: parent

  // repositories, search, user
  property string lastUpdated: ""
  property string lastSearchQuery: ""
  property string lastUsername: ""
  property real appWidth: ApplicationWindow.window.width
  property real appHeight: ApplicationWindow.window.height - (ApplicationWindow.window.SafeArea.margins.top + ApplicationWindow.window.SafeArea.margins.bottom)
  property real appWindowSafeAreaTopMargin: ApplicationWindow.window.SafeArea.margins.top

  RepositoryListModel {
    id: repoModelId
  }

  IssueListModel {
    id: issueModelId
  }

  UserListModel {
    id: userModelId
  }

  DrawerMenu {
    id: drawerMenuId
    repoModel: repoModelId
    userModel: userModelId
    issueModel: issueModelId

    drawerWidth: rootId.appWidth
    drawerHeight: rootId.appHeight

    drawer.x: 0
    drawer.y: rootId.appWindowSafeAreaTopMargin
  }

  StackLayout {
    anchors.fill: parent

    currentIndex: drawerMenuId.currentPage

    RepositoriesPage {
      repoModel: repoModelId
      drawerMenu: drawerMenuId
      lastUpdated: rootId.lastUpdated
      lastSearchQuery: rootId.lastSearchQuery
      lastUsername: rootId.lastUsername
    }

    IssuesPage {
      issueModel: issueModelId
      drawerMenu: drawerMenuId
    }

    UsersPage {
      userModel: userModelId
      drawerMenu: drawerMenuId
    }
  }

  // Loading overlay
  LoadingOverlay {
    anchors.fill: parent

    repoModel: repoModelId
    issueModel: issueModelId
    userModel: userModelId

    isVisible: repoModelId.isLoadingPage || issueModelId.isLoadingPage || userModelId.isLoadingPage
  }

  DrawerError {
    id: drawerErrorId
    repoModel: repoModelId
    issueModel: issueModelId
    userModel: userModelId

    interactive: false

    drawerWidth: rootId.appWidth
    drawerHeight: rootId.appHeight

    drawer.x: 0
    drawer.y: rootId.appWindowSafeAreaTopMargin
  }
}
