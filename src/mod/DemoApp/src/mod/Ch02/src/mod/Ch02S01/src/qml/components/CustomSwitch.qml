pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Item {
  id: root
  required property var theme
  signal toggled

  Switch {
    id: rootSwitch
    anchors.fill: parent
    checked: root.theme.isDark
    background: Rectangle {
      id: rootSwitchBackground
      anchors.fill: parent
      radius: 10
      color: root.theme.backgroundGlass
      border.color: root.theme.glassBorder
      border.width: 1
    }
    indicator: Rectangle {
      id: toggleKnob
      width: 20
      height: 20
      radius: 10
      anchors.verticalCenter: rootSwitchBackground.verticalCenter
      x: root.theme.isDark ? rootSwitchBackground.width - toggleKnob.width - 5 : 5
      border.color: root.theme.glassBorder
      border.width: 1

      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: rootSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientStart : rootSwitchHoverHandler.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: rootSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : rootSwitchHoverHandler.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }
      Behavior on x {
        NumberAnimation {
          duration: root.theme.animationDuration
        }
      }
    }

    HoverHandler {
      id: rootSwitchHoverHandler
      cursorShape: Qt.PointingHandCursor
    }

    onToggled: function () {
      root.toggled();
    }
  }
}
