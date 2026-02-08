pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

ItemDelegate {
  id: root
  required property var theme
  property string firstName: "FirstName"
  property string lastName: "LastName"
  property string email: "email@test.com"
  property bool isFavorite: false
  property string avatarColor: "#6366F1"
  property var tags: []

  signal favoriteToggled
  width: parent.width
  height: 100
  background: Item {
    Rectangle {
      id: contactCardBackgroundId
      anchors.fill: parent
      anchors.leftMargin: 10
      anchors.rightMargin: 10
      visible: false
      border.color: root.theme.glassBorder
      border.width: 1
      radius: 10

      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: root.pressed ? root.theme.backgroundGlassCardPressedGradientStart : contactCardBackgroundHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientStart : root.theme.backgroundGlassCardGradientStart

          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: root.pressed ? root.theme.backgroundGlassCardPressedGradientEnd : contactCardBackgroundHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientEnd : root.theme.backgroundGlassCardGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }
    }
    MultiEffect {
      source: contactCardBackgroundId
      anchors.fill: contactCardBackgroundId
      blurEnabled: true
      blur: 0.2
    }
    HoverHandler {
      id: contactCardBackgroundHoverHandler
      cursorShape: Qt.PointingHandCursor
    }
  }

  contentItem: RowLayout {
    id: contactCardContentItemId
    spacing: 10

    // Avatar with initials
    Item {
      Layout.preferredWidth: 50
      Layout.preferredHeight: 50
      Rectangle {
        id: contactCardAvatarId
        anchors.fill: parent
        radius: 25
        border.color: root.theme.glassBorder
        border.width: 1
        visible: false

        gradient: Gradient {
          GradientStop {
            position: 0.0
            color: "transparent"
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
          GradientStop {
            position: 1.0
            color: root.avatarColor
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
        }
      }

      // Siblings order matters
      MultiEffect {
        source: contactCardAvatarId
        anchors.fill: contactCardAvatarId
        blurEnabled: true
        blur: 0.5
      }

      Text {
        anchors.centerIn: parent

        text: (root.firstName ? root.firstName[0].toUpperCase() : "?") + (root.lastName ? root.lastName[0].toUpperCase() : "?")

        font.pixelSize: 20
        font.weight: Font.Bold
        color: root.theme.textPrimary
      }
    }

    // ContactInfo
    ColumnLayout {
      id: contactInfoLayoutId
      Layout.fillWidth: true
      spacing: 5

      Text {
        text: root.firstName + " " + root.lastName
        color: root.theme.textPrimary
        font.pixelSize: 16
        elide: Text.ElideRight
        Layout.fillWidth: true
      }

      Text {
        text: root.email
        font.pixelSize: 14
        color: root.theme.textPrimary
        elide: Text.ElideRight
        Layout.fillWidth: true
      }
    }

    // Favorite button
    CustomButton {
      id: favoriteButtonId
      Layout.preferredHeight: 50
      Layout.preferredWidth: 50
      theme: root.theme
      iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteStarIcon.svg"
      iconColor: root.isFavorite ? root.theme.warningGlass : root.theme.textTertiary
      backgroundBorderColor: root.theme.glassBorder
      backgroundColor: root.theme.background
      backgroundGradient: Gradient {
        GradientStop {
          position: 0.0
          color: favoriteButtonId.pressed ? root.theme.buttonPressedGlassAccentGradientStart : favoriteButtonId.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: favoriteButtonId.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : favoriteButtonId.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }

      onClicked: function () {
        root.favoriteToggled();
      }
    }
  }
}
