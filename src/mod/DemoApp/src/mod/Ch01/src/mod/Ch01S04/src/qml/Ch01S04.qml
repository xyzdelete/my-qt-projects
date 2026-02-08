pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Column {
    spacing: 20
    Text {
      id: titleId
      width: 500
      text: Movie === null ? "" : Movie.title
      font.pointSize: 20
      anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
      id: mainCharId
      width: 500
      text: Movie === null ? "" : Movie.mainCharacter
      font.pointSize: 20
      anchors.horizontalCenter: parent.horizontalCenter
    }

    Row {
      anchors.horizontalCenter: parent.horizontalCenter

      TextField {
        id: titleTextFieldId
        width: 300
      }
      Button {
        width: 200
        text: "Change Title"
        onClicked: function () {
          Movie.title = titleTextFieldId.text;
        }
      }
    }

    Row {
      anchors.horizontalCenter: parent.horizontalCenter
      TextField {
        id: mainCharTextFieldId
        width: 300
      }
      Button {
        width: 200
        text: "Change main character"
        onClicked: function () {
          Movie.mainCharacter = mainCharTextFieldId.text;
        }
      }
    }
  }
}
