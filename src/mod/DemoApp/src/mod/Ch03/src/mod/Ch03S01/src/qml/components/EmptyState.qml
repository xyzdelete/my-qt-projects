pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  required property var theme

  Rectangle {
    id: emptyStateRectId
    anchors.fill: parent
    radius: 10
    border.color: root.theme.glassBorder
    border.width: 1

    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop {
        position: 0.0
        color: emptyStateRectHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientStart : root.theme.backgroundGlassCardGradientStart
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: emptyStateRectHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientEnd : root.theme.backgroundGlassCardGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
    }

    HoverHandler {
      id: emptyStateRectHoverHandler
      cursorShape: Qt.PointingHandCursor
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10

      Item {
        Layout.fillHeight: true
      }

      Image {
        id: emptyStateIcon
        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/emptyStateIcon.svg"
        sourceSize: Qt.size(40, 40)
      }

      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "No contacts"
        color: root.theme.textSecondary
        font.pixelSize: 20

        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }

      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "Add your first contact to get started"
        color: root.theme.textTertiary
        font.pixelSize: 14

        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }

      Item {
        Layout.fillHeight: true
      }
    }
  }
}
