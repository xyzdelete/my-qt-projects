pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Column {
    spacing: 40
    width: parent.width

    Label {
      width: parent.width
      wrapMode: Label.Wrap
      horizontalAlignment: Qt.AlignHCenter
      text: "TextArea is a multi-line text editor."
    }

    ScrollView {
      id: scrollView
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width
      height: 150

      TextArea {
        id: textAreaId
        font.pointSize: 15
        wrapMode: TextArea.WordWrap
        placeholderText: "Type in your query"
        text: "Some really long text to make sure you can see the scrollbars you worked so hard for."
      }
    }
    Button {
      text: "Submit"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        ApplicationWindow.window.title = "The text inside the TextArea is: " + textAreaId.text;
        textAreaId.text = textAreaId.text + "Some additional text.";
      }
    }
  }
}
