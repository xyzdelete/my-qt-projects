pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: mRect1
    width: mText1.implicitWidth + 20
    height: mText1.implicitHeight + 20
    color: "beige"
    border.color: "yellowgreen"

    Text {
      id: mText1
      anchors.centerIn: parent
      text: lastname
      font.pointSize: 20
    }
  }

  Rectangle {
    id: mRect2
    anchors.left: mRect1.right
    anchors.leftMargin: 5
    width: mText2.implicitWidth + 20
    height: mText2.implicitHeight + 20
    color: "beige"
    border.color: "yellowgreen"

    Text {
      id: mText2
      anchors.centerIn: parent
      text: firstname
      font.pointSize: 20
    }
  }
}
