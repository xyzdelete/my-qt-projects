pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Row {
    x: 10
    y: 10
    spacing: 10

    Rectangle {
      id: firstNameRectId
      width: firstNameLabelId.implicitWidth + 20
      height: firstNameLabelId.implicitHeight + 20
      color: "beige"

      Text {
        id: firstNameLabelId
        anchors.centerIn: parent
        text: "FirstName: "
      }
    }

    Rectangle {
      id: firstNameTextRectId
      color: "beige"
      width: firstNameTextId.implicitWidth + 20
      height: firstNameTextId.implicitHeight + 20

      TextInput {
        id: firstNameTextId
        anchors.centerIn: parent
        focus: true
        text: "Type in your first name"
        onEditingFinished: function () {
          ApplicationWindow.window.title = "The first name changed to: " + text;
        }
      }
    }
  }

  Row {
    x: 10
    y: 60
    spacing: 10

    Rectangle {
      id: lastNameRectId
      width: lastNameLabelId.implicitWidth + 20
      height: lastNameLabelId.implicitHeight + 20
      color: "beige"

      Text {
        id: lastNameLabelId
        anchors.centerIn: parent
        text: "LastName: "
      }
    }

    Rectangle {
      id: lastNameTextRectId
      color: "beige"
      width: lastNameTextId.implicitWidth + 20
      height: lastNameTextId.implicitHeight + 20

      TextInput {
        id: lastNameTextId
        anchors.centerIn: parent
        focus: true
        text: "Type in your first name"
        onEditingFinished: function () {
          ApplicationWindow.window.title = "The last name changed to: " + text;
        }
      }
    }
  }
}
