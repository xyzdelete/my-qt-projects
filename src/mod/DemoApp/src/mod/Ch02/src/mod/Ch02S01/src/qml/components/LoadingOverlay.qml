pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  required property var theme
  required property bool isVisible
  required property var githubService

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    visible: root.isVisible

    Behavior on color {
      ColorAnimation {
        duration: root.theme.animationDuration
      }
    }

    ColumnLayout {
      anchors.centerIn: parent
      spacing: 20

      Rectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: 40
        Layout.preferredHeight: 40
        radius: 20
        gradient: Gradient {
          GradientStop {
            position: 0.0
            color: root.theme.accentGlassGradientStart
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
          GradientStop {
            position: 1.0
            color: root.theme.accentGlassGradientEnd
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
        }

        RotationAnimation on rotation {
          running: root.githubService.isLoading
          from: 0
          to: 360
          duration: 1000
          loops: Animation.Infinite
        }

        Image {
          id: loadingIcon
          anchors.centerIn: parent
          source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/loadingIcon.svg"
          sourceSize: Qt.size(20, 20)
        }
      }

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Loading repositories..."
        color: root.theme.textPrimary
        font.pixelSize: 16

        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
    }
  }
}
