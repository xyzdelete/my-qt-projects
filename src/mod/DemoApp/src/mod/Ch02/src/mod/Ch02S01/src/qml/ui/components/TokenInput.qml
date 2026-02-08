pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  required property var theme
  property alias text: tokenField.text
  property alias placeholderText: tokenField.placeholderText
  property url iconSource: ""

  signal tokenChanged(string token)

  ColumnLayout {
    anchors.fill: parent
    // Main container
    Rectangle {
      id: tokenInputContainer
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
          id: tokenField
          Layout.fillWidth: true
          placeholderText: "Enter GitHub Token..."
          color: root.theme.textPrimary
          font.pixelSize: 14
          selectByMouse: true
          echoMode: TextInput.Password

          background: Rectangle {
            color: "transparent"
          }
          placeholderTextColor: root.theme.textPrimary

          Keys.onEscapePressed: function () {
            text = "";
            focus = false;
          }

          onTextChanged: function () {
            root.tokenChanged(text);
          }
        }
      }
    }
  }
}
