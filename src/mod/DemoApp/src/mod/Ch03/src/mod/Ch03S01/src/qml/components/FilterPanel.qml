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

  signal favoritesToggled(bool enabled)
  signal sortChanged(string sortBy, bool ascneding)
  signal tagToggled(string tag)

  Rectangle {
    id: filterPanel
    border.color: root.theme.glassBorder
    border.width: 1
    radius: 10
    anchors.fill: parent
    visible: false
    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop {
        position: 0.0
        color: filterPanelHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientStart : root.theme.backgroundGlassCardGradientStart
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
      GradientStop {
        position: 1.0
        color: filterPanelHoverHandler.hovered ? root.theme.backgroundGlassCardHoverGradientEnd : root.theme.backgroundGlassCardGradientEnd
        Behavior on color {
          ColorAnimation {
            duration: root.theme.animationDuration
          }
        }
      }
    }
  }
  MultiEffect {
    source: filterPanel
    anchors.fill: filterPanel
    blurEnabled: true
    blur: 0.2
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    // Filters Header
    Text {
      Layout.alignment: Qt.AlignHCenter
      text: "Filters"
      font.pixelSize: 20
      font.weight: Font.Bold
      color: root.theme.textPrimary
    }

    // Favorites only toggle
    RowLayout {
      spacing: 10
      Layout.fillWidth: true

      Text {
        text: "⭐"
        font.pixelSize: 14
        color: root.theme.textPrimary
      }

      Text {
        text: "Favorites Only"
        font.pixelSize: 14
        color: root.theme.textPrimary
        Layout.fillWidth: true
      }

      CustomSwitch {
        id: favoritesSwitch
        Layout.preferredWidth: 60
        Layout.preferredHeight: 30
        theme: root.theme
        onToggled: function () {
          root.favoritesOnly = !root.favoritesOnly;
          root.favoritesToggled(root.favoritesOnly);
          ApplicationWindow.window.title = "favoritesOnly: " + root.favoritesOnly;
        }
        gradient: Gradient {
          GradientStop {
            position: 0.0
            color: favoritesSwitch.checked ? (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientStart : favoritesSwitch.switchHoverHandler.hovered ? root.theme.backgroundGlassGradientStart : root.theme.accentGlassGradientStart) : (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientStart : favoritesSwitch.switchHoverHandler.hovered ? root.theme.accentGlassGradientStart : root.theme.backgroundGlassGradientStart)
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
          GradientStop {
            position: 1.0
            color: favoritesSwitch.checked ? (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : favoritesSwitch.switchHoverHandler.hovered ? root.theme.backgroundGlassGradientEnd : root.theme.accentGlassGradientEnd) : (favoritesSwitch.pressed ? root.theme.buttonPressedGlassAccentGradientEnd : favoritesSwitch.switchHoverHandler.hovered ? root.theme.accentGlassGradientEnd : root.theme.backgroundGlassGradientEnd)
            Behavior on color {
              ColorAnimation {
                duration: root.theme.animationDuration
              }
            }
          }
        }
      }
    }

    // Divider
    Divider {
      theme: root.theme
    }

    // Sort By Section
    ColumnLayout {
      spacing: 10
      Layout.fillWidth: true

      Text {
        Layout.fillWidth: true
        text: "Sort By"
        font.pixelSize: 16
        color: root.theme.textPrimary
        font.weight: Font.Bold
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
      }

      Text {
        Layout.fillWidth: true
        text: "Name"
        font.pixelSize: 14
        color: root.theme.textPrimary
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
          id: ascendingNameSortButton
          theme: root.theme
          Layout.preferredWidth: 70
          Layout.preferredHeight: 50

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: ascendingNameSortButton.checked ? root.theme.buttonPressedGlassAccentGradientStart : ascendingNameSortButton.hovered ? root.theme.accentGlassGradientStart : root.theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: ascendingNameSortButton.checked ? root.theme.buttonPressedGlassAccentGradientEnd : ascendingNameSortButton.hovered ? root.theme.accentGlassGradientEnd : root.theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
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
            color: root.theme.textPrimary
          }

          checked: root.sortBy === "name" && root.sortAscending
          checkable: true

          onClicked: function () {
            root.sortBy = "name";
            root.sortAscending = true;
            root.sortChanged(root.sortBy, root.sortAscending);
          }
        }
        CustomButton {
          id: descendingNameSortButton
          theme: root.theme
          Layout.preferredWidth: 70
          Layout.preferredHeight: 50

          backgroundGradient: Gradient {
            GradientStop {
              position: 0.0
              color: descendingNameSortButton.checked ? root.theme.buttonPressedGlassAccentGradientStart : descendingNameSortButton.hovered ? root.theme.accentGlassGradientStart : root.theme.backgroundGlassGradientStart
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
                }
              }
            }
            GradientStop {
              position: 1.0
              color: descendingNameSortButton.checked ? root.theme.buttonPressedGlassAccentGradientEnd : descendingNameSortButton.hovered ? root.theme.accentGlassGradientEnd : root.theme.backgroundGlassGradientEnd
              Behavior on color {
                ColorAnimation {
                  duration: root.theme.animationDuration
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
            color: root.theme.textPrimary
          }

          checked: root.sortBy === "name" && !root.sortAscending
          checkable: true

          onClicked: function () {
            root.sortBy = "name";
            root.sortAscending = false;
            root.sortChanged(root.sortBy, root.sortAscending);
          }
        }
        Item {
          Layout.fillWidth: true
        }
      }
    }

    // Divider
    Divider {
      theme: root.theme
      Layout.fillWidth: true
    }

    // Filter by Tags Section
    ColumnLayout {
      id: filterByTagsLayoutId
      spacing: 10
      Layout.fillWidth: true

      Text {
        Layout.fillWidth: true
        text: "Filter by Tags"
        font.pixelSize: 16
        font.weight: Font.Bold
        color: root.theme.textPrimary
        verticalAlignment: Qt.AlignVCenter
        horizontalAlignment: Qt.AlignHCenter
      }

      Flow {
        Layout.fillWidth: true

        spacing: 10

        Repeater {
          model: ["client", "Alumni", "lead", "friends", "vendor", "prospect", "partner", "work", "family", "colleague"]
          delegate: ColumnLayout {
            id: tagLayout
            required property string modelData
            spacing: 0
            Layout.fillWidth: true
            CustomButton {
              id: tagButton
              property string modelData: tagLayout.modelData
              property bool isSelected: root.selectedTags.indexOf(modelData) >= 0

              theme: root.theme
              Layout.preferredWidth: 80
              Layout.preferredHeight: 50

              backgroundGradient: Gradient {
                GradientStop {
                  position: 0.0
                  color: tagButton.isSelected ? root.theme.buttonPressedGlassAccentGradientStart : tagButton.hovered ? root.theme.accentGlassGradientStart : root.theme.backgroundGlassGradientStart
                  Behavior on color {
                    ColorAnimation {
                      duration: root.theme.animationDuration
                    }
                  }
                }
                GradientStop {
                  position: 1.0
                  color: tagButton.isSelected ? root.theme.buttonPressedGlassAccentGradientEnd : tagButton.hovered ? root.theme.accentGlassGradientEnd : root.theme.backgroundGlassGradientEnd
                  Behavior on color {
                    ColorAnimation {
                      duration: root.theme.animationDuration
                    }
                  }
                }
              }

              topPadding: 0
              bottomPadding: 0
              leftPadding: 0
              rightPadding: 0

              contentItem: Text {
                text: tagButton.modelData
                font.pixelSize: 14
                font.weight: Font.Bold
                color: root.theme.textPrimary
                verticalAlignment: Qt.AlignVCenter
                horizontalAlignment: Qt.AlignHCenter
              }

              onClicked: function () {
                // Create a shallow copy of the selectedTags array
                let tags = root.selectedTags.slice();
                let idx = tags.indexOf(tagButton.modelData);

                if (idx >= 0) {
                  // If the tag is already selected, remove it
                  // This toggles it OFF
                  tags.splice(idx, 1);
                } else {
                  // If the tag is not selected we add it
                  // This toggles it ON
                  tags.push(tagButton.modelData);
                }
                root.selectedTags = tags;
                root.tagToggled(tagButton.modelData);
              }
            }

            // Divider
            Divider {
              theme: root.theme
              Layout.fillWidth: true
            }
          }
        }
      }
    }

    Item {
      Layout.fillHeight: true
    }
  }

  HoverHandler {
    id: filterPanelHoverHandler
    cursorShape: Qt.PointingHandCursor
  }
}
