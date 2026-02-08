pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Item {
  id: rootId

  required property string avatarUrlField
  required property string loginField
  required property string userTypeField
  required property string htmlUrlField

  required property real cardWidth
  required property real cardHeight

  property alias cardMargins: cardId.anchors.margins

  width: rootId.cardWidth
  height: rootId.cardHeight

  signal clicked

  Rectangle {
    id: cardId

    anchors.fill: parent

    radius: 10
    color: "transparent"

    Rectangle {
      id: gradientLayerId

      anchors.fill: parent
      radius: 10
      border.color: Theme.glassBorder
      border.width: 1
      visible: false
      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: cardMouseAreaId.pressed ? Theme.backgroundGlassCardPressedGradientStart : cardHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientStart : Theme.backgroundGlassCardGradientStart
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: cardMouseAreaId.pressed ? Theme.backgroundGlassCardPressedGradientEnd : cardHoverHandlerId.hovered ? Theme.backgroundGlassCardHoverGradientEnd : Theme.backgroundGlassCardGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }
    }

    MultiEffect {
      source: gradientLayerId
      anchors.fill: gradientLayerId
      blurEnabled: true
      blur: 0.2
    }

    MouseArea {
      id: cardMouseAreaId

      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      onClicked: function () {
        rootId.clicked();
      }
    }

    HoverHandler {
      id: cardHoverHandlerId
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      RowLayout {
        Layout.fillWidth: true
        spacing: 10
        Item {
          Layout.preferredWidth: 50
          Layout.preferredHeight: 50
          Image {
            id: avatarImageId
            anchors.fill: parent
            source: rootId.avatarUrlField ?? ""
            sourceSize: Qt.size(parent.width, parent.height)
            asynchronous: true
            cache: true
            fillMode: Image.PreserveAspectCrop
            visible: false
          }

          Rectangle {
            id: avatarMaskId
            visible: false
            anchors.fill: parent
            radius: width / 2

            layer.enabled: true
          }

          MultiEffect {
            anchors.fill: parent
            source: avatarImageId
            maskEnabled: true
            maskSource: avatarMaskId
          }

          Rectangle {
            anchors.fill: parent
            border.color: Theme.glassBorder
            border.width: 1
            radius: width / 2
            color: "transparent"
          }
        }
        Text {
          text: rootId.loginField ?? "No login name"
          color: Theme.textPrimary
          font.pixelSize: 16
          font.weight: Font.Bold
          Layout.fillWidth: true
          elide: Text.ElideRight

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        Rectangle {
          Layout.preferredHeight: userTypeTextId.implicitHeight + 10
          Layout.preferredWidth: userTypeTextId.implicitWidth + 10
          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: Theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: Theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }
          border.color: Theme.glassBorder
          radius: 10
          Text {
            id: userTypeTextId
            anchors.fill: parent
            text: rootId.userTypeField ?? "User type not specified"
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter

            color: Theme.textPrimary
            font.weight: Font.Bold
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }
      }

      RowLayout {
        Layout.fillWidth: true
        // Url
        Text {
          text: rootId.htmlUrlField ?? "No htmlUrl"
          textFormat: Text.PlainText
          color: Theme.textSecondary
          font.pixelSize: 14
          Layout.fillWidth: true
          wrapMode: Text.WordWrap
          maximumLineCount: 1
          elide: Text.ElideRight
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }

      // Bottom accent line
      Rectangle {
        Layout.fillWidth: true
        height: 3
        radius: 1.5
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop {
            position: 0.0
            color: "transparent"
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }

          GradientStop {
            position: 0.5
            color: Theme.accentGlassGradientEnd
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }

          GradientStop {
            position: 1.0
            color: "transparent"
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
          }
        }
      }
    }
  }
}
