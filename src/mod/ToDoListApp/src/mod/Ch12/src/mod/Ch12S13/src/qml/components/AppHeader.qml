pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  height: 100

  // Properties that will be bound from parent
  required property color backgroundColor
  required property color textColor
  required property bool darkMode

  signal toggleDarkMode

  Rectangle {
    anchors.fill: parent
    color: root.backgroundColor

    RowLayout {
      anchors.fill: parent
      anchors.leftMargin: 10
      anchors.rightMargin: 10
      spacing: 12

      // App icon
      Button {
        background: Rectangle {
          color: "transparent"
        }
        icon.source: "qrc:/qt/qml/Ch12S13/src/resrc/images/tasks.svg"
        icon.color: "transparent"
      }

      // App title and subtitle
      Column {
        Layout.fillWidth: true
        spacing: 2

        Text {
          text: "My Tasks"
          font.pixelSize: 30
          font.weight: Font.Bold
          color: root.textColor
        }

        Text {
          text: qsTr("The list of tasks")
          font.pixelSize: 12
          color: root.textColor
          opacity: 0.4
        }
      }

      // Dark mode toggle
      Button {
        id: themeToggle
        Layout.preferredWidth: 50
        Layout.preferredHeight: 50

        background: Rectangle {
          color: root.darkMode ? (themeToggle.pressed ? "#ffffff" : (themeToggleHoverHandler.hovered && themeToggle.enabled ? Qt.lighter("#343e66", 1.5) : "#343e66")) : (themeToggle.pressed ? "#343e66" : (themeToggleHoverHandler.hovered && themeToggle.enabled ? Qt.lighter("#343e66", 1.5) : "#ffffff"))
          radius: 25
          border.color: root.darkMode ? '#ffffff' : "#000000"
          border.width: 1
          Behavior on color {
            ColorAnimation {
              duration: 500
            }
          }
        }

        icon.source: "qrc:/qt/qml/Ch12S13/src/resrc/images/sun.svg"
        icon.color: "transparent"

        // Emit the signal when button is clicked
        onClicked: root.toggleDarkMode()

        HoverHandler {
          id: themeToggleHoverHandler
          cursorShape: Qt.PointingHandCursor
        }
      }
    }
    // AppHeader and Content separator line
    Rectangle {
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      height: 1
      color: root.textColor
    }
  }
}
