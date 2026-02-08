pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property RepositoryListModel repoModel
  required property IssueListModel issueModel
  required property UserListModel userModel

  required property real drawerWidth
  required property real drawerHeight

  property alias drawer: drawerId
  property alias currentPage: searchModesComboBoxId.currentIndex

  property string lastSearchQuery
  property string lastUsername

  readonly property string authToken: repoModel.service.authToken
  readonly property bool hasToken: authToken.length > 0

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

      Item {
        Layout.fillHeight: true
      }
      RowLayout {
        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        SearchBar {
          id: searchBarId

          Layout.fillWidth: true
          Layout.preferredHeight: 50
          Layout.minimumWidth: 300
          Layout.maximumWidth: 600

          searchButtonEnabled: !rootId.repoModel.isLoadingPage && text.length > 0
          searchInputEnabled: !rootId.repoModel.isLoadingPage

          iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/searchIcon.svg"
          onSearchRequested: function (query) {
            if (query.trim().length > 0) {
              rootId.lastSearchQuery = query;

              if (searchModesComboBoxId.currentIndex === 0) {
                rootId.repoModel.search(query);
              } else if (searchModesComboBoxId.currentIndex === 1) {
                rootId.issueModel.search(query);
              } else if (searchModesComboBoxId.currentIndex === 2) {
                rootId.userModel.search(query);
              }

              drawerId.close();
            }
          }
          onSearchButtonClicked: function () {
            drawerId.close();
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }
      RowLayout {
        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        TokenInput {
          Layout.fillWidth: true
          Layout.preferredHeight: 50
          Layout.minimumWidth: 300
          Layout.maximumWidth: 600

          iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/tokenInputIcon.svg"
          onTokenChanged: function (token) {
            // Every model owns its own GitHubService, all need the token
            rootId.repoModel.service.authToken = token;
            rootId.issueModel.service.authToken = token;
            rootId.userModel.service.authToken = token;
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }
      Divider {
        Layout.fillWidth: true
      }
      RowLayout {
        Layout.fillWidth: true
        Text {
          Layout.fillWidth: true
          text: "Quick search"
          font.pixelSize: 16
          color: Theme.textPrimary
          horizontalAlignment: Qt.AlignHCenter
          verticalAlignment: Qt.AlignVCenter
        }
      }
      CustomButton {
        id: popularButtonId

        Layout.preferredWidth: 100
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        onClicked: function () {
          rootId.lastSearchQuery = "";
          rootId.lastUsername = "";

          rootId.repoModel.search("stars:>200000");

          drawerId.close();
        }

        topPadding: 0
        bottomPadding: 0
        leftPadding: 0
        rightPadding: 0

        contentItem: RowLayout {
          spacing: 5
          Item {
            Layout.fillWidth: true
          }
          Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/starIcon.svg"
            sourceSize: Qt.size(10, 10)
          }
          Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "Popular"
            color: Theme.textPrimary
            font.pixelSize: 14
            font.weight: Font.Bold

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
      }
      Divider {
        Layout.fillWidth: true
      }
      RowLayout {
        Layout.fillWidth: true
        Text {
          Layout.fillWidth: true
          text: "Features"
          font.pixelSize: 16
          color: Theme.textPrimary
          horizontalAlignment: Qt.AlignHCenter
          verticalAlignment: Qt.AlignVCenter
        }
      }
      RowLayout {
        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        CustomComboBox {
          id: searchModesComboBoxId
          repoModel: rootId.repoModel
          Layout.preferredWidth: 150
          Layout.preferredHeight: 40
          model: ["Repositories", "Issues", "Users"]
          text: "Search modes"
        }
        Item {
          Layout.fillWidth: true
        }
      }
      RowLayout {
        visible: searchModesComboBoxId.currentIndex === 0
        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        CustomComboBox {
          repoModel: rootId.repoModel
          Layout.preferredWidth: 150
          Layout.preferredHeight: 40
          model: ["Offset", "Cursor"]
          currentIndex: rootId.repoModel.useCursor ? 1 : 0
          onActivated: rootId.repoModel.useCursor = (currentIndex === 1)
          text: "Scroll modes"
        }
        Item {
          Layout.fillWidth: true
        }
      }
      RowLayout {
        id: sortModesRowLayoutId

        visible: searchModesComboBoxId.currentIndex === 0

        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        CustomComboBox {
          repoModel: rootId.repoModel
          Layout.preferredWidth: 150
          Layout.preferredHeight: 40
          model: ["Most updated", "Most starred"]
          currentIndex: rootId.repoModel.sortField === "updated" ? 0 : 1
          onActivated: function () {
            rootId.repoModel.sortField = (currentIndex === 0 ? "updated" : "stars");
            if (searchBarId.text.length > 0) {
              repoModel.search(searchBarId.text);
            }
          }
          text: "Sort modes"
        }
        Item {
          Layout.fillWidth: true
        }
      }
      RowLayout {
        visible: searchModesComboBoxId.currentIndex === 0
        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        Text {
          text: "Auto refresh " + (autoRefreshSwitchId.checked ? "ON" : "OFF")
          color: Theme.textPrimary
          font.pointSize: 12
          visible: !rootId.repoModel.useCursor
        }
        CustomSwitch {
          id: autoRefreshSwitchId
          checked: rootId.repoModel.autoRefresh && !rootId.repoModel.useCursor
          visible: !rootId.repoModel.useCursor
          onToggled: function () {
            rootId.repoModel.autoRefresh = checked;
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }
      Item {
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
}
