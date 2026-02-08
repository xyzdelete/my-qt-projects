pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Item {
  id: root
  required property var theme
  required property string currentView
  required property var githubService

  signal repositoryClicked(var repositoryData)

  ScrollView {
    id: scrollView
    anchors.fill: parent
    clip: true

    background: Rectangle {
      color: root.theme.backgroundGlass
    }

    GridView {
      id: repositoryGrid
      anchors.fill: parent
      anchors.margins: 10
      model: root.githubService.repositories
      cellWidth: ApplicationWindow.window.minimumWidth - 10 * 2
      cellHeight: cellWidth / 2 + 10 * 2
      readonly property int columnsThatFit: Math.max(1, Math.floor(width / cellWidth))
      leftMargin: Math.max(0, (width - columnsThatFit * cellWidth) / 2)
      delegate: RepoCard {
        required property var modelData
        width: repositoryGrid.cellWidth
        height: repositoryGrid.cellHeight
        repositoryData: modelData
        theme: root.theme

        onClicked: function () {
          root.repositoryClicked(repositoryData);
        }
      }

      // Empty state
      EmptyState {
        anchors.fill: parent
        theme: root.theme
        currentView: root.currentView
        isVisible: repositoryGrid.count === 0 && !root.githubService.isLoading
      }

      // Loading overlay
      LoadingOverlay {
        anchors.fill: parent
        theme: root.theme
        isVisible: root.githubService.isLoading
        githubService: root.githubService
      }
    }
  }
}
