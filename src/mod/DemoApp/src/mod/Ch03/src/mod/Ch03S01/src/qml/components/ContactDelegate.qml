pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Effects

SwipeDelegate {
  id: rootId

  required property int index
  required property string initials
  required property string firstName
  required property string lastName
  required property string email
  required property string phone
  required property string company
  required property string jobTitle
  required property string address
  required property string notes
  required property list<string> tags
  required property color avatarColor
  required property bool isFavorite

  signal favoriteToggled
  signal editRequested
  signal viewContactRequested
  signal deleteRequested

  hoverEnabled: true

  HoverHandler {
    id: contactHoverHandlerId
    cursorShape: Qt.PointingHandCursor
  }

  swipe.transition: Transition {
    NumberAnimation {
      duration: Theme.animationDuration
    }
  }

  // Swipes from right to left
  swipe.right: Rectangle {
    id: swipeRightRectId

    visible: rootId.swipe.position < 0
    height: parent ? parent.height : 0
    width: 70
    anchors.right: parent ? parent.right : undefined
    radius: 10
    border.color: deleteButtonId.hovered ? Theme.errorGlassHover : Theme.glassBorder
    border.width: deleteButtonId.hovered ? 2 : 1
    color: Theme.backgroundGlass

    ColumnLayout {
      anchors.fill: parent
      spacing: 0
      CustomButton {
        id: deleteButtonId

        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        enabled: rootId.swipe.complete
        opacity: enabled ? 1.0 : 0.5

        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationDuration
          }
        }

        backgroundBorderColor: Theme.errorGlassHover

        iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/deleteContactIcon.svg"

        onClicked: function () {
          rootId.swipe.close();
          rootId.deleteRequested();
        }
      }
      CustomButton {
        id: closeSwipeRighButtonId

        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        enabled: rootId.swipe.complete
        opacity: enabled ? 1.0 : 0.5

        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationDuration
          }
        }

        iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuCloseIcon.svg"

        onClicked: function () {
          rootId.swipe.close();
        }
      }
    }
  }
  // Swipes from left to right
  swipe.left: Rectangle {
    id: swipeLeftRectId

    visible: rootId.swipe.position > 0
    height: parent ? parent.height : 0
    width: 70
    anchors.left: parent ? parent.left : undefined
    radius: 10
    border.color: editContactButtonId.hovered ? Theme.accentGlassHover : Theme.glassBorder
    border.width: editContactButtonId.hovered ? 2 : 1
    color: Theme.backgroundGlass

    ColumnLayout {
      anchors.fill: parent
      spacing: 0

      CustomButton {
        id: editContactButtonId

        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        enabled: rootId.swipe.complete
        opacity: enabled ? 1.0 : 0.5

        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationDuration
          }
        }

        iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/headerIcon.svg"

        onClicked: function () {
          rootId.swipe.close();
          rootId.editRequested();
        }
      }
      CustomButton {
        id: closeSwipeLeftButtonId

        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter

        enabled: rootId.swipe.complete
        opacity: enabled ? 1.0 : 0.5

        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationDuration
          }
        }

        iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuCloseIcon.svg"

        onClicked: function () {
          rootId.swipe.close();
        }
      }
    }
  }

  width: parent ? parent.width : 0
  height: 100
  background: Item {
    Rectangle {
      id: contactCardBackgroundId

      anchors.fill: parent
      anchors.leftMargin: 10
      anchors.rightMargin: 10
      visible: false
      border.color: Theme.glassBorder
      border.width: 1
      radius: 10

      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: rootId.pressed ? Theme.backgroundGlassCardPressedGradientStart : contactHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientStart : Theme.backgroundGlassCardGradientStart

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: rootId.pressed ? Theme.backgroundGlassCardPressedGradientEnd : contactHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientEnd : Theme.backgroundGlassCardGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
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
        border.color: Theme.glassBorder
        border.width: 1
        visible: false

        gradient: Gradient {
          GradientStop {
            position: 0.0
            color: Theme.isDark ? rootId.avatarColor : "transparent"
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
          GradientStop {
            position: 1.0
            color: Theme.isDark ? "transparent" : rootId.avatarColor
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
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

        text: rootId.initials

        font.pixelSize: 20
        font.weight: Font.Bold
        color: Theme.textPrimary
      }
    }

    // ContactInfo
    ColumnLayout {
      id: contactInfoLayoutId

      Layout.fillWidth: true
      spacing: 5

      Text {
        text: rootId.firstName + " " + rootId.lastName
        color: Theme.textPrimary
        font.pixelSize: 16
        elide: Text.ElideRight
        Layout.fillWidth: true
      }

      Text {
        text: rootId.email
        font.pixelSize: 14
        color: Theme.textPrimary
        elide: Text.ElideRight
        Layout.fillWidth: true
      }
    }

    // Favorite button
    CustomButton {
      id: favoriteButtonId

      Layout.preferredHeight: 50
      Layout.preferredWidth: 50
      iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteStarIcon.svg"
      iconColor: rootId.isFavorite ? Theme.warningGlass : Theme.textTertiary
      backgroundBorderColor: Theme.glassBorder
      backgroundColor: Theme.background
      backgroundGradient: Gradient {
        GradientStop {
          position: 0.0
          color: favoriteButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : favoriteButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: favoriteButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : favoriteButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }

      onClicked: function () {
        rootId.favoriteToggled();
      }
    }
  }

  onClicked: function () {
    rootId.viewContactRequested();
  }
}
