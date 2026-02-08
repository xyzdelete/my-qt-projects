pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Item {
  id: rootId

  property url iconSource: ""

  property alias text: tokenFieldId.text
  property alias placeholderText: tokenFieldId.placeholderText

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
      border.color: Theme.glassBorder
      border.width: 1

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

          iconSource: rootId.iconSource

          onClicked: function () {
            rootId.tokenInputButtonClicked();
          }
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
      }
    }
  }
}
