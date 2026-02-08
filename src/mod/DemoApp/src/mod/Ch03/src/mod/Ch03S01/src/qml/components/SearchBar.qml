pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  required property var theme
  property alias text: searchInput.text
  signal searchTextChanged(string text)
  property url iconSource: ""

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: searchContainer
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
        CustomButton {
          id: searchButton
          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter
          theme: root.theme

          iconSource: root.iconSource

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: searchButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : searchButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: searchButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : searchButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            searchInput.accepted();
          }
        }

        TextField {
          id: searchInput
          Layout.fillWidth: true
          placeholderText: "Search contacts..."
          color: root.theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true

          background: Item {}
          placeholderTextColor: root.theme.textSecondary

          onAccepted: function () {
            searchInput.textChanged();
          }

          onTextChanged: function () {
            root.searchTextChanged(searchInput.text);
          }

          Keys.onEscapePressed: function () {
            searchInput.text = "";
            searchInput.focus = false;
          }

          onFocusChanged: function () {
            if (searchInput.focus) {
              searchInput.selectAll();
            }
          }
        }

        // Clear button
        CustomButton {
          id: clearSearchInputTextButton
          visible: searchInput.text.length > 0
          theme: root.theme
          Layout.preferredWidth: 50
          Layout.preferredHeight: 50

          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/clearTextInputIcon.svg"
          iconColor: root.theme.textPrimary
          backgroundBorderColor: root.theme.glassBorder
          backgroundColor: root.theme.background
          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: clearSearchInputTextButton.pressed ? root.theme.buttonPressedGlassAccentGradientStart : clearSearchInputTextButton.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: clearSearchInputTextButton.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : clearSearchInputTextButton.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            searchInput.text = "";
            searchInput.focus = true;
          }
        }
      }
    }
  }
}
