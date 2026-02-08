pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property IssueListModel issueModel

  readonly property alias issuesGridView: issuesGridId

  signal cardClicked(string htmlUrl)

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundGlass
    GridView {
      id: issuesGridId

      anchors.fill: parent

      model: rootId.issueModel

      cellWidth: {
        let columns = Math.floor(ApplicationWindow.window.width / ApplicationWindow.window.minimumWidth);
        return ApplicationWindow.window.minimumWidth + ((ApplicationWindow.window.width % ApplicationWindow.window.minimumWidth) / columns);
      }
      cellHeight: cellWidth / 2

      clip: true

      delegate: IssueCard {
        id: issueCardDelegateId
        required property string repoFullName
        required property string title
        required property string userLogin
        required property string issueState
        required property string commentsCount
        required property date createdAt
        required property string htmlUrl

        repoFullNameField: issueCardDelegateId.repoFullName
        titleField: issueCardDelegateId.title
        userLoginField: issueCardDelegateId.userLogin
        issueStateField: issueCardDelegateId.issueState
        commentsCountField: issueCardDelegateId.commentsCount
        createdAtField: issueCardDelegateId.createdAt

        cardWidth: issuesGridId.cellWidth
        cardHeight: issuesGridId.cellHeight
        cardMargins: 10

        onClicked: function () {
          rootId.cardClicked(issueCardDelegateId.htmlUrl);
        }
      }
    }
  }
}
