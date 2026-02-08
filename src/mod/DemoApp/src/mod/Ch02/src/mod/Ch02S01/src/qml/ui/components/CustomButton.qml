pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  required property var theme
  property url iconSource: ""
  signal clicked
  property alias contentItem: rootButton.contentItem

  Button {
    id: rootButton
    anchors.fill: parent
    icon.source: root.iconSource
    icon.color: root.theme.textPrimary
    background: Rectangle {
      radius: 10
      border.color: root.theme.glassBorder
      border.width: 1
      gradient: Gradient {
        GradientStop {
          position: 0.0
          color: rootButton.pressed ? root.theme.accent : rootButtonHoverHandler.hovered ? root.theme.accentHover : root.theme.accent
          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
            }
          }
        }
        GradientStop {
          position: 1.0
          color: rootButton.pressed ? root.theme.accentHover : rootButtonHoverHandler.hovered ? root.theme.accent : root.theme.accentHover
          Behavior on color {
            ColorAnimation {
              duration: root.theme.normalAnimation
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
