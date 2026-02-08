pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  property url iconSource: ""

  property alias searchButtonEnabled: searchButtonId.enabled
  property alias searchInputEnabled: searchInputId.enabled
  property alias text: searchInputId.text

  signal searchRequested(string query)
  signal searchButtonClicked

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: searchContainerId

      Layout.preferredHeight: parent.height
      Layout.preferredWidth: parent.width

      radius: 15
      color: Theme.backgroundGlass

      border.width: searchInputId.text ? 2 : 1
      border.color: searchInputId.text ? Theme.accentGlassHover : Theme.glassBorder

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
          id: searchButtonId

          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          iconSource: rootId.iconSource

          onClicked: function () {
            searchInputId.accepted();
            rootId.searchButtonClicked();
          }
        }

        TextField {
          id: searchInputId

          Layout.fillWidth: true
          placeholderText: "Search repositories or @username"
          color: Theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true

          background: Rectangle {
            color: "transparent"
          }
          placeholderTextColor: Theme.textSecondary

          onAccepted: function () {
            if (searchInputId.text.trim().length > 0) {
              rootId.searchRequested(searchInputId.text.trim());
            }
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

        // Type indicator
        Rectangle {
          visible: searchInputId.text.length > 0
          Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
          Layout.preferredWidth: typeIndicatorId.implicitWidth + 10
          Layout.preferredHeight: typeIndicatorId.implicitHeight + 10
          radius: 10
          Text {
            id: typeIndicatorId

            anchors.centerIn: parent
            text: searchInputId.text.startsWith("@") ? "USER" : "REPO"
            font.pixelSize: 12
            font.weight: Font.Bold
            color: Theme.textPrimary
          }

          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }
        }
      }
    }
  }
}
