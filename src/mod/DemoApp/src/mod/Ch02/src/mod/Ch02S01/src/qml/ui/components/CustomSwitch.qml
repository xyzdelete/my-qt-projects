pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
      color: root.theme.glassBackground
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
      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: rootSwitchMouseArea.pressed ? root.theme.accent : rootSwitchHoverHandler.hovered ? root.theme.accentHover : root.theme.accent
          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }
        }
        GradientStop {
          position: 1.0
          color: rootSwitchMouseArea.pressed ? root.theme.accentHover : rootSwitchHoverHandler.hovered ? root.theme.accent : root.theme.accentHover
          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }
        }
      }
      Behavior on x {
        NumberAnimation {
          duration: root.theme.normalAnimation
        }
      }
    }

    MouseArea {
      id: rootSwitchMouseArea
      anchors.fill: parent
      onClicked: function () {
        parent.toggled();
      }
      HoverHandler {
        id: rootSwitchHoverHandler
        cursorShape: Qt.PointingHandCursor
      }
    }

    onToggled: function () {
      root.toggled();
    }
  }
}
