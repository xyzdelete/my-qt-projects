pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
  id: rootId

  property alias text: errorTextId.text

  Rectangle {
    id: errorStateRectId

    anchors.centerIn: parent
    width: 300
    height: 200

    border.width: 1
    border.color: Theme.errorGlass
    radius: 10

    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop {
        position: 0.0
        color: errorStateRectHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientStart : Theme.backgroundGlassCardGradientStart
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: errorStateRectHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientEnd : Theme.backgroundGlassCardGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
    }

    ColumnLayout {
      anchors.fill: parent
      spacing: 10
      Item {
        Layout.fillHeight: true
      }
      Image {
        id: emptyStateIconId

        Layout.alignment: Qt.AlignHCenter
        source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/errorStateIcon.svg"
        sourceSize: Qt.size(40, 40)
      }
      Text {
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignHCenter
        text: "Error"
        color: Theme.textSecondary
        font.pixelSize: 16
        font.weight: Font.Medium

        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
      ScrollView {
        id: errorMessageScrollViewId
        Layout.fillWidth: true
        Layout.preferredHeight: errorTextId.font.pixelSize * 3
        contentWidth: availableWidth
        clip: true
        Label {
          id: errorTextId
          width: errorMessageScrollViewId.availableWidth
          horizontalAlignment: Text.AlignHCenter
          text: "Error"
          color: Theme.textTertiary
          font.pixelSize: 14
          wrapMode: Text.Wrap

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }
      Item {
        Layout.fillHeight: true
      }
    }

    HoverHandler {
      id: errorStateRectHoverHandlerId
    }
  }
}
