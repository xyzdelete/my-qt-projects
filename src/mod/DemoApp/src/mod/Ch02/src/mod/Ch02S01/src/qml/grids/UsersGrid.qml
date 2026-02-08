pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property UserListModel userModel

  readonly property alias usersGridView: usersGridId

  signal cardClicked(string htmlUrl)

  Rectangle {
    anchors.fill: parent
    color: Theme.backgroundGlass
    GridView {
      id: usersGridId

      anchors.fill: parent

      model: rootId.userModel

      cellWidth: {
        let columns = Math.floor(ApplicationWindow.window.width / ApplicationWindow.window.minimumWidth);
        return ApplicationWindow.window.minimumWidth + ((ApplicationWindow.window.width % ApplicationWindow.window.minimumWidth) / columns);
      }
      cellHeight: cellWidth / 2

      clip: true

      delegate: UserCard {
        id: userCardDelegateId

        required property string avatarUrl
        required property string login
        required property string userType
        required property string htmlUrl

        avatarUrlField: userCardDelegateId.avatarUrl
        loginField: userCardDelegateId.login
        userTypeField: userCardDelegateId.userType
        htmlUrlField: userCardDelegateId.htmlUrl

        cardWidth: usersGridId.cellWidth
        cardHeight: usersGridId.cellHeight
        cardMargins: 10

        onClicked: function () {
          rootId.cardClicked(userCardDelegateId.htmlUrl);
        }
      }
    }
  }
}
