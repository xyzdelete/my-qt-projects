pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Page {
  id: rootId
  required property IssueListModel issueModel
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

    IssuesGrid {
      id: issuesGridId
      Layout.fillWidth: true
      Layout.fillHeight: true

      issueModel: rootId.issueModel

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

    visible: issuesGridId.issuesGridView.atYEnd && rootId.issueModel.hasMore && !rootId.issueModel.isLoadingPage

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
      rootId.issueModel.loadMore();
    }
  }

  // Empty state
  EmptyState {
    anchors.fill: parent

    isVisible: !rootId.issueModel.isLoadingPage && rootId.issueModel.count === 0
  }
}
