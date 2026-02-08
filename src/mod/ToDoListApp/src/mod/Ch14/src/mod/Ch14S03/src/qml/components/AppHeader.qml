pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  height: 120

  // Properties that will be bound from parent
  required property color mBackgroundColor
  required property color mTextColor
  required property color mCardColor

  required property color mCardHoveredColor

  required property color mAttentionColor

  required property color mButtonBorderColor
  required property color mButtonColor
  required property color mButtonEnabledColor
  required property color mButtonHoveredColor
  required property color mButtonHoveredEnabledColor
  required property color mButtonPressedColor

  required property color mButtonThemeSwitchColor
  required property color mButtonThemeSwitchEnabledColor
  required property color mButtonThemeSwitchHoveredColor
  required property color mButtonThemeSwitchHoveredEnabledColor
  required property color mButtonThemeSwitchPressedColor

  required property color mTaskDoneIconColor
  required property color mTaskNotDoneIconColor

  required property int mFontPixelSize
  required property int mSpacing
  required property int mRadius
  required property int mAnimationDuration
  required property bool mDarkMode

  signal toggleDarkMode

  Rectangle {
    anchors.fill: parent
    color: root.mBackgroundColor

    RowLayout {
      anchors.fill: parent
      anchors.leftMargin: 10
      anchors.rightMargin: 10
      spacing: root.mSpacing

      // App icon
      Button {
        background: Rectangle {
          color: "transparent"
        }
        icon.source: "qrc:/qt/qml/Ch14S03/src/resrc/images/tasks.svg"
        icon.color: "transparent"
      }

      // App title and subtitle
      Column {
        Layout.fillWidth: true
        spacing: root.mSpacing

        Text {
          text: "My Tasks"
          font.pixelSize: root.mFontPixelSize * 2
          font.weight: Font.Bold
          color: root.mTextColor
        }

        Text {
          text: qsTr("The list of tasks")
          font.pixelSize: root.mFontPixelSize
          color: root.mTextColor
          opacity: 0.5
        }
      }

      // Dark mode toggle
      Button {
        id: themeToggle

        background: Rectangle {
          color: themeToggle.pressed ? root.mButtonThemeSwitchPressedColor : (themeToggleHoverHandler.hovered && themeToggle.enabled ? root.mButtonThemeSwitchHoveredEnabledColor : root.mButtonThemeSwitchColor)
          radius: root.mRadius * 2
          border.color: root.mButtonBorderColor
          border.width: 1
          Behavior on color {
            ColorAnimation {
              duration: root.mAnimationDuration * 2
            }
          }
        }

        icon.source: "qrc:/qt/qml/Ch14S03/src/resrc/images/sun.svg"
        icon.color: "transparent"

        // Emit the signal when button is clicked
        onClicked: root.toggleDarkMode()

        HoverHandler {
          id: themeToggleHoverHandler

          cursorShape: Qt.PointingHandCursor
        }
      }
    }
    // AppHeader and Content separator line
    Rectangle {
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom
      height: 1
      color: root.mButtonBorderColor
    }
  }
}
