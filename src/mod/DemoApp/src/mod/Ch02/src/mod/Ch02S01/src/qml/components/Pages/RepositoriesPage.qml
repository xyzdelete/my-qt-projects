pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
  id: rootId
  required property RepositoryListModel repoModel
  required property DrawerMenu drawerMenu

  // repositories, search, user
  property string lastUpdated: ""
  property string lastSearchQuery: ""
  property string lastUsername: ""
  property real appWidth: ApplicationWindow.window.width
  property real appWindowSafeAreaTopMargin: ApplicationWindow.window.SafeArea.margins.top
  property real appWindowSafeAreaBottomMargin: ApplicationWindow.window.SafeArea.margins.bottom

  background: Rectangle {
    color: Theme.backgroundGlass
  }

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

    secondHeaderText: {
      if (rootId.drawerMenu.currentPage === 0) {
        return "Discover repositories";
      } else if (rootId.drawerMenu.currentPage === 1) {
        return "Discover issues";
      } else if (rootId.drawerMenu.currentPage === 2) {
        return "Discover users";
      } else {
        return "Discover repositories";
      }
    }
  }

  // Footer
  readonly property Item appFooter: StatusBar {
    id: appFooterId
    statusRowIdVisible: rootId.drawerMenu.currentPage === 0
    repoModel: rootId.repoModel

    safeAreaBottomMargin: rootId.appWindowSafeAreaBottomMargin
    height: 100 + appFooterId.safeAreaBottomMargin
    width: rootId.appWidth
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
      id: repoGridId
      Layout.fillWidth: true
      Layout.fillHeight: true

      repoModel: rootId.repoModel

      onCardClicked: function (htmlUrl) {
        if (htmlUrl) {
          Qt.openUrlExternally(htmlUrl);
        }
      }
    }
  }

  CustomButton {
    id: loadMoreButton

    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    width: 100
    height: 50

    visible: repoGridId.repositoryGridView.atYEnd && !rootId.repoModel.useCursor && rootId.repoModel.hasMore && !rootId.repoModel.isLoadingPage

    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0

    contentItem: Text {
      text: "Load more"
      font.pointSize: 12
      color: Theme.textPrimary
      horizontalAlignment: Qt.AlignHCenter
      verticalAlignment: Qt.AlignVCenter
    }

    onClicked: function () {
      rootId.repoModel.loadMore();
    }
  }

  Connections {
    target: repoGridId.repositoryGridView
    function onAtYEndChanged() {
      if (repoGridId.repositoryGridView.atYEnd && rootId.repoModel.useCursor && rootId.repoModel.hasMore && !rootId.repoModel.isLoadingPage)
        rootId.repoModel.fetchNextPage();
    }
  }

  // Empty state
  EmptyState {
    anchors.fill: parent

    isVisible: !rootId.repoModel.isLoadingPage && rootId.repoModel.count === 0
  }
}
