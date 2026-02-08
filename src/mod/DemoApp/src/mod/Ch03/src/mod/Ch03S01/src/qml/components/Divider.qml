pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

Item {
  id: root
  required property var theme

  height: 3

  Rectangle {
    anchors.fill: parent
    radius: 1.5
    gradient: Gradient {
      orientation: Gradient.Horizontal
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
        position: 0.5
        color: root.theme.accentGlassGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }

      GradientStop {
        position: 1.0
        color: "transparent"
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
  }
}
