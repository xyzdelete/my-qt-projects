pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material

Item {
  id: rootId

  property alias gradient: toggleKnobId.gradient
  property alias checked: switchId.checked
  property alias pressed: switchId.pressed
  readonly property bool hovered: switchHoverHandlerId.hovered

  signal toggled

  width: 60
  height: 30

  Switch {
    id: switchId

    anchors.fill: parent
    hoverEnabled: true

    HoverHandler {
      id: switchHoverHandlerId
      cursorShape: Qt.PointingHandCursor
    }

    background: Rectangle {
      id: switchBackgroundId
      radius: 10
      color: Theme.backgroundGlass
      border.color: Theme.glassBorder
      border.width: 1
    }
    indicator: Rectangle {
      id: toggleKnobId

      width: 20
      height: 20
      radius: 10
      anchors.verticalCenter: switchBackgroundId.verticalCenter
      x: switchId.checked ? switchBackgroundId.width - toggleKnobId.width - 5 : 5
      border.color: Theme.glassBorder
      border.width: 1

      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: switchId.pressed ? Theme.buttonPressedGlassAccentGradientStart : rootId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: switchId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : rootId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }
      Behavior on x {
        NumberAnimation {
          duration: Theme.animationDuration
        }
      }
    }

    onToggled: function () {
      rootId.toggled();
    }
  }
}
