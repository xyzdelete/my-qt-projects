pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  property alias text: inputFieldId.text
  property alias placeholderText: inputFieldId.placeholderText
  property alias inputMethodHints: inputFieldId.inputMethodHints
  property alias validator: inputFieldId.validator
  property alias readonly: inputFieldId.readOnly

  property bool hasError: false

  signal inputTextChanged(string text)

  function forceActiveFocus() {
    inputFieldId.forceActiveFocus();
  }

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: inputRectContainerId

      Layout.preferredHeight: parent.height
      Layout.preferredWidth: parent.width

      radius: 15
      color: Theme.backgroundGlass
      border.color: rootId.hasError && inputFieldId.text.length === 0 ? Theme.errorGlassHover : inputFieldId.activeFocus ? Theme.accentGlassHover : Theme.glassBorder
      border.width: inputFieldId.activeFocus ? 2 : 1
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

        TextField {
          id: inputFieldId

          Layout.fillWidth: true
          placeholderText: "Placeholder text..."
          color: Theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true

          background: Item {}
          placeholderTextColor: Theme.textSecondary

          onAccepted: function () {
            inputFieldId.textChanged();
          }

          onTextChanged: function () {
            rootId.inputTextChanged(inputFieldId.text);
          }

          Keys.onEscapePressed: function () {
            inputFieldId.text = "";
            inputFieldId.focus = false;
          }

          onActiveFocusChanged: function () {
            if (inputFieldId.activeFocus) {
              inputFieldId.selectAll();
            }
          }
        }

        // Clear button
        CustomButton {
          id: clearInputFieldTextButtonId

          visible: inputFieldId.text.length > 0
          Layout.preferredWidth: 50
          Layout.preferredHeight: 50

          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/clearTextInputIcon.svg"
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
            inputFieldId.text = "";
            inputFieldId.focus = true;
          }
        }
      }
    }
  }
}
