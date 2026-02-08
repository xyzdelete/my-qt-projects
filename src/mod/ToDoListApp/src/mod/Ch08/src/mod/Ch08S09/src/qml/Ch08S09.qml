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

    Button {
      text: "Start"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: function () {
        progressBarId.value = 78;
      }
    }

    Dial {
      id: dialId
      from: 1
      to: 100
      value: 40
      anchors.horizontalCenter: parent.horizontalCenter
      onValueChanged: function () {
        progressBarId.value = value;
      }
    }

    ProgressBar {
      id: progressBarId
      from: 1
      to: 100
      value: 40
      anchors.horizontalCenter: parent.horizontalCenter
    }

    ProgressBar {
      id: progressBarId1
      indeterminate: true
      anchors.horizontalCenter: parent.horizontalCenter
    }
  }
}
