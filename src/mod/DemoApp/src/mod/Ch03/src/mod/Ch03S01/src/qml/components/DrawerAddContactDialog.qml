pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  required property var theme

  property alias drawer: drawerId

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

      AddContactDialog {
        id: addContactDialogId
        theme: root.theme
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.margins: 10
        Layout.fillHeight: true
      }

      Item {
        Layout.fillHeight: true
      }

      RowLayout {
        Layout.alignment: Qt.AlignHCenter
        CustomButton {
          id: closeButton
          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter
          theme: root.theme
          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuCloseIcon.svg"

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: closeButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : closeButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: closeButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : closeButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
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

        CustomButton {
          id: addButton
          Layout.preferredWidth: 100
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter
          theme: root.theme

          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0

          contentItem: Text {
            text: "Add contact"
            color: root.theme.textPrimary
            font.pointSize: 12
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: addButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : addButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: addButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : addButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
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
}
