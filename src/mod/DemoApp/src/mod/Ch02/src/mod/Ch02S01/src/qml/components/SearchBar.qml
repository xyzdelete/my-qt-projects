pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  required property var theme

  signal searchRequested(string query)
  signal userSearchRequested(string username)
  property url iconSource: ""
  signal searchButtonClicked

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

          onClicked: function () {
            searchInput.accepted();
            root.searchButtonClicked();
          }
        }

        TextField {
          id: searchInput
          Layout.fillWidth: true
          placeholderText: "Search repositories or @username"
          color: root.theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true

          background: Rectangle {
            color: "transparent"
          }
          placeholderTextColor: root.theme.textSecondary

          onAccepted: function () {
            if (searchInput.text.trim().length > 0) {
              if (searchInput.text.startsWith("@")) {
                root.userSearchRequested(searchInput.text.substring(1));
              } else {
                root.searchRequested(searchInput.text.trim());
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
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          width: typeIndicator.implicitWidth + 10
          height: typeIndicator.implicitHeight + 10
          radius: 10
          Text {
            id: typeIndicator
            anchors.centerIn: parent
            text: searchInput.text.startsWith("@") ? "USER" : "REPO"
            font.pixelSize: 12
            font.weight: Font.Bold
            color: root.theme.textPrimary
          }

          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: root.theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: root.theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
          }
        }
      }
    }
  }
}
