pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  required property var theme
  property alias text: inputField.text
  property alias placeholderText: inputField.placeholderText
  signal inputTextChanged(string text)

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: inputRectContainer
      Layout.preferredHeight: parent.height
      Layout.preferredWidth: parent.width

      radius: 15
      color: root.theme.backgroundGlass
      border.color: root.theme.glassBorder
      border.width: 1

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10

        TextField {
          id: inputField
          Layout.fillWidth: true
          placeholderText: "Placeholder text..."
          color: root.theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true

          background: Item {}
          placeholderTextColor: root.theme.textSecondary

          onAccepted: function () {
            inputField.textChanged();
          }

          onTextChanged: function () {
            root.inputTextChanged(inputField.text);
          }

          Keys.onEscapePressed: function () {
            inputField.text = "";
            inputField.focus = false;
          }

          onFocusChanged: function () {
            if (inputField.focus) {
              inputField.selectAll();
            }
          }
        }

        // Clear button
        CustomButton {
          id: clearinputFieldTextButton
          visible: inputField.text.length > 0
          theme: root.theme
          Layout.preferredWidth: 50
          Layout.preferredHeight: 50

          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/clearTextInputIcon.svg"
          iconColor: root.theme.textPrimary
          backgroundBorderColor: root.theme.glassBorder
          backgroundColor: root.theme.background
          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0
          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: clearinputFieldTextButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : clearinputFieldTextButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: clearinputFieldTextButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : clearinputFieldTextButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            inputField.text = "";
            inputField.focus = true;
          }
        }
      }
    }
  }
}
