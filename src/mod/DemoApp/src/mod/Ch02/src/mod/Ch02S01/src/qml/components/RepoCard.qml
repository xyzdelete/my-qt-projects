pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Item {
  id: rootId

  required property Repository repositoryData
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

      // Header row with repo name and status
      RowLayout {
        Layout.fillWidth: true

        Text {
          text: rootId.repositoryData ? rootId.repositoryData.fullName : ""
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
          width: statusTextId.implicitWidth + 10
          height: statusTextId.implicitHeight + 10
          radius: 10

          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: rootId.repositoryData && rootId.repositoryData.isPrivate ? Theme.errorGlass : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: rootId.repositoryData && rootId.repositoryData.isPrivate ? Theme.errorGlassHover : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          Text {
            id: statusTextId

            anchors.centerIn: parent
            text: rootId.repositoryData && rootId.repositoryData.isPrivate ? "Private" : "Public"

            color: Theme.textPrimary
            font.pixelSize: 12
            font.weight: Font.Bold
          }

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }

      // Description
      Text {
        text: rootId.repositoryData && rootId.repositoryData.description ? rootId.repositoryData.description : "No description available"
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

      // Stats row
      RowLayout {
        Layout.fillWidth: true
        spacing: 10

        // Language
        RowLayout {
          spacing: 5
          visible: rootId.repositoryData && rootId.repositoryData.language

          Rectangle {
            width: 12
            height: 12
            radius: 6
            color: Theme.getLanguageColor(rootId.repositoryData ? rootId.repositoryData.language : "")
          }

          Text {
            text: rootId.repositoryData ? rootId.repositoryData.language : ""
            color: Theme.textSecondary
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }

        // Stars
        RowLayout {
          spacing: 5

          Image {
            source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/starIcon.svg"
            sourceSize: Qt.size(10, 10)
          }
          Text {
            text: rootId.formatNumber(rootId.repositoryData ? rootId.repositoryData.stargazersCount : 0)
            color: Theme.textSecondary
            font.pixelSize: 12
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }

        // Forks
        RowLayout {
          spacing: 5

          Image {
            source: "qrc:/qt/qml/Ch02S01/src/resrc/assets/icons/forkIcon.svg"
            sourceSize: Qt.size(10, 10)
          }

          Text {
            text: rootId.formatNumber(rootId.repositoryData ? rootId.repositoryData.forksCount : 0)
            color: Theme.textSecondary
            font.pixelSize: 12
            Behavior on color {
              ColorAnimation {
                duration: Theme.animationDuration
              }
            }
          }
        }
      }

      Text {
        text: rootId.formatDate(rootId.repositoryData ? rootId.repositoryData.updatedAt : new Date())
        color: Theme.textTertiary
        font.pixelSize: 12
        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDuration
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

  function formatNumber(num: real): string {
    if (num >= 1000000) {
      return (num / 1000000).toFixed(1) + "M";
    }
    if (num >= 1000) {
      return (num / 1000).toFixed(1) + "k";
    }
    return num.toString();
  }

  function formatDate(date: date): string {
    if (!date) {
      return "";
    }
    const now = new Date();
    const diffTime = Math.abs(now - date);
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays === 0) {
      return "Today";
    }
    if (diffDays === 1) {
      return "Yesterday";
    }
    if (diffDays < 7) {
      return diffDays + " days ago";
    }
    if (diffDays < 31) {
      return Math.ceil(diffDays / 7) + " weeks ago";
    }
    if (diffDays < 365) {
      return Math.ceil(diffDays / 30) + " months ago";
    }
    return Math.ceil(diffDays / 365) + " years ago";
  }
}
