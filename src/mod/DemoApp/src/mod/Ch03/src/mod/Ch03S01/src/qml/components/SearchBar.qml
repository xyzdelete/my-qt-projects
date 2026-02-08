pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  required property ContactManager contactManager
  readonly property ContactFilterProxyModel proxyModel: contactManager.proxyModel

  property alias text: searchInputId.text

  property url iconSource: ""

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: searchContainerId

      Layout.preferredHeight: parent.height
      Layout.preferredWidth: parent.width

      radius: 15
      color: Theme.backgroundGlass
      border.color: Theme.glassBorder
      border.width: 1

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
          id: searchButtonId

          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          iconSource: rootId.iconSource

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: searchButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : searchButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: searchButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : searchButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            searchInputId.accepted();
          }
        }

        TextField {
          id: searchInputId

          Layout.fillWidth: true
          placeholderText: "Search contacts..."
          color: Theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true

          background: Item {}
          placeholderTextColor: Theme.textSecondary

          onAccepted: function () {
            searchInputId.textChanged();
          }

          onTextChanged: function () {
            rootId.proxyModel.searchText = searchInputId.text;
          }

          Keys.onEscapePressed: function () {
            searchInputId.text = "";
            searchInputId.focus = false;
          }

          onFocusChanged: function () {
            if (searchInputId.focus) {
              searchInputId.selectAll();
            }
          }
        }

        // Clear button
        CustomButton {
          id: clearSearchInputTextButtonId

          visible: searchInputId.text.length > 0
          Layout.preferredWidth: 50
          Layout.preferredHeight: 50

          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/clearTextInputIcon.svg"
          iconColor: Theme.textPrimary
          backgroundBorderColor: Theme.glassBorder
          backgroundColor: Theme.background
          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: clearSearchInputTextButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : clearSearchInputTextButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: clearSearchInputTextButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : clearSearchInputTextButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            searchInputId.text = "";
            searchInputId.focus = true;
          }
        }
      }
    }
  }
}
