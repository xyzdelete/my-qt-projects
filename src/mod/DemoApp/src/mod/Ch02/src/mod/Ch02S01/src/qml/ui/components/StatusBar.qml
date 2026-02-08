pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  required property var theme
  required property var repositories
  property int repositoryCount: 0
  property string currentView: "repositories"
  property bool isLoading: false
  property string lastUpdated: ""

  // Status bar
  Rectangle {
    id: rootStatusBar
    anchors.fill: parent
    gradient: Gradient {
      GradientStop {
        position: 0.0
        color: root.theme.accent
        Behavior on color {
          ColorAnimation {
            duration: root.theme.normalAnimation
          }
        }
      }
      GradientStop {
        position: 1.0
        color: root.theme.accentHover
        Behavior on color {
          ColorAnimation {
            duration: root.theme.normalAnimation
          }
        }
      }
    }
    border.color: root.theme.glassBorder
    border.width: 1
    Behavior on color {
      ColorAnimation {
        duration: root.theme.normalAnimation
      }
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      RowLayout {
        Layout.fillWidth: true
        spacing: 10

        Item {
          Layout.fillWidth: true
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Rectangle {
            Layout.preferredWidth: 10
            Layout.preferredHeight: 10
            radius: 5
            border.width: 1

            color: {
              if (root.isLoading) {
                return root.theme.warning;
              }

              if (root.repositoryCount > 0) {
                return root.theme.success;
              }
              return root.theme.textTertiary;
            }

            Behavior on color {
              ColorAnimation {
                duration: root.theme.normalAnimation
              }
            }

            SequentialAnimation on color {
              running: root.isLoading
              loops: Animation.Infinite
              ColorAnimation {
                to: root.theme.warning
                duration: root.theme.normalAnimation * 4
              }

              ColorAnimation {
                to: root.theme.warningHover
                duration: root.theme.normalAnimation * 4
              }
            }
          }

          Text {
            text: {
              if (root.isLoading) {
                return "Loading repositories...";
              }

              if (root.repositoryCount === 0) {
                return "Nothing found";
              }

              const count = root.repositoryCount;
              const label = count === 1 ? "repository" : "repositories";
              return `Found ${count} ${label}`;
            }

            color: root.theme.textPrimary
            font.weight: Font.Bold
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: root.theme.normalAnimation
              }
            }
          }
        }
        Rectangle {
          Layout.preferredWidth: 1
          Layout.preferredHeight: 20
          color: root.theme.glassBorder

          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }
        }
        // Current view indicator
        Rectangle {
          Layout.preferredWidth: viewText.implicitWidth + 10
          Layout.preferredHeight: 20
          radius: 10
          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: root.theme.accent
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.normalAnimation
                }
              }
            }
            GradientStop {
              position: 1.0
              color: root.theme.accentHover
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.normalAnimation
                }
              }
            }
          }
          border.color: root.theme.glassBorder
          border.width: 1

          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }

          Behavior on border.color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }

          Text {
            id: viewText
            anchors.centerIn: parent
            text: {
              switch (root.currentView) {
              case "search":
                return " Search Results";
              case "user":
                return " User Repositories";
              default:
                return "⭐ Popular Repositories";
              }
            }
            color: root.theme.textPrimary
            font.pixelSize: 10
            font.weight: Font.Bold
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }

      RowLayout {
        Layout.fillWidth: true
        visible: lastUpdatedTextId.visible
        Item {
          Layout.fillWidth: true
        }
        // Last updated info
        Text {
          id: lastUpdatedTextId
          visible: root.lastUpdated.length > 0
          text: `Updated ${root.lastUpdated}`
          color: root.theme.textPrimary
          font.pixelSize: 12
          font.weight: Font.Bold
          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }

      RowLayout {
        Layout.fillWidth: true
        spacing: 5
        Item {
          Layout.fillWidth: true
        }
        RowLayout {
          spacing: 5
          Rectangle {
            Layout.preferredHeight: 10
            Layout.preferredWidth: 10
            radius: 5
            color: root.theme.success
            border.color: root.theme.glassBorder
            border.width: 1

            Behavior on color {
              ColorAnimation {
                duration: root.theme.normalAnimation
              }
            }

            SequentialAnimation on color {
              running: true
              loops: Animation.Infinite
              ColorAnimation {
                to: root.theme.accent
                duration: root.theme.normalAnimation * 8
              }

              ColorAnimation {
                to: root.theme.accentHover
                duration: root.theme.normalAnimation * 8
              }
            }
          }

          Text {
            id: textApiStatus
            text: "GitHub API Connected"
            color: root.theme.textPrimary
            font.pixelSize: 14
            font.weight: Font.Bold
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }
    }
  }
}
