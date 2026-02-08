pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root
  height: 80

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
        icon.source: "qrc:/qt/qml/Ch11S11/src/resrc/images/tasks.svg"
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
          color: themeToggle.pressed ? (root.darkMode ? "#f5f5f5" : '#c4ced9') : (root.darkMode ? '#c4ced9' : "#f5f5f5")
          radius: 25
          border.color: root.darkMode ? '#000000' : "#000000"
          border.width: 1

          Behavior on color {
            ColorAnimation {
              duration: 1000
            }
          }
        }

        icon.source: "qrc:/qt/qml/Ch11S11/src/resrc/images/sun.svg"
        icon.color: "transparent"

        // Emit the signal when button is clicked
        onClicked: root.toggleDarkMode()
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
