pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  required property var theme
  required property string currentView
  required property bool isVisible

  Rectangle {
    id: emptyStateRectId
    anchors.centerIn: parent
    width: 300
    height: 200
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
    radius: 10
    visible: root.isVisible

    ColumnLayout {
      anchors.centerIn: parent
      spacing: 16

      Image {
        id: emptyStateIcon
        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/emptyStateIcon.svg"
        sourceSize: Qt.size(40, 40)
      }

      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: {
          switch (root.currentView) {
          case "search":
            return "No search results found";
          case "user":
            return "No user repositories found";
          default:
            return "No repositories loaded";
          }
        }
        color: root.theme.textSecondary
        font.pixelSize: 16
        font.weight: Font.Medium

        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }

      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "Check token or search"
        color: root.theme.textTertiary
        font.pixelSize: 14

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
  }
}
