pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Connections {
    target: CppSignalSender
    function onCppTimer(value) {
      displayText.text = value;
    }

    function onCallQml(message) {
      print("QML received: " + message);
    }
  }

  Column {
    anchors.centerIn: parent
    spacing: 20

    Rectangle {
      width: 200
      height: 200
      color: "red"
      radius: 10

      Text {
        id: displayText
        anchors.centerIn: parent
        text: "0"
        color: "white"
        font.pointSize: 40
      }
    }

    Button {
      text: "Call C++ slot"
      onClicked: function () {
        CppSignalSender.cppSlot();
      }
    }
  }
}
