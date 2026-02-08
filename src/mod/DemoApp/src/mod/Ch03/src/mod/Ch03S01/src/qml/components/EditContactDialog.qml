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

  property string sortBy: "name"
  property bool sortAscending: true
  property list<string> availableTags: ["client", "alumni", "lead", "friends", "vendor", "prospect", "partner", "work", "family", "colleague"]
  property list<string> tags
  property color avatarColor
  property int index: -1

  readonly property ContactFilterProxyModel proxyModel: contactManager.proxyModel

  function setContact(contact: ContactDelegate): void {
    favoritesSwitchId.checked = contact.isFavorite;
    rootId.tags = contact.tags;
    rootId.avatarColor = contact.avatarColor;
    rootId.index = contact.index;
    firstNameFieldId.text = contact.firstName;
    lastNameFieldId.text = contact.lastName;
    emailFieldId.text = contact.email;
    phoneFieldId.text = contact.phone;
    companyFieldId.text = contact.company;
    jobTitleFieldId.text = contact.jobTitle;
    addressFieldId.text = contact.address;
    notesFieldId.text = contact.notes;
    firstNameFieldId.hasError = false;
    lastNameFieldId.hasError = false;
  }

  width: rootId.drawerWidth
  height: rootId.drawerHeight

  Drawer {
    id: drawerId

    width: parent.width
    height: parent.height
    dragMargin: 20

    onOpened: function () {
      firstNameFieldId.forceActiveFocus();
    }

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
          id: editContactDialogId

          Layout.fillWidth: true
          Layout.fillHeight: true
          border.color: Theme.glassBorder
          border.width: 1
          radius: 10
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
          source: editContactDialogId
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

          Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Edit existing contact"
            font.pixelSize: 20
            font.weight: Font.Bold
            color: Theme.textPrimary
          }
          Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Fill in the details below"
            font.pixelSize: 12
            font.weight: Font.Bold
            color: Theme.textSecondary
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
              width: scrollViewId.availableWidth - 10

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
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
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                Text {
                  text: "Personal information"
                  font.pixelSize: 14
                  color: Theme.textPrimary
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: firstNameFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "First name"
                  inputMethodHints: Qt.ImhLatinOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z][A-z]{0,32}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: lastNameFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Last name"
                  inputMethodHints: Qt.ImhLatinOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z][A-z]{0,32}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: emailFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Email"
                  inputMethodHints: Qt.ImhEmailCharactersOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z][A-z0-9._@]{0,64}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: phoneFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Phone"
                  inputMethodHints: Qt.ImhDialableCharactersOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^\+{1}[0-9]{7,15}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
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

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/workInfoIcon.svg"
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

                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                Text {
                  text: "Work information"
                  font.pixelSize: 14
                  color: Theme.textPrimary
                }
                Item {
                  Layout.fillWidth: true
                }
              }

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: companyFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Company"
                  inputMethodHints: Qt.ImhLatinOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z][A-z. ]{0,32}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: jobTitleFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Job title"
                  inputMethodHints: Qt.ImhLatinOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z][A-z ]{0,32}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
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
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                Text {
                  text: "Address information"
                  font.pixelSize: 14
                  color: Theme.textPrimary
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: addressFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Address"
                  inputMethodHints: Qt.ImhLatinOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z][A-z0-9 ,-]{0,128}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
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
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                Text {
                  text: "Notes (optional)"
                  font.pixelSize: 14
                  color: Theme.textPrimary
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                InputField {
                  id: notesFieldId

                  Layout.preferredHeight: 50
                  Layout.preferredWidth: 250
                  placeholderText: "Notes"
                  inputMethodHints: Qt.ImhLatinOnly
                  validator: RegularExpressionValidator {
                    regularExpression: /^[A-z].{0,256}$/
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
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

                  iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteContactIcon.svg"
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
                Text {
                  text: "Mark as Favorite"
                  font.pixelSize: 14
                  color: Theme.textPrimary
                }
                CustomSwitch {
                  id: favoritesSwitchId

                  Layout.preferredWidth: 60
                  Layout.preferredHeight: 30
                  gradient: Gradient {
                    GradientStop {
                      position: 0.0
                      color: favoritesSwitchId.checked ? (favoritesSwitchId.pressed ? Theme.buttonPressedGlassAccentGradientStart : favoritesSwitchId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart) : (favoritesSwitchId.pressed ? Theme.buttonPressedGlassAccentGradientStart : favoritesSwitchId.hovered ? Theme.accentGlassGradientStart : Theme.backgroundGlassGradientStart)
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                    GradientStop {
                      position: 1.0
                      color: favoritesSwitchId.checked ? (favoritesSwitchId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : favoritesSwitchId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd) : (favoritesSwitchId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : favoritesSwitchId.hovered ? Theme.accentGlassGradientEnd : Theme.backgroundGlassGradientEnd)
                      Behavior on color {
                        ColorAnimation {
                          duration: Theme.animationDuration
                        }
                      }
                    }
                  }
                }
                Item {
                  Layout.fillWidth: true
                }
              }

              Divider {
                Layout.fillWidth: true
              }

              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
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
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                Text {
                  text: "Add Tags (optional)"
                  font.pixelSize: 14
                  color: Theme.textPrimary
                }
                Item {
                  Layout.fillWidth: true
                }
              }
              RowLayout {
                spacing: 10
                Layout.fillWidth: true
                Item {
                  Layout.fillWidth: true
                }
                ColumnLayout {
                  Layout.fillWidth: true
                  Flow {
                    spacing: 10
                    Layout.alignment: Qt.AlignHCenter
                    Layout.maximumWidth: 300
                    Repeater {
                      model: rootId.availableTags
                      delegate: ColumnLayout {
                        id: tagLayoutId

                        required property string modelData
                        spacing: 0
                        Layout.fillWidth: true
                        CustomButton {
                          id: tagButtonId

                          property bool isSelected: rootId.tags.indexOf(tagLayoutId.modelData) >= 0

                          Layout.preferredWidth: 80
                          Layout.preferredHeight: 50

                          backgroundGradient: Gradient {
                            GradientStop {
                              position: 0.0
                              color: tagButtonId.isSelected ? Theme.buttonPressedGlassAccentGradientStart : tagButtonId.hovered ? Theme.accentGlassGradientStart : Theme.backgroundGlassGradientStart
                              Behavior on color {
                                ColorAnimation {
                                  duration: Theme.animationDuration
                                }
                              }
                            }
                            GradientStop {
                              position: 1.0
                              color: tagButtonId.isSelected ? Theme.buttonPressedGlassAccentGradientEnd : tagButtonId.hovered ? Theme.accentGlassGradientEnd : Theme.backgroundGlassGradientEnd
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

                          onClicked: function (): void {
                            rootId.tags = rootId.tags.indexOf(tagLayoutId.modelData) >= 0 ? rootId.tags.filter(t => t !== tagLayoutId.modelData) : rootId.tags.concat([tagLayoutId.modelData]);
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
                Item {
                  Layout.fillWidth: true
                }
              }
            }

            ScrollBar.vertical: ScrollBar {
              policy: ScrollBar.AlwaysOn
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
            Item {
              Layout.fillWidth: true
            }
            Text {
              text: "* First name and Last name required"
              font.pixelSize: 12
              color: Theme.textSecondary
            }
            Item {
              Layout.fillWidth: true
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
          id: editContactDialogIdButtonId

          Layout.preferredWidth: 100
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0

          contentItem: Text {
            text: "Edit done"
            color: Theme.textPrimary
            font.pointSize: 12
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: editContactDialogIdButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : editContactDialogIdButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: editContactDialogIdButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : editContactDialogIdButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            let isOk = true;
            if (firstNameFieldId.text.trim() === "") {
              isOk = false;
              firstNameFieldId.hasError = true;
            }
            if (lastNameFieldId.text.trim() === "") {
              isOk = false;
              lastNameFieldId.hasError = true;
            }
            if (isOk) {
              rootId.contactManager.updateContactFull(rootId.proxyModel.mapToSourceIndex(rootId.index), firstNameFieldId.text.trim(), lastNameFieldId.text.trim(), emailFieldId.text.trim(), phoneFieldId.text.trim(), companyFieldId.text.trim(), jobTitleFieldId.text.trim(), addressFieldId.text.trim(), notesFieldId.text.trim(), favoritesSwitchId.checked, rootId.tags);
              drawerId.close();
            }
          }
        }
      }
    }
  }
}
