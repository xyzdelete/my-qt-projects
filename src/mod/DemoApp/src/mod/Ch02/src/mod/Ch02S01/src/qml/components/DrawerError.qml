pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property RepositoryListModel repoModel
  // Optional, so errors of the issue and user searches are shown too
  property IssueListModel issueModel: null
  property UserListModel userModel: null

  required property real drawerWidth
  required property real drawerHeight

  property alias drawer: drawerId
  property alias interactive: drawerId.interactive

  width: rootId.drawerWidth
  height: rootId.drawerHeight

  Drawer {
    id: drawerId

    width: parent.width
    height: parent.height

    background: Rectangle {
      color: Theme.backgroundGlass
    }

    Overlay.modal: Rectangle {
      color: "transparent"
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10

      // Error state
      ErrorState {
        id: errorStateId
        Layout.fillWidth: true
        Layout.fillHeight: true
      }

      CustomButton {
        id: menuCloseButton

        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/menuCloseIcon.svg"

        onClicked: function () {
          drawerId.close();
        }
      }
    }
  }

  function showError(message) {
    if (message.length > 0) {
      errorStateId.text = message;
      drawerId.open();
    }
  }

  Connections {
    target: rootId.repoModel.service
    function onErrorMessageChanged() {
      rootId.showError(rootId.repoModel.service.errorMessage);
    }
  }

  Connections {
    target: rootId.issueModel ? rootId.issueModel.service : null
    function onErrorMessageChanged() {
      rootId.showError(rootId.issueModel.service.errorMessage);
    }
  }

  Connections {
    target: rootId.userModel ? rootId.userModel.service : null
    function onErrorMessageChanged() {
      rootId.showError(rootId.userModel.service.errorMessage);
    }
  }
}
