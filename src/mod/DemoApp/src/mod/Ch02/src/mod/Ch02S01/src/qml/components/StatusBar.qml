pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
  id: rootId

  required property RepositoryListModel repoModel
  required property real safeAreaBottomMargin

  property alias statusRowIdVisible: statusRowId.visible

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
          id: statusRowId
          spacing: 10
          Layout.fillWidth: true

          Rectangle {
            Layout.preferredWidth: 10
            Layout.preferredHeight: 10
            radius: 5
            border.width: 1

            color: {
              if (rootId.repoModel.count > 0) {
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
              running: rootId.repoModel.isLoadingPage
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
          Rectangle {
            Layout.preferredHeight: statusTextId.implicitHeight + 10
            Layout.preferredWidth: statusTextId.implicitWidth + 20
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
            radius: 10
            Text {
              id: statusTextId

              anchors.fill: parent
              text: rootId.repoModel.useCursor ? (rootId.repoModel.count + " loaded | " + (rootId.repoModel.hasMore ? "more available" : "end reached")) : (rootId.repoModel.currentPage > 0 ? rootId.repoModel.count + " of " + rootId.repoModel.totalCount + " | page " + rootId.repoModel.currentPage : "No repositories")

              verticalAlignment: Qt.AlignVCenter
              horizontalAlignment: Qt.AlignHCenter

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
        }

        Item {
          Layout.fillWidth: true
        }
      }

      RowLayout {
        visible: rootId.repoModel.autoRefresh && !rootId.repoModel.useCursor
        Layout.fillWidth: true
        Item {
          Layout.fillWidth: true
        }
        Rectangle {
          Layout.preferredWidth: refreshedTimeTextId.implicitWidth + 20
          Layout.preferredHeight: refreshedTimeTextId.implicitHeight + 10
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
          radius: 10
          Text {
            id: refreshedTimeTextId
            anchors.fill: parent
            text: "Refreshed at: " + (rootId.repoModel?.lastRefreshAt > 0 ? (rootId.repoModel.lastRefreshAt.toLocaleString(Qt.locale(), "dd.MM.yyyy HH:mm:ss")) : "in progress...")
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

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

      Item {
        Layout.fillHeight: true
      }
    }
  }
}
