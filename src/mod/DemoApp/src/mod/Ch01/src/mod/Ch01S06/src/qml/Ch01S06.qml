pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Rectangle {
  id: rootRectangle
  objectName: "Ch01S06Root"
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  function qmlJSFunction(param) {
    print("QML is talking, C++ called me with parameter: " + param + " returning back something");
    return "This is QML, over to you C++. Thanks for the call.";
  }

  Button {
    id: mButton
    text: "Call QML function from C++"
    onClicked: function () {
      QmlJsCaller.cppMethod("QML Calling...");
    }
  }
}
