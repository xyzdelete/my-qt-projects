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

  Row {
    spacing: 40
    width: parent.width

    RangeSlider {
      // orientation: Qt.Vertical
      from: 1
      to: 100
      first.value: 25
      second.value: 75

      first.onValueChanged: function () {
        ApplicationWindow.window.title = "First value changed to: " + first.value;
      }

      second.onValueChanged: function () {
        ApplicationWindow.window.title = "Second value changed to: " + second.value;
      }
    }
  }
}
