pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material

Item {
  id: rootId

  property alias contentItem: buttonId.contentItem
  property alias iconColor: buttonId.icon.color
  property alias iconWidth: buttonId.icon.width
  property alias iconHeight: buttonId.icon.height
  property alias display: buttonId.display
  property alias backgroundBorderColor: backgroundId.border.color
  property alias backgroundBorderRadius: backgroundId.radius
  property alias backgroundColor: backgroundId.color
  property alias backgroundGradient: backgroundId.gradient
  property alias text: buttonId.text
  property alias topPadding: buttonId.topPadding
  property alias bottomPadding: buttonId.bottomPadding
  property alias leftPadding: buttonId.leftPadding
  property alias rightPadding: buttonId.rightPadding
  property alias checked: buttonId.checked
  property alias checkable: buttonId.checkable
  property alias hoveredCursorShape: buttonHoverHandlerId.cursorShape

  property url iconSource: ""

  readonly property bool hovered: buttonHoverHandlerId.hovered
  readonly property bool pressed: buttonId.pressed

  signal clicked

  width: 60
  height: 30

  Button {
    id: buttonId

    anchors.fill: parent
    hoverEnabled: true
    icon.source: rootId.iconSource
    icon.color: Theme.textPrimary

    HoverHandler {
      id: buttonHoverHandlerId
      cursorShape: Qt.PointingHandCursor
    }

    background: Rectangle {
      id: backgroundId

      radius: 10
      border.color: Theme.glassBorder
      border.width: 1
      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: buttonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : rootId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: buttonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : rootId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }
    }

    onClicked: function () {
      rootId.clicked();
    }
  }
}
