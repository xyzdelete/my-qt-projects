pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  ListView {
    id: mListViewId
    anchors.fill: parent
    model: mModelId
    delegate: delegateId
  }

  ListModel {
    id: mModelId
    ListElement {
      country: "Rwanda"
      capital: "Kigali"
    }
    ListElement {
      country: "Germany"
      capital: "Berlin"
    }
    ListElement {
      country: "Japan"
      capital: "Tokyo"
    }
    ListElement {
      country: "Nigeria"
      capital: "Lagos"
    }
    ListElement {
      country: "Ghana"
      capital: "Accra"
    }
    ListElement {
      country: "Kenya"
      capital: "Nairobi"
    }
    ListElement {
      country: "India"
      capital: "New Delhi"
    }
    ListElement {
      country: "Uganda"
      capital: "Kampala"
    }
  }

  Component {
    id: delegateId

    Rectangle {
      id: rectangleId
      // required property var model
      required property string capital
      required property string country
      width: parent.width
      height: 50
      color: "dodgerblue"
      border.color: "black"
      radius: 15
      Text {
        id: textId
        anchors.centerIn: parent
        font.pointSize: 20
        text: rectangleId.country + ": " + rectangleId.capital
      }
      MouseArea {
        anchors.fill: parent
        onClicked: {
          ApplicationWindow.window.title = "Clicked on: " + rectangleId.capital + ", " + rectangleId.country;
        }
      }
    }
  }
}
