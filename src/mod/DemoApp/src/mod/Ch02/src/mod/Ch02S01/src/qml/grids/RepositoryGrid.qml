pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property RepositoryListModel repoModel

  readonly property alias repositoryGridView: repositoryGridId

  signal cardClicked(string htmlUrl)

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundGlass
    GridView {
      id: repositoryGridId

      anchors.fill: parent

      model: rootId.repoModel

      cellWidth: {
        let columns = Math.floor(ApplicationWindow.window.width / ApplicationWindow.window.minimumWidth);
        return ApplicationWindow.window.minimumWidth + ((ApplicationWindow.window.width % ApplicationWindow.window.minimumWidth) / columns);
      }
      cellHeight: cellWidth / 2

      clip: true

      delegate: RepoCard {
        id: repoCardDelegateId
        required property string name
        required property bool isPrivate
        required property string description
        required property string language
        required property int stargazersCount
        required property int forksCount
        required property date updatedAt
        required property string htmlUrl

        nameField: repoCardDelegateId.name
        isPrivateField: repoCardDelegateId.isPrivate
        descriptionField: repoCardDelegateId.description
        languageField: repoCardDelegateId.language
        stargazersCountField: repoCardDelegateId.stargazersCount
        forksCountField: repoCardDelegateId.forksCount
        updatedAtField: repoCardDelegateId.updatedAt

        cardWidth: repositoryGridId.cellWidth
        cardHeight: repositoryGridId.cellHeight
        cardMargins: 10

        onClicked: function () {
          rootId.cardClicked(htmlUrl);
        }
      }
    }
  }
}
