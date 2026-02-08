pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
  id: root
  required property var theme
  property bool favoritesOnly: false
  property string sortBy: "name"
  property bool sortAscending: true
  property var selectedTags: []

  Rectangle {
    id: addContactDialog
    border.color: root.theme.glassBorder
    border.width: 1
    radius: 10
    anchors.fill: parent
    visible: false
    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop {
        position: 0.0
        color: addContactDialogHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientStart : root.theme.backgroundGlassCardGradientStart
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: addContactDialogHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientEnd : root.theme.backgroundGlassCardGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
    }
  }
  MultiEffect {
    source: addContactDialog
    anchors.fill: addContactDialog
    blurEnabled: true
    blur: 0.2
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    Text {
      Layout.alignment: Qt.AlignHCenter
      text: "Add New Contact"
      font.pixelSize: 20
      font.weight: Font.Bold
      color: root.theme.textPrimary
    }

    Text {
      Layout.alignment: Qt.AlignHCenter
      text: "Fill in the details below"
      font.pixelSize: 12
      font.weight: Font.Bold
      color: root.theme.textSecondary
    }

    // Divider
    Divider {
      theme: root.theme
      Layout.fillWidth: true
    }

    ScrollView {
      id: scrollView
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      contentWidth: availableWidth
      ColumnLayout {
        width: scrollView.availableWidth - 10
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          CustomButton {
            theme: root.theme

            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/personalInfoIcon.svg"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          Text {
            text: "Personal Information"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }
        }

        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "First Name"
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "Last Name"
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "Email Name"
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "Phone"
          }
        }

        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          CustomButton {
            theme: root.theme
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/workInfoIcon.svg"
            iconColor: "transparent"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          Text {
            text: "Work Information"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "Company name"
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "Job title"
          }
        }

        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          CustomButton {
            theme: root.theme
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
            backgroundBorderRadius: 10
            backgroundBorderColor: root.theme.glassBorder
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/addressInfoIcon.svg"
            buttonHoverHandler.cursorShape: undefined
            backgroundGradient: Gradient {
              GradientStop {
                position: 0
                color: root.theme.accentGlassGradientEnd
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
              GradientStop {
                position: 1
                color: "transparent"
                Behavior on color {
                  ColorAnimation {
                    duration: root.theme.animationDuration
                  }
                }
              }
            }
          }

          Text {
            text: "Address Information"
            font.pixelSize: 14
            color: root.theme.textPrimary
          }
        }
        RowLayout {
          spacing: 10
          Layout.fillWidth: true

          InputField {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            theme: root.theme
            placeholderText: "Address"
          }
        }
      }

      ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOn
        height: scrollView.availableHeight
        x: scrollView.width - width
        background: Rectangle {
          color: root.theme.backgroundGlass
          implicitWidth: 6
          radius: 3
          border.width: 1
          border.color: root.theme.glassBorder
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }

        contentItem: Rectangle {
          color: root.theme.accentGlassHover
          implicitWidth: 4
          radius: 2
          Behavior on color {
            ColorAnimation {
              duration: root.theme.animationDuration
            }
          }
        }
      }
    }

    // Divider
    Divider {
      theme: root.theme
    }

    // Divider
    Divider {
      theme: root.theme
      Layout.fillWidth: true
    }

    ColumnLayout {
      spacing: 10
      Layout.fillWidth: true
      Item {
        Layout.fillHeight: true
      }
      Text {
        text: "* First Name and Last Name required"
        font.pixelSize: 10
        color: root.theme.textSecondary
      }
    }

    Item {
      Layout.fillHeight: true
    }
  }

  HoverHandler {
    id: addContactDialogHoverHandler
  }
}
