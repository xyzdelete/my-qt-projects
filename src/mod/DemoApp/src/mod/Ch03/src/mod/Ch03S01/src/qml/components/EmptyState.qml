pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
  id: rootId

  Rectangle {
    id: emptyStateRectId

    anchors.fill: parent
    radius: 10
    border.color: Theme.glassBorder
    border.width: 1

    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop {
        position: 0.0
        color: emptyStateRectHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientStart : Theme.backgroundGlassCardGradientStart
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: emptyStateRectHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientEnd : Theme.backgroundGlassCardGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
    }

    HoverHandler {
      id: emptyStateRectHoverHandlerId
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      Item {
        Layout.fillHeight: true
      }

      Image {
        id: emptyStateIconId

        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/emptyStateIcon.svg"
        sourceSize: Qt.size(40, 40)
      }

      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "No contacts"
        color: Theme.textSecondary
        font.pixelSize: 20

        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }

      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "Add a contact or check search and filters"
        wrapMode: Text.Wrap
        color: Theme.textTertiary
        font.pixelSize: 14

        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }

      Item {
        Layout.fillHeight: true
      }
    }
  }
}
