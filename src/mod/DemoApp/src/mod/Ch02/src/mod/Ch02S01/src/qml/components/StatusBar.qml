pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
  id: rootId

  required property real safeAreaBottomMargin

  property int repositoryCount: 0
  property string currentView: "repositories"
  property bool isLoading: false
  property string lastUpdated: ""

  // Status bar
  Rectangle {
    id: rootIdStatusBar

    anchors.fill: parent
    anchors.bottomMargin: rootId.safeAreaBottomMargin

    Rectangle {
      anchors.top: parent.top
      height: 1
      width: parent.width
      color: Theme.glassBorder
    }

    gradient: Gradient {
      GradientStop {
        position: 0.0
        color: Theme.backgroundGlassFooterGradientStart
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: Theme.backgroundGlassFooterGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
    }

    Behavior on color {
      ColorAnimation {
        duration: Theme.animationDuration
      }
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10

      Item {
        Layout.fillHeight: true
      }

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
              if (rootId.repositoryCount > 0) {
                return Theme.infoGlass;
              }
              return Theme.warningGlass;
            }

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }

            SequentialAnimation on color {
              running: rootId.isLoading
              loops: Animation.Infinite
              ColorAnimation {
                to: Theme.textPrimary
                duration: Theme.animationDuration * 2
              }

              ColorAnimation {
                to: Theme.accentGlass
                duration: Theme.animationDuration * 2
              }
            }
          }

          Text {
            text: {
              if (rootId.isLoading) {
                return "Loading repositories...";
              }

              if (rootId.repositoryCount === 0) {
                return "Nothing found";
              }

              const count = rootId.repositoryCount;
              const label = count === 1 ? "repository" : "repositories";
              return `Found ${count} ${label}`;
            }

            color: Theme.textPrimary
            font.weight: Font.Bold
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }
        Rectangle {
          Layout.preferredWidth: 1
          Layout.preferredHeight: 20
          color: Theme.glassBorder

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        // Current view indicator
        Rectangle {
          Layout.preferredWidth: viewTextId.implicitWidth + 10
          Layout.preferredHeight: viewTextId.implicitHeight + 10
          radius: 10
          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: Theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: Theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }
          border.color: Theme.glassBorder
          border.width: 1

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }

          Behavior on border.color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }

          Text {
            id: viewTextId

            anchors.centerIn: parent
            text: {
              switch (rootId.currentView) {
              case "search":
                return "Search Results";
              case "user":
                return "User Repositories";
              case "myrepos":
                return "My Repos";
              default:
                return "Popular Repositories";
              }
            }
            color: Theme.textPrimary
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
            color: Theme.textPrimary
            border.color: Theme.glassBorder
            border.width: 1

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }

            SequentialAnimation on color {
              running: true
              loops: Animation.Infinite
              ColorAnimation {
                to: Theme.textPrimary
                duration: Theme.animationDuration * 8
              }

              ColorAnimation {
                to: Theme.accentGlass
                duration: Theme.animationDuration * 8
              }
            }
          }

          Text {
            id: textApiStatusId

            text: "GitHub API Connected"
            color: Theme.textPrimary
            font.pixelSize: 14
            font.weight: Font.Bold
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }

      RowLayout {
        id: lastUpdatedRowId

        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        // Last updated info
        Text {
          id: lastUpdatedTextId

          visible: rootId.lastUpdated.length > 0
          text: `Updated at ${rootId.lastUpdated}`
          color: Theme.textPrimary
          font.pixelSize: 12
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

      Item {
        Layout.fillHeight: true
      }
    }
  }
}
