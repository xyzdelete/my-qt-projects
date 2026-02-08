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

  ColumnLayout {
    width: parent.width
    spacing: 40

    Label {
      wrapMode: Label.Wrap
      Layout.fillWidth: true

      text: "A Knob used to let the user choose a value from a range"
      font.pointSize: 15
    }

    Dial {
      anchors.horizontalCenter: parent.horizontalCenter
      from: 1
      to: 100
      value: 50
      // wrap: true

      onValueChanged: function () {
        ApplicationWindow.window.title = "Current value: " + Math.ceil(value);
      }
    }
  }
}
