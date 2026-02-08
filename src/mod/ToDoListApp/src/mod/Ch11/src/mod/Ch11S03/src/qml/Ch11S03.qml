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

  ListView {
    id: mListViewId
    anchors.fill: parent
    header: headerId
    footer: Rectangle {
      width: rootId.width
      height: 50
      color: "dodgerblue"
    }
    highlight: Rectangle {
      width: rootId.width
      color: "blue"
      radius: 14
      border.color: "yellowgreen"
      z: 2
      opacity: 0.1
    }

    model: ["January", "February", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    delegate: Rectangle {
      id: delegateId
      required property string modelData
      required property int index
      width: rootId.width
      height: 50
      color: "beige"
      border.color: "yellowgreen"
      radius: 10
      Text {
        id: textId
        anchors.centerIn: parent
        font.pointSize: 20
        text: delegateId.modelData
      }
      MouseArea {
        anchors.fill: parent
        onClicked: function () {
          ApplicationWindow.window.title = "Clicked on: " + delegateId.modelData;
          mListViewId.currentIndex = delegateId.index;
        }
      }
    }
    Component {
      id: headerId
      Rectangle {
        id: headerRectId
        width: rootId.width
        height: 50
        color: "yellowgreen"
        border {
          color: "#9EDDF2"
          width: 2
        }
        Text {
          anchors.centerIn: parent
          text: "Months"
          font.pointSize: 20
        }
      }
    }
  }
}
