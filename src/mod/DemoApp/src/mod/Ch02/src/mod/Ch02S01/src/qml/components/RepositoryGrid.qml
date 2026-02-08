pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property string currentView
  required property GitHubService gitHubService

  signal repositoryClicked(Repository repositoryData)

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundGlass
    GridView {
      id: repositoryGridId

      anchors.fill: parent

      model: rootId.gitHubService.repositories

      cellWidth: ApplicationWindow.window.minimumWidth
      cellHeight: cellWidth / 2

      delegate: RepoCard {
        required property Repository modelData
        cardWidth: repositoryGridId.cellWidth
        cardHeight: repositoryGridId.cellHeight
        cardMargins: 10
        repositoryData: modelData

        onClicked: function () {
          rootId.repositoryClicked(repositoryData);
        }
      }

      // Empty state
      EmptyState {
        anchors.fill: parent
        currentView: rootId.currentView
        isVisible: repositoryGridId.count === 0 && !rootId.gitHubService.isLoading
      }

      // Loading overlay
      LoadingOverlay {
        anchors.fill: parent
        isVisible: rootId.gitHubService.isLoading
        gitHubService: rootId.gitHubService
      }
    }
  }
}
