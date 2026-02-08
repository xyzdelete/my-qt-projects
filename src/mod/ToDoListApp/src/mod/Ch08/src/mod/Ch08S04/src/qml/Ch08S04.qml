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
      width: parent.width
      wrapMode: Label.Wrap
      Layout.fillWidth: true
      text: "DelayButton. Use it when you want to prevent accidental clicks"
      font.pointSize: 15
    }

    DelayButton {
      property bool activated: false
      text: "DelayButton"
      Layout.fillWidth: true
      delay: 1000

      onPressed: function () {
        if (activated === true) {
          ApplicationWindow.window.title = "Button is clicked. Carring out the task";
        }
      }

      onActivated: function () {
        ApplicationWindow.window.title = "Button activated";
        activated = true;
      }

      onProgressChanged: function () {
        ApplicationWindow.window.title = progress;
      }
    }
  }
}
