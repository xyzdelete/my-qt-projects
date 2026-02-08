pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  anchors.fill: parent
  color: appTheme.glassBackground
  border.color: '#0400ff'
  border.width: 1
  property string currentView: "repositories"

  Behavior on color {
    ColorAnimation {
      duration: appTheme.normalAnimation
    }
  }

  Theme {
    id: appTheme
  }

  property var repositories: [
    {
      fullName: "microsoft/vscode",
      description: "Visual Studio Code - Open source code editor",
      language: "TypeScript",
      stargazersCount: "142000",
      forksCount: "25000",
      isPrivate: false,
      updatedAt: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000),
      htmlUrl: "https://github.com/microsoft/vscode"
    },
    {
      fullName: "torvalds, linux",
      description: "Linux kernel source tree",
      language: "C",
      stargazersCount: "165000",
      forksCount: "48000",
      isPrivate: false,
      updatedAt: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000),
      htmlUrl: "https://github.com/torvalds/linux"
    },
    {
      fullName: "microsoft/vscode",
      description: "Visual Studio Code - Open source code editor",
      language: "TypeScript",
      stargazersCount: "142000",
      forksCount: "25000",
      isPrivate: true,
      updatedAt: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000),
      htmlUrl: "https://github.com/microsoft/vscode"
    },
    {
      fullName: "torvalds, linux",
      description: "Linux kernel source tree",
      language: "C",
      stargazersCount: "165000",
      forksCount: "48000",
      isPrivate: true,
      updatedAt: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000),
      htmlUrl: "https://github.com/torvalds/linux"
    }
  ]

  ColumnLayout {
    anchors.fill: parent
    spacing: 10

    // Header
    Rectangle {
      id: header
      Layout.fillWidth: true
      Layout.preferredHeight: 140
      border.width: 1
      border.color: appTheme.glassBorder

      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: appTheme.accent
          Behavior on color {
            ColorAnimation {
              duration: appTheme.normalAnimation
            }
          }
        }
        GradientStop {
          position: 1.0
          color: appTheme.accentHover
          Behavior on color {
            ColorAnimation {
              duration: appTheme.normalAnimation
            }
          }
        }
      }

      Behavior on color {
        ColorAnimation {
          duration: appTheme.normalAnimation
        }
      }
      Behavior on border.color {
        ColorAnimation {
          duration: appTheme.normalAnimation
        }
      }

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        // App branding
        RowLayout {
          Layout.alignment: Qt.AlignHCenter
          spacing: 10
          // App logo
          Rectangle {
            id: appLogo
            width: 50
            height: 50
            radius: 15
            anchors.verticalCenter: parent.verticalCenter
            gradient: Gradient {
              GradientStop {
                position: 0.0
                color: appLogoMouseArea.pressed ? appTheme.accent : appLogoHoverHandler.hovered ? appTheme.accentHover : appTheme.accent
                Behavior on color {
                  ColorAnimation {
                    duration: appTheme.normalAnimation
                  }
                }
              }
              GradientStop {
                position: 1.0
                color: appLogoMouseArea.pressed ? appTheme.accentHover : appLogoHoverHandler.hovered ? appTheme.accent : appTheme.accentHover
                Behavior on color {
                  ColorAnimation {
                    duration: appTheme.normalAnimation
                  }
                }
              }
            }
            Image {
              id: headerIcon
              anchors.centerIn: parent
              source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/headerIcon.svg"
              sourceSize: Qt.size(40, 40)
            }

            MouseArea {
              id: appLogoMouseArea
              anchors.fill: parent
              onClicked: function () {
                Qt.openUrlExternally("https://github.com/xyzdelete/");
              }
              HoverHandler {
                id: appLogoHoverHandler
                cursorShape: Qt.PointingHandCursor
              }
            }
          }

          ColumnLayout {
            spacing: 5

            Text {
              text: "Github Explorer"
              color: appTheme.textPrimary
              font.pixelSize: 20
              font.weight: Font.Bold

              Behavior on color {
                ColorAnimation {
                  duration: appTheme.normalAnimation
                }
              }
            }

            Text {
              text: "Discover repositories"
              color: appTheme.textSecondary
              font.pixelSize: 12

              Behavior on color {
                ColorAnimation {
                  duration: appTheme.normalAnimation
                }
              }
            }
          }

          ColumnLayout {
            spacing: 5

            Image {
              id: themeIcon
              Layout.alignment: Qt.AlignHCenter
              Layout.preferredWidth: 20
              Layout.preferredHeight: 20
              source: appTheme.isDark ? "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/darkThemeIcon.svg" : "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/lightThemeIcon.svg"
            }

            // Theme toggle
            CustomSwitch {
              id: themeSwitch
              theme: appTheme
              Layout.preferredWidth: 60
              Layout.preferredHeight: 30
              Layout.alignment: Qt.AlignHCenter

              onToggled: function () {
                appTheme.toggleTheme();
              }
            }
          }
        }

        CustomButton {
          id: menuButton
          theme: appTheme
          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter
          iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/menuIcon.svg"

          onClicked: function () {
            drawer.open();
          }
        }
      }
    }

    ScrollView {
      id: scrollView
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      contentWidth: availableWidth

      GridView {
        id: repositoryGrid
        anchors.fill: parent
        anchors.margins: 10
        model: root.repositories
        cellWidth: ApplicationWindow.window.minimumWidth - 10 * 2
        cellHeight: cellWidth / 2 + 10 * 2
        delegate: RepoCard {
          required property var modelData
          width: repositoryGrid.cellWidth
          height: repositoryGrid.cellHeight
          repositoryData: modelData
          theme: appTheme

          onClicked: function () {
            ApplicationWindow.window.title = "Clicked: " + repositoryData.fullName;

            if (repositoryData.htmlUrl) {
              Qt.openUrlExternally(repositoryData.htmlUrl);
            }
          }
        }
      }
    }

    StatusBar {
      id: statusBar
      Layout.fillWidth: true
      Layout.preferredHeight: 100

      theme: appTheme
      repositories: root.repositories
      repositoryCount: root.repositories.length
      currentView: root.currentView
      isLoading: false
      lastUpdated: new Date()
    }
  }
  Drawer {
    id: drawer
    width: ApplicationWindow.window.width * 0.90
    height: ApplicationWindow.window.height

    background: Rectangle {
      anchors.fill: parent
      color: appTheme.glassBackground
      border.color: appTheme.glassBorder
      border.width: 1
      radius: 10
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10
      SearchBar {
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 50
        theme: appTheme
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/searchIcon.svg"
        onSearchRequested: function (query) {
          if (query.trim().length > 0) {
            root.currentView = "search";
            ApplicationWindow.window.title = query;
          }
        }
        onUserSearchRequested: function (username) {
          if (username.trim().length > 0) {
            root.currentView = "user";
            ApplicationWindow.window.title = username;
          }
        }
      }
      TokenInput {
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 50
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/tokenInputIcon.svg"
        theme: appTheme
        onTokenChanged: function (token) {
          // githubService.authToken = token
          ApplicationWindow.window.title = "TokenChanged";
        }
      }

      CustomButton {
        id: popularButton
        Layout.preferredWidth: 120
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: appTheme

        onClicked: function () {
          root.currentView = "repositories";
          ApplicationWindow.window.title = root.currentView;
        // githubService.fetchUserRepositories("")
        }
        contentItem: Text {
          anchors.centerIn: parent
          text: "⭐ Popular"
          color: appTheme.textPrimary
          font.pixelSize: 14
          font.weight: Font.Bold

          Behavior on color {
            ColorAnimation {
              duration: appTheme.normalAnimation
            }
          }
        }
      }

      CustomButton {
        id: refreshButton
        Layout.preferredWidth: 120
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: appTheme

        onClicked: function () {
          ApplicationWindow.window.title = "Refresh";
          switch (root.currentView) {
          case "search":
            // Will need to implement refresh for search
            break;
          case "user":
            // Will need to implement refresh for user
            break;
          default:
          // githubService.fetchUserRepositories("")
          }
        }
        contentItem: Text {
          anchors.centerIn: parent
          text: "🔄 Refresh"
          color: appTheme.textPrimary
          font.pixelSize: 14
          font.weight: Font.Bold

          Behavior on color {
            ColorAnimation {
              duration: appTheme.normalAnimation
            }
          }
        }
      }

      // View status
      Text {
        Layout.alignment: Qt.AlignHCenter
        text: {
          switch (root.currentView) {
          case "search":
            return " Search Results";
          case "user":
            return " User Repositories";
          default:
            return " Popular Repositories";
          }
        }
        color: appTheme.textPrimary
        font.pixelSize: 12

        Behavior on color {
          ColorAnimation {
            duration: appTheme.normalAnimation
          }
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
        theme: appTheme
        iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/menuCloseIcon.svg"

        onClicked: function () {
          drawer.close();
        }
      }
    }
  }
}
