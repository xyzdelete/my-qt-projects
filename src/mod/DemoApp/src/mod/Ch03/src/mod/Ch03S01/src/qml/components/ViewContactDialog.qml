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

  property ContactDelegate contact
  property bool isFavorite: false
  property list<string> tags
  property color avatarColor
  property int index: -1

  signal editRequested(contact: ContactDelegate)

  function setContact(contact: ContactDelegate): void {
    rootId.contact = contact;
    rootId.isFavorite = contact.isFavorite;
    rootId.tags = contact.tags;
    rootId.avatarColor = contact.avatarColor;
    rootId.index = contact.index;
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

    Overlay.modal: Rectangle {
      color: "transparent"
    }

    contentItem: ColumnLayout {
      spacing: 10
      RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Rectangle {
          id: viewContactDialogId

          radius: 10
          Layout.fillWidth: true
          Layout.fillHeight: true
          border.color: Theme.glassBorder
          border.width: editContactButtonId.hovered ? 2 : 1
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
          source: viewContactDialogId
          Layout.fillWidth: true
          Layout.fillHeight: true
          blurEnabled: true
          blur: 0.2
        }
        ColumnLayout {
          Layout.fillWidth: true
          Layout.fillHeight: true
          Layout.margins: 10
          spacing: 10

          Image {
            visible: rootId.isFavorite
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            source: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteStarIcon.svg"
            sourceSize: Qt.size(20, 20)
          }

          // Avatar with initials
          Item {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 50
            Layout.preferredHeight: 50
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

              text: rootId.contact?.initials ?? ""

              font.pixelSize: 20
              font.weight: Font.Bold
              color: Theme.textPrimary
            }
          }

          Text {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            text: (rootId.contact?.firstName ?? "") + " " + (rootId.contact?.lastName ?? "")
            font.pixelSize: 20
            font.weight: Font.Bold
            color: Theme.textPrimary
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
          }
          Text {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            visible: (rootId.contact?.jobTitle ?? "") !== ""
            text: (rootId.contact?.jobTitle ?? "") + " at " + (rootId.contact?.company ?? "")
            font.pixelSize: 12
            font.weight: Font.Bold
            color: Theme.textPrimary
            wrapMode: Text.Wrap
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
          }

          // Divider
          Divider {
            Layout.fillWidth: true
          }

          ScrollView {
            id: scrollViewId

            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentWidth: availableWidth
            ColumnLayout {
              width: scrollViewId.availableWidth

              RowLayout {
                Layout.fillWidth: true
                Text {
                  Layout.fillWidth: true
                  color: Theme.textPrimary
                  font.pixelSize: 14
                  text: "Contacts"
                  font.weight: Font.Bold

                  horizontalAlignment: Qt.AlignHCenter
                  verticalAlignment: Qt.AlignVCenter
                }
              }
              RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                CustomButton {
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/personalInfoIcon.svg"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true

                CustomButton {
                  Layout.leftMargin: 10
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/emailIcon.svg"
                  iconColor: "transparent"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Text {
                    Layout.fillWidth: true
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: "Email"
                    font.weight: Font.Bold

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: rootId.contact?.email ?? ""
                    wrapMode: Text.Wrap

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true

                CustomButton {
                  Layout.leftMargin: 10
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/phoneIcon.svg"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Text {
                    Layout.fillWidth: true
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: "Phone"
                    font.weight: Font.Bold

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: rootId.contact?.phone ?? ""
                    wrapMode: Text.Wrap

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true

                CustomButton {
                  Layout.leftMargin: 10
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/addressInfoIcon.svg"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Text {
                    Layout.fillWidth: true
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: "Address"
                    font.weight: Font.Bold

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: rootId.contact?.address ?? ""
                    wrapMode: Text.Wrap

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true

                CustomButton {
                  Layout.leftMargin: 10
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/notesIcon.svg"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: "Notes"
                    font.weight: Font.Bold

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                  Text {
                    Layout.fillWidth: true
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: rootId.contact?.notes ?? ""
                    wrapMode: Text.Wrap

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              // Divider
              Divider {
                Layout.fillWidth: true
              }
              RowLayout {
                Layout.fillWidth: true
                Text {
                  Layout.fillWidth: true
                  color: Theme.textPrimary
                  font.pixelSize: 14
                  text: "Work"
                  font.weight: Font.Bold

                  horizontalAlignment: Qt.AlignHCenter
                  verticalAlignment: Qt.AlignVCenter
                }
              }
              RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                CustomButton {
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/buildingIcon.svg"
                  iconColor: "transparent"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true

                CustomButton {
                  Layout.leftMargin: 10
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/companyIcon.svg"
                  iconColor: "transparent"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: "Company"
                    font.weight: Font.Bold

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                  Text {
                    Layout.fillWidth: true
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: rootId.contact?.company ?? ""
                    wrapMode: Text.Wrap

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true

                CustomButton {
                  Layout.leftMargin: 10
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/jobTitleIcon.svg"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Text {
                    Layout.fillWidth: true
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: "Job title"
                    font.weight: Font.Bold

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    color: Theme.textPrimary
                    font.pixelSize: 14
                    text: rootId.contact?.jobTitle ?? ""
                    wrapMode: Text.Wrap

                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              // Divider
              Divider {
                Layout.fillWidth: true
              }
              RowLayout {
                Text {
                  Layout.fillWidth: true
                  color: Theme.textPrimary
                  font.pixelSize: 14
                  text: "Tags"
                  font.weight: Font.Bold

                  horizontalAlignment: Qt.AlignHCenter
                  verticalAlignment: Qt.AlignVCenter
                }
              }
              RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10
                CustomButton {
                  Layout.preferredWidth: 50
                  Layout.preferredHeight: 50

                  hoveredCursorShape: Qt.ArrowCursor

                  backgroundBorderRadius: 10
                  backgroundBorderColor: Theme.glassBorder

                  topPadding: 0
                  bottomPadding: 0
                  leftPadding: 0
                  rightPadding: 0

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/contactTagsIcon.svg"
                  iconColor: "transparent"

                  backgroundGradient: Gradient {
                    GradientStop {
                      position: 0
                      color: Theme.buttonAccentGlassGradientStart
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1
                      color: Theme.buttonAccentGlassGradientEnd
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
              }

              Flow {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                Layout.maximumWidth: 300
                Repeater {
                  model: rootId.tags
                  delegate: ColumnLayout {
                    id: tagLayoutId

                    required property string modelData
                    spacing: 0
                    Layout.fillWidth: true
                    CustomButton {
                      id: tagButtonId

                      hoveredCursorShape: Qt.ArrowCursor

                      Layout.preferredWidth: 80
                      Layout.preferredHeight: 50

                      backgroundGradient: Gradient {
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

                      topPadding: 0
                      bottomPadding: 0
                      leftPadding: 0
                      rightPadding: 0

                      contentItem: Text {
                        text: tagLayoutId.modelData
                        font.pixelSize: 14
                        font.weight: Font.Bold
                        color: Theme.textPrimary
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignHCenter
                      }
                    }

                    // Divider
                    Divider {
                      Layout.fillWidth: true
                    }
                  }
                }
              }
            }

            ScrollBar.vertical: ScrollBar {
              policy: ScrollBar.AsNeeded
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

          Item {
            Layout.fillHeight: true
          }
        }
      }
      RowLayout {
        Layout.alignment: Qt.AlignHCenter
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
          id: editContactButtonId

          Layout.preferredWidth: 80
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0

          contentItem: Text {
            text: "Edit"
            color: Theme.textPrimary
            font.pointSize: 12
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: editContactButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : editContactButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: editContactButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : editContactButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            rootId.editRequested(rootId.contact);
            drawerId.close();
          }
        }
      }
    }
  }
}
