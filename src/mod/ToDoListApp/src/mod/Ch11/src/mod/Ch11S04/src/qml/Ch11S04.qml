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
      names: "Seth Moris"
      company: "GOOGLE"
    }
    ListElement {
      names: "Miriam Katv"
      company: "GOOGLE"
    }
    ListElement {
      names: "Eugene Fitzgerald"
      company: "GOOGLE"
    }
    ListElement {
      names: "Kantkl Vikney"
      company: "GOOGLE"
    }
    ListElement {
      names: "Mary Beige"
      company: "TESLA"
    }
    ListElement {
      names: "Bamaba Pikt"
      company: "TESLA"
    }
    ListElement {
      names: "Jeffery Mor"
      company: "SIEMENS"
    }
    ListElement {
      names: "Pick Mo"
      company: "SIEMENS"
    }
  }

  ListView {
    id: mListViewId
    anchors.fill: parent
    model: mListModel
    delegate: delegateId
    section {
      property: "company"
      criteria: ViewSection.FullString
      delegate: Rectangle {
        id: sectionRectId
        required property string section
        width: parent.width
        height: 50
        color: "red"
        border.color: "yellowgreen"
        radius: 14

        Text {
          id: sectionTextId
          text: sectionRectId.section
          anchors.centerIn: parent
          font.pointSize: 20
        }
        MouseArea {
          anchors.fill: parent
          onClicked: function () {
            ApplicationWindow.window.title = "Clicked on: " + sectionRectId.section;
          }
        }
      }
    }
  }

  Component {
    id: delegateId
    Rectangle {
      id: rectangleId
      required property string names
      width: parent.width
      height: 50
      color: "beige"
      border.color: "yellowgreen"
      radius: 14
      Text {
        id: textId
        anchors.centerIn: parent
        text: rectangleId.names
        font.pointSize: 20
      }
      MouseArea {
        anchors.fill: parent
        onClicked: function () {
          ApplicationWindow.window.title = "Clicked on: " + rectangleId.names;
        }
      }
    }
  }
}
