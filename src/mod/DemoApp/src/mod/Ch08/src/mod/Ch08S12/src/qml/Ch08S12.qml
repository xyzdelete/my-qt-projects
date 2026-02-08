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
    width: parent.width
    spacing: 20

    Slider {
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width
      from: 1
      to: 100
      value: 40
      onValueChanged: function () {
        progressBarId.value = value;
      }
    }

    ProgressBar {
      id: progressBarId
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width
      from: 1
      to: 100
      value: 40
    }
  }
}
