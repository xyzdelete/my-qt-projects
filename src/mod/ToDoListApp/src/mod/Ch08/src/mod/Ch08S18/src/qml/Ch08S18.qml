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

  Page {
    anchors.fill: parent

    header: ToolBar {
      height: 50
      background: Rectangle {
        color: "mintcream"
      }
      RowLayout {
        spacing: 20
        anchors.fill: parent

        ToolButton {
          background: Rectangle {
            color: "gray"
          }
          icon.source: "qrc:/qt/qml/Ch08S18/src/resrc/images/drawer.png"
          onClicked: function () {
            ApplicationWindow.window.title = "Toolbutton clicked";
            drawerId.open();
          }
        }
        Label {
          id: titleLabel
          text: "Drawer App"
          color: "black"
          font.pixelSize: 20
          elide: Label.ElideRight
          horizontalAlignment: Qt.AlignHCenter
          verticalAlignment: Qt.AlignVCenter
          Layout.fillWidth: true
        }
      }
    }

    Drawer {
      id: drawerId
      width: Math.min(rootRectangle.width, rootRectangle.height) * (2 / 3)
      height: rootRectangle.height
      interactive: true

      ColumnLayout {
        spacing: 0
        width: parent.width

        Button {
          width: parent.width
          height: 50
          text: "Item1"
          font.pointSize: 20
          background: Rectangle {
            color: "beige"
          }
          Layout.fillWidth: true

          onClicked: function () {
            ApplicationWindow.window.title = "Clicked on item1 ";
            contentRectId.color = "red";
            drawerId.close();
          }
        }
        Button {
          width: parent.width
          height: 50
          text: "Item2"
          font.pointSize: 20
          background: Rectangle {
            color: "yellowgreen"
          }
          Layout.fillWidth: true

          onClicked: function () {
            ApplicationWindow.window.title = "Clicked on item2 ";
            contentRectId.color = "green";
            drawerId.close();
          }
        }
        Button {
          width: parent.width
          height: 50
          text: "Item3"
          font.pointSize: 20
          background: Rectangle {
            color: "dodgerblue"
          }
          Layout.fillWidth: true

          onClicked: function () {
            ApplicationWindow.window.title = "Clicked on item3 ";
            contentRectId.color = "blue";
            drawerId.close();
          }
        }
      }
    }

    Rectangle {
      id: contentRectId
      anchors.fill: parent
      color: "gray"
    }
  }
}
