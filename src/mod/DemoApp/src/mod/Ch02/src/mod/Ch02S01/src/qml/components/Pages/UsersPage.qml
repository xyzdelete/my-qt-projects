pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
  id: rootId
  required property UserListModel userModel
  required property DrawerMenu drawerMenu

  property real appWidth: ApplicationWindow.window.width
  property real appWindowSafeAreaTopMargin: ApplicationWindow.window.SafeArea.margins.top
  property real appWindowSafeAreaBottomMargin: ApplicationWindow.window.SafeArea.margins.bottom

  background: Rectangle {
    color: Theme.backgroundGlass
  }

  ColumnLayout {
    id: contentItemId

    anchors.fill: parent
    spacing: 0

    UsersGrid {
      id: usersGridId
      Layout.fillWidth: true
      Layout.fillHeight: true

      userModel: rootId.userModel

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

    visible: usersGridId.usersGridView.atYEnd && rootId.userModel.hasMore && !rootId.userModel.isLoadingPage

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
      rootId.userModel.loadMore();
    }
  }

  // Empty state
  EmptyState {
    anchors.fill: parent

    isVisible: !rootId.userModel.isLoadingPage && rootId.userModel.count === 0
  }
}
