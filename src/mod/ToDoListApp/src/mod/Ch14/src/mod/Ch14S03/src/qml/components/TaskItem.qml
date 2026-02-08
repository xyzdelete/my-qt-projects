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
  required property bool mTaskDone
  required property bool mDarkMode
  required property string mTaskTitle

  signal toggleDone
  signal deleteTask

  Rectangle {
    id: taskItemBackground

    anchors.fill: parent
    color: "transparent"

    Rectangle {
      id: itemBackground

      anchors.fill: parent
      anchors.margins: root.mMargins
      color: itemBackgroundHoverHandler.hovered ? root.mCardHoveredColor : root.mCardColor
      radius: root.mRadius
      border.color: itemBackgroundHoverHandler.hovered ? root.mAttentionColor : root.mButtonBorderColor
      border.width: 1
      opacity: root.mTaskDone ? 0.5 : 1.0

      Behavior on opacity {
        NumberAnimation {
          duration: root.mAnimationDuration
        }
      }

      RowLayout {
        anchors.fill: parent
        anchors.margins: root.mMargins
        spacing: root.mSpacing

        // Checkbox
        Button {
          id: checkbox

          icon.source: root.mTaskDone ? "qrc:/qt/qml/Ch14S03/src/resrc/images/checkmark.svg" : "qrc:/qt/qml/Ch14S03/src/resrc/images/inprogress.svg"
          icon.width: 16
          icon.height: 16
          icon.color: root.mTaskDone ? root.mTaskDoneIconColor : root.mTaskNotDoneIconColor
          background: Rectangle {
            color: "transparent"
          }

          Behavior on icon.color {
            ColorAnimation {
              duration: root.mAnimationDuration
            }
          }

          onClicked: function () {
            root.toggleDone();
          }

          HoverHandler {
            id: checkboxHoverHandler

            cursorShape: Qt.PointingHandCursor
          }
        }

        // Task text
        Text {
          id: taskText

          Layout.fillWidth: true

          text: root.mTaskTitle
          color: root.mTaskDone ? Qt.lighter(root.mTextColor, 2.0) : root.mTextColor
          font.pixelSize: root.mFontPixelSize
          font.strikeout: root.mTaskDone
          wrapMode: Text.WordWrap
          scale: root.mTaskDone ? 0.95 : 1

          Behavior on scale {
            NumberAnimation {
              duration: root.mAnimationDuration
            }
          }

          Behavior on color {
            ColorAnimation {
              duration: root.mAnimationDuration
            }
          }

          MouseArea {
            id: taskTextMouseArea

            anchors.fill: parent
            onClicked: function () {
              root.toggleDone();
            }

            cursorShape: Qt.PointingHandCursor
          }
        }

        // Delete button
        Button {
          id: deleteButton

          Behavior on opacity {
            NumberAnimation {
              duration: root.mAnimationDuration
            }
          }

          background: Rectangle {
            color: deleteButton.pressed ? root.mButtonPressedColor : (deleteButtonHoverHandler.hovered && deleteButton.enabled ? root.mButtonHoveredEnabledColor : root.mButtonColor)
            border.color: root.mButtonBorderColor
            radius: root.mRadius
          }

          contentItem: Text {
            anchors.fill: parent
            text: "Delete"
            font.pixelSize: root.mFontPixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          onClicked: function () {
            root.deleteTask();
          }

          HoverHandler {
            id: deleteButtonHoverHandler

            cursorShape: Qt.PointingHandCursor
          }
        }
      }

      HoverHandler {
        id: itemBackgroundHoverHandler

        cursorShape: Qt.PointingHandCursor
      }
    }
  }
}
