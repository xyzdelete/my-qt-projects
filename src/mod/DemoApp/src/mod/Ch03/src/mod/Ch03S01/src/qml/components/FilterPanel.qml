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

  readonly property list<string> selectedTags: proxyModel.selectedTags
  readonly property list<string> noTags: []
  readonly property list<string> availableTags: ["client", "alumni", "lead", "friends", "vendor", "prospect", "partner", "work", "family", "colleague"]

  property alias drawer: drawerId
  property alias edge: drawerId.edge
  property alias interactive: drawerId.interactive

  readonly property ContactFilterProxyModel proxyModel: contactManager.proxyModel

  function resetState(): void {
    rootId.proxyModel.favoritesOnly = false;
    rootId.proxyModel.sortAscending = true;
    rootId.proxyModel.selectedTags = rootId.noTags;
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
          id: filterPanelId

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
          source: filterPanelId
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

          // Filters Header
          Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Filters"
            font.pixelSize: 20
            font.weight: Font.Bold
            color: Theme.textPrimary
          }

          // Favorites only toggle
          RowLayout {
            spacing: 10
            // Layout.fillWidth: true
            Item {
              Layout.fillWidth: true
            }

            Image {
              Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
              source: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/favoriteStarIcon.svg"
              sourceSize: Qt.size(10, 10)
            }

            Text {
              text: "Favorites Only"
              font.pixelSize: 14
              color: Theme.textPrimary
            }

            CustomSwitch {
              id: favoritesSwitchId

              Layout.preferredWidth: 60
              Layout.preferredHeight: 30
              checked: rootId.proxyModel.favoritesOnly
              onToggled: function () {
                rootId.proxyModel.favoritesOnly = favoritesSwitchId.checked;
              }
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

          // Divider
          Divider {}

          // Sort by Section
          ColumnLayout {
            spacing: 10
            Layout.fillWidth: true

            Text {
              Layout.fillWidth: true
              text: "Sort by"
              font.pixelSize: 16
              color: Theme.textPrimary
              font.weight: Font.Bold
              horizontalAlignment: Qt.AlignHCenter
              verticalAlignment: Qt.AlignVCenter
            }

            Text {
              Layout.fillWidth: true
              text: "Full name"
              font.pixelSize: 14
              color: Theme.textPrimary
              horizontalAlignment: Qt.AlignHCenter
              verticalAlignment: Qt.AlignVCenter
            }

            RowLayout {
              spacing: 10
              Layout.fillWidth: true
              Item {
                Layout.fillWidth: true
              }
              CustomButton {
                id: ascendingNameSortButtonId

                Layout.preferredWidth: 70
                Layout.preferredHeight: 50

                backgroundGradient: Gradient {
                  GradientStop {
                    position: 0.0
                    color: ascendingNameSortButtonId.checked ? Theme.buttonPressedGlassAccentGradientStart : ascendingNameSortButtonId.hovered ? Theme.accentGlassGradientStart : Theme.backgroundGlassGradientStart
                    Behavior on color {
                      ColorAnimation {
                        duration: Theme.animationDuration
                      }
                    }
                  }
                  GradientStop {
                    position: 1.0
                    color: ascendingNameSortButtonId.checked ? Theme.buttonPressedGlassAccentGradientEnd : ascendingNameSortButtonId.hovered ? Theme.accentGlassGradientEnd : Theme.backgroundGlassGradientEnd
                    Behavior on color {
                      ColorAnimation {
                        duration: Theme.animationDuration
                      }
                    }
                  }
                }

                leftPadding: 0
                rightPadding: 0
                topPadding: 0
                bottomPadding: 0

                contentItem: Text {
                  text: "⬆️ A-Z"
                  font.pixelSize: 14
                  horizontalAlignment: Qt.AlignHCenter
                  verticalAlignment: Qt.AlignVCenter
                  font.weight: Font.Bold
                  color: Theme.textPrimary
                }

                checkable: true
                checked: rootId.proxyModel.sortAscending

                onClicked: function () {
                  rootId.proxyModel.sortAscending = !rootId.proxyModel.sortAscending;
                }
              }
              CustomButton {
                id: descendingNameSortButtonId

                Layout.preferredWidth: 70
                Layout.preferredHeight: 50

                backgroundGradient: Gradient {
                  GradientStop {
                    position: 0.0
                    color: descendingNameSortButtonId.checked ? Theme.buttonPressedGlassAccentGradientStart : descendingNameSortButtonId.hovered ? Theme.accentGlassGradientStart : Theme.backgroundGlassGradientStart
                    Behavior on color {
                      ColorAnimation {
                        duration: Theme.animationDuration
                      }
                    }
                  }
                  GradientStop {
                    position: 1.0
                    color: descendingNameSortButtonId.checked ? Theme.buttonPressedGlassAccentGradientEnd : descendingNameSortButtonId.hovered ? Theme.accentGlassGradientEnd : Theme.backgroundGlassGradientEnd
                    Behavior on color {
                      ColorAnimation {
                        duration: Theme.animationDuration
                      }
                    }
                  }
                }

                leftPadding: 0
                rightPadding: 0
                topPadding: 0
                bottomPadding: 0

                contentItem: Text {
                  text: "⬇️ Z-A"
                  font.pixelSize: 14
                  horizontalAlignment: Qt.AlignHCenter
                  verticalAlignment: Qt.AlignVCenter
                  font.weight: Font.Bold
                  color: Theme.textPrimary
                }

                checkable: true
                checked: !rootId.proxyModel.sortAscending

                onClicked: function () {
                  rootId.proxyModel.sortAscending = !rootId.proxyModel.sortAscending;
                }
              }
              Item {
                Layout.fillWidth: true
              }
            }
          }

          // Divider
          Divider {
            Layout.fillWidth: true
          }

          // Filter by tags Section
          ColumnLayout {
            id: filterByTagsLayoutId

            spacing: 10
            Layout.fillWidth: true

            Text {
              Layout.fillWidth: true
              text: "Filter by tags"
              font.pixelSize: 16
              font.weight: Font.Bold
              color: Theme.textPrimary
              verticalAlignment: Qt.AlignVCenter
              horizontalAlignment: Qt.AlignHCenter
            }

            ScrollView {
              id: scrollViewId

              Layout.fillWidth: true
              Layout.fillHeight: true
              contentWidth: availableWidth
              ColumnLayout {
                anchors.fill: parent
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

                        property bool isSelected: rootId.selectedTags.indexOf(tagLayoutId.modelData) >= 0

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
                          rootId.proxyModel.selectedTags = rootId.selectedTags.indexOf(tagLayoutId.modelData) >= 0 ? rootId.selectedTags.filter(t => t !== tagLayoutId.modelData) : rootId.selectedTags.concat([tagLayoutId.modelData]);
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
          }

          Item {
            Layout.fillHeight: true
          }
        }
      }
      RowLayout {
        Layout.alignment: Qt.AlignHCenter
        CustomButton {
          id: menuCloseButtonId

          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter
          iconSource: "qrc:/qt/qml/Ch03S01/src/resrc/assets/icons/menuCloseIcon.svg"

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: menuCloseButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : menuCloseButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: menuCloseButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : menuCloseButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
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
          id: resetButtonId

          Layout.preferredWidth: 60
          Layout.preferredHeight: 50
          Layout.alignment: Qt.AlignHCenter

          topPadding: 0
          bottomPadding: 0
          leftPadding: 0
          rightPadding: 0

          contentItem: Text {
            text: "Reset"
            color: Theme.textPrimary
            font.pointSize: 12
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
          }

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: resetButtonId.pressed ? Theme.buttonPressedGlassAccentGradientStart : resetButtonId.hovered ? Theme.backgroundGlassGradientStart : Theme.accentGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: resetButtonId.pressed ? Theme.buttonPressedGlassAccentGradientEnd : resetButtonId.hovered ? Theme.backgroundGlassGradientEnd : Theme.accentGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDuration
                }
              }
            }
          }

          onClicked: function () {
            rootId.resetState();
            drawerId.close();
          }
        }
      }
    }
  }
}
