pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  required property var theme
  property string lastQueary: ""
  property string lastUser: ""
  signal searchRequested(string query)
  signal userSearchRequested(string username)
  property url iconSource: ""

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: searchContainer
      Layout.preferredHeight: parent.height
      Layout.preferredWidth: parent.width

      radius: 15
      color: root.theme.glassBackground
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
            drawer.close();
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

          // Type indicator
          Rectangle {
            visible: searchInput.text.length > 0
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: typeIndicator.implicitWidth + 10
            height: 14
            radius: 7
            Text {
              id: typeIndicator
              anchors.centerIn: parent
              text: searchInput.text.startsWith("@") ? "USER" : "REPO"
              font.pixelSize: 8
              font.weight: Font.Bold
              color: root.theme.textPrimary
            }

            gradient: Gradient {
              GradientStop {
                position: 0.0
                color: searchInput.text.startsWith("@") ? root.theme.accent : root.theme.accentHover
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.normalAnimation
                  }
                }
              }
              GradientStop {
                position: 1.0
                color: searchInput.text.startsWith("@") ? root.theme.accentHover : root.theme.accent
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.normalAnimation
                  }
                }
              }
            }
          }

          onAccepted: function () {
            if (text.trim().length > 0) {
              if (text.startsWith("@")) {
                root.lastUser = text.substring(1);
                root.userSearchRequested(text.substring(1));
              } else {
                root.lastQueary = text.trim();
                root.searchRequested(text.trim());
              }
            }
          }
          Keys.onEscapePressed: function () {
            text = "";
            focus = false;
          }

          onFocusChanged: function () {
            if (focus) {
              searchInput.selectAll();
            }
          }
        }
      }
    }
  }
}
