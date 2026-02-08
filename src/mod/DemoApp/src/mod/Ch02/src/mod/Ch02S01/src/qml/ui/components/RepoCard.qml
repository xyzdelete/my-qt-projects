pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
  id: root
  height: 160
  width: height * 2

  required property var repositoryData
  required property var theme
  signal clicked

  Rectangle {
    id: card
    anchors.fill: parent
    anchors.margins: 10
    radius: 10
    color: "transparent"

    Rectangle {
      id: gradientLayer
      anchors.fill: parent
      radius: 10
      border.color: theme.glassBorder
      border.width: 1
      visible: false
      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: "transparent"
          Behavior on color {
            ColorAnimation {
              duration: theme.normalAnimation
            }
          }
        }
        GradientStop {
          position: 1.0
          color: cardMouseArea.pressed ? theme.glassBackgroundCard : cardMouseArea.containsMouse ? theme.glassBackgroundHover : theme.glassBackgroundCard
          Behavior on color {
            ColorAnimation {
              duration: theme.normalAnimation
            }
          }
        }
      }
    }

    MultiEffect {
      source: gradientLayer
      anchors.fill: gradientLayer
      blurEnabled: true
      blur: 0.2
    }

    MouseArea {
      id: cardMouseArea
      anchors.fill: parent
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      onClicked: function () {
        root.clicked();
      }
    }

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 10
      spacing: 10

      // Header row with repo name and status
      RowLayout {
        Layout.fillWidth: true

        Text {
          text: root.repositoryData ? root.repositoryData.fullName : ""
          color: theme.textPrimary
          font.pixelSize: 16
          font.weight: Font.Bold
          Layout.fillWidth: true
          elide: Text.ElideRight

          Behavior on color {
            ColorAnimation {
              duration: theme.normalAnimation
            }
          }
        }

        Rectangle {
          width: statusText.implicitWidth + 10
          height: statusText.implicitHeight + 10
          radius: 10

          gradient: Gradient {
            GradientStop {
              position: 0.0
              color: root.repositoryData && root.repositoryData.isPrivate ? theme.error : theme.accent
              Behavior on color {
                ColorAnimation {
                  duration: theme.normalAnimation
                }
              }
            }
            GradientStop {
              position: 1.0
              color: root.repositoryData && root.repositoryData.isPrivate ? theme.errorHover : theme.accentHover
              Behavior on color {
                ColorAnimation {
                  duration: theme.normalAnimation
                }
              }
            }
          }

          Text {
            id: statusText
            anchors.centerIn: parent
            text: root.repositoryData && root.repositoryData.isPrivate ? "Private" : "Public"

            color: theme.textPrimary
            font.pixelSize: 12
            font.weight: Font.Bold
          }

          Behavior on color {
            ColorAnimation {
              duration: theme.normalAnimation
            }
          }
        }
      }

      // Description
      Text {
        text: root.repositoryData && root.repositoryData.description ? root.repositoryData.description : "No description available"
        color: theme.textSecondary
        font.pixelSize: 14
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        maximumLineCount: 1
        elide: Text.ElideRight
        Behavior on color {
          ColorAnimation {
            duration: theme.normalAnimation
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
          visible: root.repositoryData && root.repositoryData.language

          Rectangle {
            width: 12
            height: 12
            radius: 6
            color: theme.getLanguageColor(root.repositoryData ? root.repositoryData.language : theme.warning)
          }

          Text {
            text: root.repositoryData ? root.repositoryData.language : ""
            color: theme.textSecondary
            font.pixelSize: 12

            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }
        }

        // Stars
        RowLayout {
          spacing: 5

          Text {
            text: "⭐"
            color: theme.warning
            font.pixelSize: 12
            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }
          Text {
            text: root.formatNumber(root.repositoryData ? root.repositoryData.stargazersCount : 0)
            color: theme.textSecondary
            font.pixelSize: 12
            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }
        }

        // Forks
        RowLayout {
          spacing: 5

          Text {
            text: "🍴"
            color: theme.info
            font.pixelSize: 12
            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }

          Text {
            text: root.formatNumber(root.repositoryData ? root.repositoryData.forksCount : 0)
            color: theme.textSecondary
            font.pixelSize: 12
            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }
        }
      }

      Text {
        text: root.formatDate(root.repositoryData ? root.repositoryData.updatedAt : new Date())
        color: theme.textTertiary
        font.pixelSize: 12
        Behavior on color {
          ColorAnimation {
            duration: theme.normalAnimation
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
                duration: theme.normalAnimation
              }
            }
          }

          GradientStop {
            position: 0.5
            color: theme.accent
            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }

          GradientStop {
            position: 1.0
            color: "transparent"
            Behavior on color {
              ColorAnimation {
                duration: theme.normalAnimation
              }
            }
          }
        }
        Behavior on color {
          ColorAnimation {
            duration: theme.normalAnimation
          }
        }
      }
    }
  }

  function formatNumber(num) {
    if (num >= 1000000) {
      return (num / 1000000).toFixed(1) + "M";
    }
    if (num >= 1000) {
      return (num / 1000).toFixed(1) + "k";
    }
    return num.toString();
  }

  function formatDate(date) {
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
