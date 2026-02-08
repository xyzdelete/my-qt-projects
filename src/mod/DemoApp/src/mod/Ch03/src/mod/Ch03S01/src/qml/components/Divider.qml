pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Effects

Item {
  id: rootId

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
            duration: Theme.animationDuration
          }
        }
      }

      GradientStop {
        position: 0.5
        color: Theme.accentGlassGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }

      GradientStop {
        position: 1.0
        color: "transparent"
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
    }
    Behavior on color {
      ColorAnimation {
        duration: Theme.animationDuration
      }
    }
  }
}
