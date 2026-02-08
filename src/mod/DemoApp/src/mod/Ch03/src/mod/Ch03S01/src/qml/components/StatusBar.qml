pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
  id: root
  required property var theme
  property int repositoryCount: 0
  property string currentView: "repositories"
  property bool isLoading: false
  property string lastUpdated: ""

  required property ContactManager contactManager

  // Status bar
  Rectangle {
    id: rootStatusBar
    anchors.fill: parent
    border.color: root.theme.glassBorder
    border.width: 1
    gradient: Gradient {
      GradientStop {
        position: 0.0
        color: root.theme.backgroundGlassFooterGradientStart
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: root.theme.backgroundGlassFooterGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
    }
    Behavior on color {
      ColorAnimation {
        duration: root.theme.animationDuration
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

          Text {
            text: "📋 Total: " + root.contactManager.totalContacts

            color: root.theme.textPrimary
            font.weight: Font.Bold
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
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
              duration: root.theme.animationDuration
            }
          }
        }
        // Current view indicator
        Rectangle {
          Layout.preferredWidth: viewText.implicitWidth + 10
          Layout.preferredHeight: viewText.implicitHeight + 10
          radius: 10
          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: root.theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: root.theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }
          border.color: root.theme.glassBorder
          border.width: 1

          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }

          Behavior on border.color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }

          Text {
            id: viewText
            anchors.centerIn: parent
            text: "⭐ Favorites: " + root.contactManager.favoritesCount
            color: root.theme.textPrimary
            font.pixelSize: 12
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
            color: root.theme.textPrimary
            border.color: root.theme.glassBorder
            border.width: 1

            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }

            SequentialAnimation on color {
              running: true
              loops: Animation.Infinite
              ColorAnimation {
                to: root.theme.textPrimary
                duration: root.theme.animationDuration * 8
              }

              ColorAnimation {
                to: root.theme.accentGlass
                duration: root.theme.animationDuration * 8
              }
            }
          }

          Text {
            id: textApiStatus
            text: "ContactManagerApp v1.0.0.0"
            color: root.theme.textPrimary
            font.pixelSize: 12
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
