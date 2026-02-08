pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  TextEdit {
    id: textInputId
    wrapMode: TextEdit.Wrap
    textFormat: TextEdit.RichText
    width: 240
    text: "<strong>Because</strong> we want to use our server locally, we set ourdomain name to be <font color = 'red' >localhost </font>."
    font.family: "Helvetica"
    font.pointSize: 20
    color: "blue"
    focus: true

    onEditingFinished: function () {
      ApplicationWindow.window.title = "The current text is: " + text;
    }
  }

  Rectangle {
    id: mRectId
    width: 240
    height: 100
    color: "red"

    anchors.top: textInputId.bottom

    MouseArea {
      anchors.fill: parent
      onClicked: function () {
        ApplicationWindow.window.title = "The new text is: " + textInputId.text;
      }
    }
  }
}
