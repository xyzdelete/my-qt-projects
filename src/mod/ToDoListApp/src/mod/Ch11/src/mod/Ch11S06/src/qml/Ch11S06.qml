pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: rootId
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  ListModel {
    id: mListModel
    ListElement {
      firstName: "John"
      lastName: "Snow"
    }
    ListElement {
      firstName: "Nicholai"
      lastName: "Itchenko"
    }
    ListElement {
      firstName: "Mitch"
      lastName: "Mathson"
    }
    ListElement {
      firstName: "Ken"
      lastName: "Kologorov"
    }
    ListElement {
      firstName: "Vince"
      lastName: "Luvkyj"
    }
  }

  ColumnLayout {
    anchors.fill: parent
    ListView {
      id: mListViewId
      model: mListModel
      delegate: delegateId
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    Button {
      text: "Add Item"
      Layout.fillWidth: true
      onClicked: function () {
        mListModel.append({
          "firstName": "Bob",
          "lastName": "Johnson"
        });
      }
    }

    Button {
      text: "Clear"
      Layout.fillWidth: true
      onClicked: function () {
        mListModel.clear();
      }
    }

    Button {
      text: "Delete Item at index 2"
      Layout.fillWidth: true
      onClicked: function () {
        if (mListViewId.model.count > 2) {
          mListModel.remove(2, 1);
        } else {
          ApplicationWindow.window.title = "index is invalid";
        }
      }
    }

    Button {
      text: "Set item at index 1"
      Layout.fillWidth: true
      onClicked: function () {
        mListModel.set(1, {
          "firstName": "John",
          "lastName": "Doe"
        });
      }
    }
  }

  Component {
    id: delegateId
    Rectangle {
      id: rectangleId
      required property string firstName
      required property string lastName
      width: mListViewId.width
      height: 50
      color: "beige"
      border.color: "yellowgreen"
      radius: 14
      Text {
        id: textId
        anchors.centerIn: parent
        text: rectangleId.firstName + " " + rectangleId.lastName
        font.pointSize: 20
      }
      MouseArea {
        anchors.fill: parent
        onClicked: function () {
          ApplicationWindow.window.title = "Clicked on: " + rectangleId.firstName + " " + rectangleId.lastName;
        }
      }
    }
  }
}
