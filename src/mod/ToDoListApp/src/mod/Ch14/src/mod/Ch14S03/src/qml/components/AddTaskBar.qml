pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  height: 80

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
  required property bool mDarkMode

  signal taskAdded(string taskText)

  Rectangle {
    id: background

    anchors.fill: parent
    color: root.mCardColor
    radius: root.mRadius
    border.color: root.mButtonBorderColor
    border.width: 1

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

        // Add icon
        Button {
          Layout.alignment: Qt.AlignVCenter
          background: Rectangle {
            color: "transparent"
          }
          icon.source: "qrc:/qt/qml/Ch14S03/src/resrc/images/plus.svg"
          icon.color: '#2dad93'
        }

        // Text input
        TextField {
          id: taskInput

          Layout.fillWidth: true

          placeholderText: qsTr("Add a new task...")
          placeholderTextColor: root.mTextColor

          color: root.mTextColor
          font.pixelSize: root.mFontPixelSize
          selectByMouse: true

          background: Rectangle {
            color: "transparent"
            border.color: "transparent"
          }

          Keys.onReturnPressed: function () {
            root.addTask();
          }
          Keys.onEnterPressed: function () {
            root.addTask();
          }
        }

        // Add button
        Button {
          id: addButton

          contentItem: Text {
            anchors.fill: parent
            text: "Add"
            font.pixelSize: root.mFontPixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
          }

          enabled: taskInput.text.trim().length > 0
          opacity: enabled ? 1.0 : 0.5
          background: Rectangle {
            color: addButton.pressed ? root.mButtonPressedColor : (addButtonHoverHandler.hovered && addButton.enabled ? root.mButtonHoveredEnabledColor : root.mButtonColor)
            border.color: root.mButtonBorderColor
            radius: root.mRadius
          }

          onClicked: function () {
            root.addTask();
          }

          HoverHandler {
            id: addButtonHoverHandler

            cursorShape: Qt.PointingHandCursor
          }
        }
      }
    }
  }
  function addTask() {
    if (taskInput.text.trim().length > 0) {
      root.taskAdded(taskInput.text.trim());
      taskInput.text = "";
      taskInput.focus = false;
    }
  }
}
