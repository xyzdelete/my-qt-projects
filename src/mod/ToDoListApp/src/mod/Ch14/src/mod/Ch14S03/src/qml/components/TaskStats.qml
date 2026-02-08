pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  height: 100

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
  required property int mMargins
  required property int mRadius
  required property int mAnimationDuration
  required property int mTotalTasks
  required property int mCompletedTasks
  required property int mRemainingTasks
  required property bool mHasCompleted
  required property bool mDarkMode

  signal clearCompleted

  Rectangle {
    anchors.fill: parent
    color: root.mCardColor
    radius: root.mRadius
    border.color: root.mButtonBorderColor
    border.width: 1

    RowLayout {
      anchors.fill: parent
      anchors.margins: root.mMargins
      spacing: root.mSpacing

      // Statistics text
      Column {
        Layout.fillWidth: true
        spacing: root.mSpacing

        Text {
          text: root.mTotalTasks === 1 ? qsTr("%1 task:").arg(root.mTotalTasks) : qsTr("%1 tasks:").arg(root.mTotalTasks)
          color: root.mTextColor
          font.pixelSize: root.mFontPixelSize
          font.weight: Font.Medium
        }
        Text {
          text: root.mCompletedTasks > 0 ? qsTr("%1 completed\n%2 remaining").arg(root.mCompletedTasks).arg(root.mRemainingTasks) : qsTr("0 completed")
          color: root.mTextColor
          font.pixelSize: root.mFontPixelSize
        }
      }
      Button {
        id: clearButton

        text: qsTr("Clear Completed")
        enabled: root.mHasCompleted

        Behavior on enabled {
          NumberAnimation {
            duration: root.mAnimationDuration
          }
        }

        opacity: root.mHasCompleted ? 1.0 : 0.5

        Behavior on opacity {
          NumberAnimation {
            duration: root.mAnimationDuration
          }
        }

        background: Rectangle {
          color: clearButton.pressed ? root.mButtonPressedColor : (clearButtonHoverHandler.hovered && clearButton.enabled ? root.mButtonHoveredEnabledColor : root.mButtonColor)
          border.color: root.mButtonBorderColor
          border.width: 1
          radius: root.mRadius
        }

        contentItem: Text {
          anchors.fill: parent
          text: "Clear Completed"
          font.pixelSize: root.mFontPixelSize
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter
        }

        onClicked: function () {
          root.clearCompleted();
        }

        HoverHandler {
          id: clearButtonHoverHandler

          cursorShape: Qt.PointingHandCursor
        }
      }
    }
  }
}
