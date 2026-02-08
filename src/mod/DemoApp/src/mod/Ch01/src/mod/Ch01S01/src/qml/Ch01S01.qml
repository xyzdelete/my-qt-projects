pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Other {}

  Column {
    anchors.centerIn: parent
    spacing: 10
    Row {
      Text {
        text: "regularMethod"
      }
      Button {
        text: "Call C++ method"
        onClicked: function () {
          BWorker.regularMethod();
        }
      }
    }
    Row {
      Text {
        text: "cppSlot()"
      }
      Button {
        text: "Call C++ slot"
        onClicked: function () {
          BWorker.cppSlot();
        }
      }
    }
    Row {
      TextField {
        id: nameFieldId
        placeholderText: "name"
        text: "John"
      }
      TextField {
        id: ageFieldId
        placeholderText: "age"
        text: "25"
      }
      Button {
        text: "Call C++ method with return"
        onClicked: function () {
          let response = BWorker.regularMethodWithReturn(nameFieldId.text, parseInt(ageFieldId.text));
          print(response);
        }
      }
    }
  }
}
