pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
  id: rootId

  required property ContactManager contactManager

  property int repositoryCount: 0
  property string currentView: "repositories"
  property bool isLoading: false
  property string lastUpdated: ""

  // Status bar
  Rectangle {
    id: rootIdStatusBarId

    anchors.fill: parent
    border.color: Theme.glassBorder
    border.width: 1
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
          spacing: 5
          Layout.fillWidth: true
          Image {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            source: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/totalContactsIcon.svg"
            sourceSize: Qt.size(25, 25)
          }
          Text {
            text: "Total: " + rootId.contactManager.totalContacts

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
          Layout.preferredWidth: viewTextId.implicitWidth + 40
          Layout.preferredHeight: viewTextId.implicitHeight + 20
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

          RowLayout {
            anchors.fill: parent
            Item {
              Layout.fillWidth: true
            }
            Image {
              Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
              source: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteStarIcon.svg"
              sourceSize: Qt.size(10, 10)
            }
            Text {
              id: viewTextId

              Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
              text: "Favorites: " + rootId.contactManager.favoritesCount
              color: Theme.textPrimary
              font.pixelSize: 12
              font.weight: Font.Bold
            }
            Item {
              Layout.fillWidth: true
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
            text: "ContactManagerApp v1.0.0.0"
            color: Theme.textPrimary
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
