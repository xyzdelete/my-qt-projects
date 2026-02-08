pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
  id: root
  required property var theme
  property bool isFavorite: false
  property string sortBy: "name"
  property bool sortAscending: true
  property var selectedTags: []

  Rectangle {
    id: addContactDialog
    border.color: root.theme.glassBorder
    border.width: 1
    radius: 10
    anchors.fill: parent
    visible: false
    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop {
        position: 0.0
        color: addContactDialogHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientStart : root.theme.backgroundGlassCardGradientStart
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: addContactDialogHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientEnd : root.theme.backgroundGlassCardGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
    }
  }
  MultiEffect {
    source: addContactDialog
    anchors.fill: addContactDialog
    blurEnabled: true
    blur: 0.2
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    Text {
      Layout.alignment: Qt.AlignHCenter
      text: "Add New Contact"
      font.pixelSize: 20
      font.weight: Font.Bold
      color: root.theme.textPrimary
    }

    Text {
      Layout.alignment: Qt.AlignHCenter
      text: "Fill in the details below"
      font.pixelSize: 12
      font.weight: Font.Bold
      color: root.theme.textSecondary
    }

    // Divider
    Divider {
      theme: root.theme
      Layout.fillWidth: true
    }

    ScrollView {
      id: scrollView
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      contentWidth: availableWidth
      ColumnLayout {
        width: scrollView.availableWidth - 10

        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          Item {
            Layout.fillWidth: true
          }
          CustomButton {
            theme: root.theme

            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/personalInfoIcon.svg"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }
          Text {
            text: "Personal Information"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "First Name"
            inputMethodHints: Qt.ImhLatinOnly
            validator: RegularExpressionValidator {
              regularExpression: /[^ ][A-za-z]{0, 32}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "Last Name"
            inputMethodHints: Qt.ImhLatinOnly
            validator: RegularExpressionValidator {
              regularExpression: /[^ ][A-za-z]{0, 32}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "Email"
            inputMethodHints: Qt.ImhEmailCharactersOnly
            validator: RegularExpressionValidator {
              regularExpression: /[^ ][A-za-z0-9._@]{0, 64}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "Phone number (+...)"
            inputMethodHints: Qt.ImhDialableCharactersOnly
            validator: RegularExpressionValidator {
              regularExpression: /\+{1}[0-9]{7,15}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }

        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          CustomButton {
            theme: root.theme
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/workInfoIcon.svg"
            iconColor: "transparent"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          Text {
            text: "Work Information"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "Company name"
            inputMethodHints: Qt.ImhLatinOnly
            validator: RegularExpressionValidator {
              regularExpression: /[^ ][A-za-z. ]{0, 32}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "Job title"
            inputMethodHints: Qt.ImhLatinOnly
            validator: RegularExpressionValidator {
              regularExpression: /[^ ][A-z a-z]{0, 32}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }

        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          CustomButton {
            theme: root.theme
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/addressInfoIcon.svg"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          Text {
            text: "Address Information"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }
          Item {
            Layout.fillWidth: true
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          InputField {
            Layout.preferredHeight: 50
            Layout.preferredWidth: 250
            theme: root.theme
            placeholderText: "Address"
            inputMethodHints: Qt.ImhLatinOnly
            validator: RegularExpressionValidator {
              regularExpression: /[^ ][A-z a-z]{0, 128}/
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }

        RowLayout {
          spacing: 10
          Layout.fillWidth: true
          Item {
            Layout.fillWidth: true
          }
          CustomButton {
            theme: root.theme

            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteContactIcon.svg"
            iconColor: "transparent"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          Text {
            text: "Favorite contact"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }

          CustomSwitch {
            id: favoritesSwitch
            Layout.preferredWidth: 60
            Layout.preferredHeight: 30
            theme: root.theme
            onToggled: function () {
              root.isFavorite = !root.isFavorite;
              ApplicationWindow.window.title = "Favorite toggled: " + root.isFavorite;
            }
            gradient: Gradient {
              GradientStop {
                position: 0.0
                color: favoritesSwitch.checked ? (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientStart : favoritesSwitch.switchHoverHandler.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart) : (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientStart : favoritesSwitch.switchHoverHandler.hovered ? root.theme.accentGlassGradientStart : root.theme.backgroundGlassGradientStart)
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1.0
                color: favoritesSwitch.checked ? (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : favoritesSwitch.switchHoverHandler.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd) : (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : favoritesSwitch.switchHoverHandler.hovered ? root.theme.accentGlassGradientEnd : root.theme.backgroundGlassGradientEnd)
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }
          Item {
            Layout.fillWidth: true
          }
        }
      }

      ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOn
        height: scrollView.availableHeight
        x: scrollView.width - width
        background: Rectangle {
          color: root.theme.backgroundGlass
          implicitWidth: 6
          radius: 3
          border.width: 1
          border.color: root.theme.glassBorder
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }

        contentItem: Rectangle {
          color: root.theme.accentGlassHover
          implicitWidth: 4
          radius: 2
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }
    }

    // Divider
    Divider {
      theme: root.theme
    }

    // Divider
    Divider {
      theme: root.theme
      Layout.fillWidth: true
    }

    RowLayout {
      spacing: 10
      Layout.fillWidth: true
      Item {
        Layout.fillWidth: true
      }
      Text {
        text: "* First Name and Last Name required"
        font.pixelSize: 10
        color: root.theme.textSecondary
      }
      Item {
        Layout.fillWidth: true
      }
    }

    Item {
      Layout.fillHeight: true
    }
  }

  HoverHandler {
    id: addContactDialogHoverHandler
  }
}
