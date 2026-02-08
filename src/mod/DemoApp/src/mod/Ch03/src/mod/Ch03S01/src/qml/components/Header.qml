pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
  id: root
  required property var theme
  signal drawerMenuOpened
  signal appLogoClicked
  signal themeToggled
  signal addContactRequested

  Rectangle {
    id: header
    anchors.fill: parent
    border.color: root.theme.glassBorder
    border.width: 1
    gradient: Gradient {
      GradientStop {
        position: 0.0
        color: root.theme.backgroundGlassHeaderGradientStart
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: root.theme.backgroundGlassHeaderGradientEnd
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
    Behavior on border.color {
      ColorAnimation {
        duration: root.theme.animationDuration
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
          id: appLogoButton
          theme: root.theme
          Layout.preferredHeight: 70
          Layout.preferredWidth: 70

          iconWidth: 40
          iconHeight: 40
          backgroundBorderRadius: 20

          Layout.alignment: Qt.AlignVCenter

          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/headerIcon.svg"
          iconColor: root.theme.textPrimary

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: appLogoButton.pressed ? root.theme.backgroundGlassGradientStart : appLogoButton.hovered ? root.theme.buttonPressedGlassAccentGradientStart : root.theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: appLogoButton.pressed ? root.theme.backgroundGlassGradientEnd : appLogoButton.hovered ? root.theme.buttonPressedGlassAccentGradientEnd : root.theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            root.appLogoClicked();
          }
        }

        ColumnLayout {
          spacing: 10

          Text {
            text: "Contacts"
            color: root.theme.textPrimary
            font.pixelSize: 20
            font.weight: Font.Bold

            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }

          Text {
            text: "Discover contacts"
            color: root.theme.textSecondary
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
        }

        ColumnLayout {
          spacing: 10

          Image {
            id: themeIcon
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
            source: root.theme.isDark ? "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/darkThemeIcon.svg" : "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/lightThemeIcon.svg"
          }

          // Theme toggle
          CustomSwitch {
            id: themeSwitch
            theme: root.theme
            Layout.preferredWidth: 60
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter

            onToggled: function () {
              root.themeToggled();
            }
          }
        }
      }

      RowLayout {
        Layout.alignment: Qt.AlignHCenter
        CustomButton {
          id: menuButtonId
          theme: root.theme
          Layout.preferredHeight: 50
          Layout.preferredWidth: 50
          Layout.alignment: Qt.AlignHCenter
          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuIcon.svg"
          iconColor: root.theme.textPrimary
          backgroundBorderColor: root.theme.glassBorder
          backgroundColor: root.theme.background
          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: menuButtonId.pressed ? root.theme.backgroundGlassGradientStart : menuButtonId.hovered ? root.theme.buttonPressedGlassAccentGradientStart : root.theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: menuButtonId.pressed ? root.theme.backgroundGlassGradientEnd : menuButtonId.hovered ? root.theme.buttonPressedGlassAccentGradientEnd : root.theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            root.drawerMenuOpened();
          }
        }

        CustomButton {
          id: addButtonId
          Layout.alignment: Qt.AlignCenter
          Layout.preferredHeight: 50
          Layout.preferredWidth: 60
          theme: root.theme
          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0
          contentItem: Text {
            text: "Add +"
            font.pixelSize: 14
            color: root.theme.textPrimary
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: addButtonId.pressed ? root.theme.backgroundGlassGradientStart : addButtonId.hovered ? root.theme.buttonPressedGlassAccentGradientStart : root.theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: addButtonId.pressed ? root.theme.backgroundGlassGradientEnd : addButtonId.hovered ? root.theme.buttonPressedGlassAccentGradientEnd : root.theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }
          onClicked: function () {
            root.addContactRequested();
          }
        }
      }
    }
  }
}
