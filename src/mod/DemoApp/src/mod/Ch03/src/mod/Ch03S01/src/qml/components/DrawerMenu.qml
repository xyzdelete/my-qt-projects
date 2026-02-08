pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  required property var theme

  property alias drawer: drawerId

  signal favoritesToggled(bool enabled)
  signal sortChanged(string sortBy, bool ascneding)
  signal tagToggled(string tag)
  property alias selectedTags: filterPanel.selectedTags

  property alias edge: drawerId.edge
  property alias interactive: drawerId.interactive

  Drawer {
    id: drawerId
    width: parent.width
    height: parent.height
    dragMargin: 50

    background: Rectangle {
      color: root.theme.backgroundGlass
    }

    contentItem: ColumnLayout {
      spacing: 10

      FilterPanel {
        id: filterPanel
        theme: root.theme
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.preferredHeight: 520

        onFavoritesToggled: function (enabled) {
          root.favoritesToggled(enabled);
        }

        onSortChanged: function (sortBy, ascending) {
          root.sortChanged(sortBy, ascending);
        }

        onTagToggled: function (tag) {
          root.tagToggled(tag);
        }
      }

      Item {
        Layout.fillHeight: true
      }

      CustomButton {
        id: menuCloseButton
        Layout.preferredWidth: 60
        Layout.preferredHeight: 50
        Layout.alignment: Qt.AlignHCenter
        theme: root.theme
        iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuCloseIcon.svg"

        backgroundGradient: Gradient {
          GradientStop {
            position: 0.0
            color: menuCloseButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : menuCloseButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
          GradientStop {
            position: 1.0
            color: menuCloseButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : menuCloseButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
        }

        onClicked: function () {
          drawerId.close();
        }
      }
    }
  }
}
