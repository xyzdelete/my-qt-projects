pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Item {
  id: root
  required property var theme
  property url iconSource: ""
  signal clicked
  property alias contentItem: rootButton.contentItem
  property alias iconColor: rootButton.icon.color
  property alias iconWidth: rootButton.icon.width
  property alias iconHeight: rootButton.icon.height
  property alias display: rootButton.display
  property alias backgroundBorderColor: backgroundId.border.color
  property alias backgroundBorderRadius: backgroundId.radius
  property alias backgroundColor: backgroundId.color
  property alias backgroundGradient: backgroundId.gradient
  property alias text: rootButton.text
  property alias leftPadding: rootButton.leftPadding
  property alias rightPadding: rootButton.rightPadding
  property alias topPadding: rootButton.topPadding
  property alias bottomPadding: rootButton.bottomPadding
  property alias checked: rootButton.checked
  property alias checkable: rootButton.checkable

  property alias buttonHoverHandler: rootButtonHoverHandler
  readonly property bool hovered: rootButtonHoverHandler.hovered
  readonly property bool pressed: rootButton.pressed

  width: 60
  height: 30

  Button {
    id: rootButton
    anchors.fill: parent
    icon.source: root.iconSource
    icon.color: root.theme.textPrimary

    background: Rectangle {
      id: backgroundId
      radius: 10
      border.color: root.theme.glassBorder
      border.width: 1
      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: rootButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : rootButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: rootButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : rootButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }
    }

    HoverHandler {
      id: rootButtonHoverHandler
      cursorShape: Qt.PointingHandCursor
    }

    onClicked: function () {
      root.clicked();
    }
  }
}
