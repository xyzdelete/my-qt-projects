pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts

Item {
  id: rootId

  required property bool isVisible
  required property GitHubService gitHubService

  Rectangle {
    anchors.fill: parent
    color: "transparent"
    visible: rootId.isVisible

    Behavior on color {
      ColorAnimation {
        duration: Theme.animationDuration
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
            color: Theme.accentGlassGradientStart
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
          GradientStop {
            position: 1.0
            color: Theme.accentGlassGradientEnd
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }

        RotationAnimation on rotation {
          running: rootId.gitHubService.isLoading
          from: 0
          to: 360
          duration: 1000
          loops: Animation.Infinite
        }

        Image {
          id: loadingIconId

          anchors.centerIn: parent
          source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/loadingIcon.svg"
          sourceSize: Qt.size(20, 20)
        }
      }

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Loading repositories..."
        color: Theme.textPrimary
        font.pixelSize: 16

        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
    }
  }
}
