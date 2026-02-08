pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  property url iconSource: ""

  readonly property alias placeholderText: tokenFieldId.placeholderText

  signal tokenChanged(string token)
  signal tokenInputButtonClicked

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: tokenInputContainerId

      Layout.preferredHeight: parent.height
      Layout.preferredWidth: parent.width

      radius: 15
      color: Theme.backgroundGlass
      border.width: tokenFieldId.text ? 2 : 1
      border.color: tokenFieldId.text ? Theme.accentGlassHover : Theme.glassBorder

      Behavior on border.width {
        NumberAnimation {
          duration: Theme.animationDuration
        }
      }
      Behavior on border.color {
        ColorAnimation {
          duration: Theme.animationDuration
        }
      }

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10
        CustomButton {
          id: tokenInputButtonId

          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          hoveredCursorShape: Qt.ArrowCursor

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: tokenFieldId.text ? Theme.buttonPressedGlassAccentGradientStart : Theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: tokenFieldId.text ? Theme.buttonPressedGlassAccentGradientEnd : Theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          iconSource: rootId.iconSource
        }

        TextField {
          id: tokenFieldId

          Layout.fillWidth: true
          placeholderText: "Enter GitHub Token..."
          color: Theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true
          echoMode: TextInput.Password

          background: Rectangle {
            color: "transparent"
          }
          placeholderTextColor: Theme.textSecondary

          Keys.onEscapePressed: function () {
            tokenFieldId.text = "";
            tokenFieldId.focus = false;
          }

          onTextChanged: function () {
            rootId.tokenChanged(tokenFieldId.text);
          }
        }

        // Clear button
        CustomButton {
          id: clearInputFieldTextButtonId

          visible: tokenFieldId.text.length > 0
          Layout.preferredWidth: 50
          Layout.preferredHeight: 50

          iconSource: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/clearTextInputIcon.svg"
          iconColor: Theme.textPrimary
          backgroundBorderColor: Theme.glassBorder
          backgroundColor: Theme.background
          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0
          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: clearInputFieldTextButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : clearInputFieldTextButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: clearInputFieldTextButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : clearInputFieldTextButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            tokenFieldId.text = "";
            tokenFieldId.focus = true;
          }
        }
      }
    }
  }
}
