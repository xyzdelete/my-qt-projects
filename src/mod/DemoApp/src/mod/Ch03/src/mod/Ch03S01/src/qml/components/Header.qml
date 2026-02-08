pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
  id: rootId

  signal drawerMenuOpened
  signal appLogoClicked
  signal themeToggled
  signal addContactRequested

  Rectangle {
    id: headerId

    anchors.fill: parent
    border.color: Theme.glassBorder
    border.width: 1
    gradient: Gradient {
      GradientStop {
        position: 0.0
        color: Theme.backgroundGlassHeaderGradientStart
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: Theme.backgroundGlassHeaderGradientEnd
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
    Behavior on border.color {
      ColorAnimation {
        duration: Theme.animationDuration
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
        CustomButton {
          id: appLogoButtonId

          Layout.preferredHeight: 70
          Layout.preferredWidth: 70

          iconWidth: 40
          iconHeight: 40
          backgroundBorderRadius: 20

          Layout.alignment: Qt.AlignVCenter

          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/headerIcon.svg"
          iconColor: Theme.textPrimary

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: appLogoButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : appLogoButtonId.hovered ? Theme.buttonAccentGlassGradientStart : Theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: appLogoButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : appLogoButtonId.hovered ? Theme.buttonAccentGlassGradientEnd : Theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            rootId.appLogoClicked();
          }
        }

        ColumnLayout {
          spacing: 10

          Text {
            text: "Contacts"
            color: Theme.textPrimary
            font.pixelSize: 20
            font.weight: Font.Bold

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }

          Text {
            text: "Discover contacts"
            color: Theme.textSecondary
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }

        ColumnLayout {
          spacing: 10

          Image {
            id: themeIconId

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
            source: Theme.isDark ? "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/darkThemeIcon.svg" : "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/lightThemeIcon.svg"
          }

          // Theme toggle
          CustomSwitch {
            id: themeSwitchId

            Layout.preferredWidth: 60
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter

            onToggled: function () {
              rootId.themeToggled();
            }
          }
        }
      }

      RowLayout {
        Layout.alignment: Qt.AlignHCenter
        CustomButton {
          id: menuButtonId

          Layout.preferredHeight: 50
          Layout.preferredWidth: 50
          Layout.alignment: Qt.AlignHCenter
          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuIcon.svg"
          iconColor: Theme.textPrimary
          backgroundBorderColor: Theme.glassBorder
          backgroundColor: Theme.background
          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: menuButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : menuButtonId.hovered ? Theme.buttonAccentGlassGradientStart : Theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: menuButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : menuButtonId.hovered ? Theme.buttonAccentGlassGradientEnd : Theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            rootId.drawerMenuOpened();
          }
        }

        CustomButton {
          id: addButtonId

          Layout.alignment: Qt.AlignCenter
          Layout.preferredHeight: 50
          Layout.preferredWidth: 60

          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0

          contentItem: Text {
            text: "Add +"
            font.pixelSize: 14
            color: Theme.textPrimary
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: addButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : addButtonId.hovered ? Theme.buttonAccentGlassGradientStart : Theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: addButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : addButtonId.hovered ? Theme.buttonAccentGlassGradientEnd : Theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }
          onClicked: function () {
            rootId.addContactRequested();
          }
        }
      }
    }
  }
}
