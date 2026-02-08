pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1
  readonly property Window appWindow: ApplicationWindow.window
  readonly property int buttonWidth: 300

  Column {
    spacing: 20
    width: parent.width

    Label {
      width: parent.width
      wrapMode: Label.Wrap
      horizontalAlignment: Qt.AlignHCenter
      text: "Dialog is a popup that is mostly used for short-term tasks and brief communications with the user."
    }

    Button {
      text: "Message"
      anchors.horizontalCenter: parent.horizontalCenter
      width: rootRectangle.buttonWidth
      onClicked: function () {
        messageDialog.open();
      }

      Dialog {
        id: messageDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "Message"
        Label {
          text: "Lorem ipsum dolor sit amet..."
        }
      }
    }

    Button {
      id: button
      text: "Confirmation"
      anchors.horizontalCenter: parent.horizontalCenter
      width: rootRectangle.buttonWidth
      onClicked: function () {
        confirmationDialog.open();
      }

      Dialog {
        id: confirmationDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: Overlay.overlay

        modal: true
        title: "Confirmation"
        standardButtons: Dialog.Yes | Dialog.No

        Column {
          spacing: 20

          anchors.fill: parent
          Label {
            text: "The document has been modified.\nDo you want to save your changes?"
          }
          CheckBox {
            text: "Do not ask again"
            anchors.right: parent.right
          }
        }
      }
    }

    Button {
      text: "Content"
      anchors.horizontalCenter: parent.horizontalCenter
      width: rootRectangle.buttonWidth
      onClicked: function () {
        contentDialog.open();
      }
      Dialog {
        id: contentDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: Math.min(parent.width, parent.height) / 3 * 2
        parent: Overlay.overlay
        contentHeight: logo.height

        modal: true
        title: "Content"
        standardButtons: Dialog.Close

        Flickable {
          id: flickable
          clip: true
          anchors.fill: parent
          contentHeight: column.implicitHeight

          Column {
            id: column

            spacing: 20
            width: parent.width
            height: implicitHeight

            Image {
              id: logo
              width: parent.width / 2
              anchors.horizontalCenter: parent.horizontalCenter
              fillMode: Image.PreserveAspectFit
              source: "qrc:/qt/qml/Ch09S06/src/resrc/images/LearnQtLogo.png"
            }
            Label {
              width: parent.width
              text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
              wrapMode: Label.Wrap
            }
          }
          ScrollIndicator.vertical: ScrollIndicator {
            parent: contentDialog.contentItem
            anchors.top: flickable.top
            anchors.bottom: flickable.bottom
            anchors.right: parent.right
            anchors.rightMargin: -contentDialog.rightPadding
          }
        }
      }
    }
    Button {
      text: "input"
      anchors.horizontalCenter: parent.horizontalCenter
      width: rootRectangle.buttonWidth
      onClicked: function () {
        inputDialog.open();
      }
      Dialog {
        id: inputDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: Overlay.overlay
        focus: true
        modal: true
        title: "Input"
        standardButtons: Dialog.Ok | Dialog.Cancel
        ColumnLayout {
          spacing: 20
          anchors.fill: parent
          Label {
            elide: Label.ElideRight
            Layout.fillWidth: true
            text: "Please enter the credentials"
          }
          TextField {
            focus: true
            Layout.fillWidth: true
            placeholderText: "Username"
          }
          TextField {

            placeholderText: "Password"
            Layout.fillWidth: true
            echoMode: TextField.PasswordEchoOnEdit
          }
        }
      }
    }
  }
}
