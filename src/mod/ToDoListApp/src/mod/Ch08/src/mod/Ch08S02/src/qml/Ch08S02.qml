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
    height: parent.height

    BusyIndicator {
      id: busyIndicatorId
      Layout.alignment: Qt.AlignHCenter
      running: false
      visible: false
    }

    ColumnLayout {
      Button {
        id: button1
        text: "Running"
        Layout.fillWidth: true
        onClicked: function () {
          busyIndicatorId.running = true;
          busyIndicatorId.visible = true;
        }
      }
      Button {
        id: button2
        text: "Not running"
        Layout.fillWidth: true
        onClicked: function () {
          busyIndicatorId.running = false;
          busyIndicatorId.visible = false;
        }
      }
    }

    Item {
      Layout.fillHeight: true
      Layout.fillWidth: true
      Rectangle {
        anchors.fill: parent
        color: "red"
      }
    }
  }
}
