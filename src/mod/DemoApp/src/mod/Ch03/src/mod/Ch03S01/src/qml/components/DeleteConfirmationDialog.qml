pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

Item {
  id: rootId

  required property ContactManager contactManager
  required property real drawerWidth
  required property real drawerHeight

  property alias drawer: drawerId
  property alias edge: drawerId.edge
  property alias interactive: drawerId.interactive

  property string initials: ""
  property string firstName: ""
  property string lastName: ""
  property color avatarColor: "#6366F1"
  property int index: -1

  readonly property ContactFilterProxyModel proxyModel: contactManager.proxyModel

  function setContact(contact: ContactDelegate): void {
    rootId.initials = contact.initials;
    rootId.firstName = contact.firstName;
    rootId.lastName = contact.lastName;
    fullNameFieldId.text = contact.firstName + " " + contact.lastName;
    rootId.avatarColor = contact.avatarColor;
    rootId.index = rootId.proxyModel.mapToSourceIndex(contact.index);
  }

  width: rootId.drawerWidth
  height: rootId.drawerHeight

  Drawer {
    id: drawerId

    width: parent.width
    height: parent.height
    dragMargin: 20

    background: Rectangle {
      color: Theme.backgroundGlass
    }

    contentItem: ColumnLayout {
      spacing: 10

      RowLayout {
        Layout.minimumWidth: 280
        Layout.maximumWidth: 280
        Layout.minimumHeight: 300
        Layout.maximumHeight: 300
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        Rectangle {
          id: deleteConfirmationDialogId

          Layout.fillWidth: true
          Layout.fillHeight: true
          radius: 10
          border.color: deleteButtonId.hovered ? Theme.errorGlassHover : Theme.glassBorder
          border.width: deleteButtonId.hovered ? 2 : 1
          visible: false
          gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
              position: 0.0
              color: Theme.backgroundGlassCardGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: Theme.backgroundGlassCardGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }
        }
        MultiEffect {
          source: deleteConfirmationDialogId
          Layout.fillWidth: true
          Layout.fillHeight: true
          blurEnabled: true
          blur: 0.2
        }
        ColumnLayout {
          Layout.fillWidth: true
          Layout.fillHeight: true
          spacing: 10
          Image {
            Layout.alignment: Qt.AlignHCenter
            source: "/qt/qml/Ch03S01/src/resrc/assets/icons/warningIcon.svg"
            sourceSize: Qt.size(40, 40)
          }
          Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Delete contact"
            font.pixelSize: 20
            font.weight: Font.Bold
            color: Theme.textPrimary
          }
          // Divider
          Divider {
            Layout.fillWidth: true
          }
          ScrollView {
            id: scrollViewId

            Layout.fillWidth: true
            clip: true
            contentWidth: availableWidth
            ColumnLayout {
              width: scrollViewId.availableWidth
              RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                Rectangle {
                  Layout.preferredHeight: 70
                  Layout.preferredWidth: 250
                  radius: 10
                  color: "transparent"
                  border.color: Theme.glassBorder
                  border.width: 1
                  RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 10
                    // Avatar with initials
                    Item {
                      Layout.preferredWidth: 50
                      Layout.preferredHeight: 50
                      Layout.alignment: Qt.AlignLeft
                      Rectangle {
                        id: contactCardAvatarId

                        anchors.fill: parent
                        radius: 25
                        border.color: Theme.glassBorder
                        border.width: 1
                        visible: false

                        gradient: Gradient {
                          GradientStop {
                            position: 0.0
                            color: Theme.isDark ? rootId.avatarColor : "transparent"
                            Behavior on color {
                              ColorAnimation {
                                duration: Theme.animationDuration
                              }
                            }
                          }
                          GradientStop {
                            position: 1.0
                            color: Theme.isDark ? "transparent" : rootId.avatarColor
                            Behavior on color {
                              ColorAnimation {
                                duration: Theme.animationDuration
                              }
                            }
                          }
                        }
                      }
                      // Siblings order matters
                      MultiEffect {
                        source: contactCardAvatarId
                        anchors.fill: contactCardAvatarId
                        blurEnabled: true
                        blur: 0.5
                      }
                      Text {
                        anchors.centerIn: parent

                        text: rootId.initials

                        font.pixelSize: 20
                        font.weight: Font.Bold
                        color: Theme.textPrimary
                      }
                    }
                    Text {
                      id: fullNameFieldId

                      Layout.fillWidth: true
                      color: Theme.textPrimary
                      font.pixelSize: 14
                      text: rootId.firstName + " " + rootId.lastName
                    }
                  }
                }
              }
            }

            ScrollBar.vertical: ScrollBar {
              policy: ScrollBar.AlwaysOff
              height: scrollViewId.availableHeight
              x: scrollViewId.width - width
              background: Rectangle {
                color: Theme.backgroundGlass
                implicitWidth: 1
                Behavior on color {
                  ColorAnimation {
                    duration: Theme.animationDuration
                  }
                }
              }

              contentItem: Rectangle {
                color: Theme.accentGlassHover
                implicitWidth: 1
                Behavior on color {
                  ColorAnimation {
                    duration: Theme.animationDuration
                  }
                }
              }
            }
          }
          // Divider
          Divider {
            Layout.fillWidth: true
          }
          RowLayout {
            spacing: 10
            Layout.fillWidth: true
            Text {
              Layout.fillWidth: true
              text: "Are you sure you want to delete this contact? This action cannot be undone."
              font.pixelSize: 12
              color: Theme.textSecondary
              wrapMode: Text.Wrap
              verticalAlignment: Qt.AlignVCenter
              horizontalAlignment: Qt.AlignHCenter
            }
          }
        }
      }

      RowLayout {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        Layout.margins: 10
        CustomButton {
          id: closeButtonId

          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter
          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuCloseIcon.svg"

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: closeButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : closeButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: closeButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : closeButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            drawerId.close();
          }
        }
        CustomButton {
          id: deleteButtonId

          Layout.preferredWidth: 100
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0

          backgroundBorderColor: Theme.errorGlassHover

          contentItem: Text {
            text: "Delete"
            color: Theme.textPrimary
            font.pointSize: 12
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: deleteButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : deleteButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: deleteButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : deleteButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            rootId.contactManager.removeContact(rootId.index);
            drawerId.close();
          }
        }
      }
    }
  }
}
