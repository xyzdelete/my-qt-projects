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
    id: modelId
    ListElement {
      mNumber: 1
      mColor: "red"
    }
    ListElement {
      mNumber: 2
      mColor: "green"
    }
    ListElement {
      mNumber: 3
      mColor: "beige"
    }
    ListElement {
      mNumber: 4
      mColor: "yellowgreen"
    }
    ListElement {
      mNumber: 5
      mColor: "dodgerBlue"
    }
    ListElement {
      mNumber: 6
      mColor: "lightyellow"
    }
    ListElement {
      mNumber: 7
      mColor: "pink"
    }
    ListElement {
      mNumber: 8
      mColor: "magenta"
    }
    ListElement {
      mNumber: 9
      mColor: "silver"
    }
  }
  GridView {
    id: mGridViewId
    anchors.fill: parent
    model: modelId
    // flow: GridView.FlowTopToBottom
    // layoutDirection: Qt.RightToLeft
    delegate: Rectangle {
      id: rectId
      required property string mColor
      required property int mNumber
      width: 100
      height: width
      color: mColor
      Text {
        text: rectId.mNumber
        anchors.centerIn: parent
        font.pointSize: 20
      }
    }
  }
}
