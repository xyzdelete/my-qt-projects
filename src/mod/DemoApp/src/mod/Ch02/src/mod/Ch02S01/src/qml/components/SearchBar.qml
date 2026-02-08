pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  property url iconSource: ""

  signal searchRequested(string query)
  signal userSearchRequested(string username)
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
      border.color: Theme.glassBorder
      border.width: 1

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
            searchInput.accepted();
            rootId.searchButtonClicked();
          }
        }

        TextField {
          id: searchInput

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
            if (searchInput.text.trim().length > 0) {
              if (searchInput.text.startsWith("@")) {
                rootId.userSearchRequested(searchInput.text.substring(1));
              } else {
                rootId.searchRequested(searchInput.text.trim());
              }
            }
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

        // Type indicator
        Rectangle {
          visible: searchInput.text.length > 0
          Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
          Layout.preferredWidth: typeIndicatorId.implicitWidth + 10
          Layout.preferredHeight: typeIndicatorId.implicitHeight + 10
          radius: 10
          Text {
            id: typeIndicatorId

            anchors.centerIn: parent
            text: searchInput.text.startsWith("@") ? "USER" : "REPO"
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
