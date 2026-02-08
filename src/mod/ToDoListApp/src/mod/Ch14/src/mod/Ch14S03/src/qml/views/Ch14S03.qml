pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root

  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  // Theme properties
  readonly property color mDarkModeMainColor: "#414864"
  readonly property color mLigthModeMainColor: "#e9edf1"

  readonly property color mBackgroundColor: mDarkMode ? root.mDarkModeMainColor : root.mLigthModeMainColor
  readonly property color mTextColor: mDarkMode ? Qt.lighter(root.mDarkModeMainColor, 3.0) : Qt.darker(root.mLigthModeMainColor, 3.0)

  readonly property color mCardColor: mDarkMode ? Qt.darker(root.mDarkModeMainColor, 1.2) : Qt.lighter(root.mLigthModeMainColor, 1.2)
  readonly property color mCardHoveredColor: mDarkMode ? Qt.darker(root.mCardColor, 1.20) : Qt.lighter(root.mAttentionColor, 2.5)

  readonly property color mAttentionColor: "#2dad93"

  readonly property color mButtonBorderColor: root.mDarkMode ? Qt.darker(root.mDarkModeMainColor, 2.0) : Qt.darker(root.mLigthModeMainColor, 2.0)
  readonly property color mButtonColor: Qt.darker(root.mLigthModeMainColor, 1.1)
  readonly property color mButtonEnabledColor: root.mButtonColor
  readonly property color mButtonHoveredColor: Qt.darker(root.mButtonPressedColor, 1.20)
  readonly property color mButtonHoveredEnabledColor: root.mButtonHoveredColor
  readonly property color mButtonPressedColor: root.mAttentionColor

  readonly property color mButtonThemeSwitchColor: root.mDarkMode ? Qt.darker(root.mDarkModeMainColor, 1.20) : Qt.lighter(root.mLigthModeMainColor, 1.20)
  readonly property color mButtonThemeSwitchEnabledColor: root.mButtonThemeSwitchColor
  readonly property color mButtonThemeSwitchHoveredColor: root.mButtonThemeSwitchPressedColor
  readonly property color mButtonThemeSwitchHoveredEnabledColor: root.mButtonThemeSwitchHoveredColor
  readonly property color mButtonThemeSwitchPressedColor: root.mDarkMode ? Qt.lighter(root.mLigthModeMainColor, 1.20) : Qt.darker(root.mDarkModeMainColor, 1.20)

  readonly property color mTaskDoneIconColor: root.mAttentionColor
  readonly property color mTaskNotDoneIconColor: '#4682d1'

  readonly property color mTasksListRectColor: mDarkMode ? Qt.darker(root.mDarkModeMainColor, 1.5) : Qt.darker(root.mLigthModeMainColor, 1.025)

  readonly property int mFontPixelSize: 14
  readonly property int mSpacing: 10
  readonly property int mMargins: 10
  readonly property int mRadius: 10
  readonly property int mAnimationDuration: 250

  property bool mDarkMode: false

  readonly property bool useRESTServerBasedStorage: false
  // isInitializing property needed for REST
  // when useRESTServerBasedStorage is set to true
  // property bool isInitializing: true

  TaskListModel {
    id: taskModel

    useRESTServerBasedStorage: root.useRESTServerBasedStorage

    // LocalStorage
    onStorageInitialized: function () {
      if (!root.useRESTServerBasedStorage) {
        root.mDarkMode = taskModel.loadDarkMode();
      } else {
        taskModel.loadDarkMode();
      }
    }

    // REST
    // onSettingsLoaded: function (darkModeValue) {
    //   print("Dark mode loaded from API:", darkModeValue);
    //   root.mDarkMode = darkModeValue;
    //   root.isInitializing = false;
    // }
  }

  onMDarkModeChanged: function () {
    if (!root.useRESTServerBasedStorage) {
      // LocalStorage
      taskModel.saveDarkMode(root.mDarkMode);
    } else {
      // REST
      if (!root.isInitializing) {
        taskModel.saveDarkMode(root.mDarkMode);
      }
    }
  }

  Component {
    id: headerComponent
    AppHeader {
      id: header

      mBackgroundColor: root.mBackgroundColor
      mTextColor: root.mTextColor

      mCardColor: root.mCardColor
      mCardHoveredColor: root.mCardHoveredColor

      mAttentionColor: root.mAttentionColor

      mButtonBorderColor: root.mButtonBorderColor
      mButtonColor: root.mButtonColor
      mButtonEnabledColor: root.mButtonEnabledColor
      mButtonHoveredColor: root.mButtonHoveredColor
      mButtonHoveredEnabledColor: root.mButtonHoveredEnabledColor
      mButtonPressedColor: root.mButtonPressedColor

      mButtonThemeSwitchColor: root.mButtonThemeSwitchColor
      mButtonThemeSwitchEnabledColor: root.mButtonThemeSwitchEnabledColor
      mButtonThemeSwitchHoveredColor: root.mButtonThemeSwitchHoveredColor
      mButtonThemeSwitchHoveredEnabledColor: root.mButtonThemeSwitchHoveredEnabledColor
      mButtonThemeSwitchPressedColor: root.mButtonThemeSwitchPressedColor

      mTaskDoneIconColor: root.mTaskDoneIconColor
      mTaskNotDoneIconColor: root.mTaskNotDoneIconColor

      mFontPixelSize: root.mFontPixelSize
      mSpacing: root.mSpacing
      mRadius: root.mRadius
      mAnimationDuration: root.mAnimationDuration
      mDarkMode: root.mDarkMode

      onToggleDarkMode: function () {
        root.mDarkMode = !root.mDarkMode;
      }
    }
  }

  // Background
  Rectangle {
    anchors.fill: parent
    color: root.mBackgroundColor
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: root.mMargins
    spacing: root.mSpacing

    AddTaskBar {
      id: addTaskBar

      Layout.fillWidth: true

      mBackgroundColor: root.mBackgroundColor
      mTextColor: root.mTextColor

      mCardColor: root.mCardColor
      mCardHoveredColor: root.mCardHoveredColor

      mAttentionColor: root.mAttentionColor

      mButtonBorderColor: root.mButtonBorderColor
      mButtonColor: root.mButtonColor
      mButtonEnabledColor: root.mButtonEnabledColor
      mButtonHoveredColor: root.mButtonHoveredColor
      mButtonHoveredEnabledColor: root.mButtonHoveredEnabledColor
      mButtonPressedColor: root.mButtonPressedColor

      mButtonThemeSwitchColor: root.mButtonThemeSwitchColor
      mButtonThemeSwitchEnabledColor: root.mButtonThemeSwitchEnabledColor
      mButtonThemeSwitchHoveredColor: root.mButtonThemeSwitchHoveredColor
      mButtonThemeSwitchHoveredEnabledColor: root.mButtonThemeSwitchHoveredEnabledColor
      mButtonThemeSwitchPressedColor: root.mButtonThemeSwitchPressedColor

      mTaskDoneIconColor: root.mTaskDoneIconColor
      mTaskNotDoneIconColor: root.mTaskNotDoneIconColor

      mFontPixelSize: root.mFontPixelSize
      mSpacing: root.mSpacing
      mMargins: root.mMargins
      mRadius: root.mRadius
      mDarkMode: root.mDarkMode

      onTaskAdded: function (taskText) {
        taskModel.addTask(taskText);
      }
    }

    // Tasks list
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true
      color: root.mTasksListRectColor
      radius: root.mRadius
      border.width: 1
      border.color: root.mButtonBorderColor

      ScrollView {
        anchors.fill: parent
        clip: true

        ListView {
          id: taskListView

          model: taskModel.model

          displaced: Transition {
            NumberAnimation {
              properties: "x,y,opacity"
              duration: root.mAnimationDuration
            }
          }

          add: Transition {
            NumberAnimation {
              properties: "x,y,opacity"
              duration: root.mAnimationDuration
            }
          }

          remove: Transition {
            NumberAnimation {
              properties: "opacity"
              duration: root.mAnimationDuration
              to: 0
            }
          }

          delegate: TaskItem {
            required property int index
            required property string title
            required property bool completed

            width: taskListView.width

            mBackgroundColor: root.mBackgroundColor
            mTextColor: root.mTextColor

            mCardColor: root.mCardColor
            mCardHoveredColor: root.mCardHoveredColor

            mAttentionColor: root.mAttentionColor

            mButtonBorderColor: root.mButtonBorderColor
            mButtonColor: root.mButtonColor
            mButtonEnabledColor: root.mButtonEnabledColor
            mButtonHoveredColor: root.mButtonHoveredColor
            mButtonHoveredEnabledColor: root.mButtonHoveredEnabledColor
            mButtonPressedColor: root.mButtonPressedColor

            mButtonThemeSwitchColor: root.mButtonThemeSwitchColor
            mButtonThemeSwitchEnabledColor: root.mButtonThemeSwitchEnabledColor
            mButtonThemeSwitchHoveredColor: root.mButtonThemeSwitchHoveredColor
            mButtonThemeSwitchHoveredEnabledColor: root.mButtonThemeSwitchHoveredEnabledColor
            mButtonThemeSwitchPressedColor: root.mButtonThemeSwitchPressedColor

            mTaskDoneIconColor: root.mTaskDoneIconColor
            mTaskNotDoneIconColor: root.mTaskNotDoneIconColor

            mFontPixelSize: root.mFontPixelSize
            mSpacing: root.mSpacing
            mMargins: root.mMargins
            mRadius: root.mRadius
            mAnimationDuration: root.mAnimationDuration
            mTaskDone: completed
            mDarkMode: root.mDarkMode
            mTaskTitle: title

            onToggleDone: function () {
              taskModel.toggleTask(index);
            }

            onDeleteTask: function () {
              taskModel.deleteTask(index);
            }
          }

          // Empty state
          Rectangle {
            anchors.centerIn: parent
            width: parent.width - 40
            height: 120
            color: "transparent"
            visible: taskListView.count === 0

            Column {
              anchors.centerIn: parent
              spacing: root.mSpacing

              Button {
                anchors.horizontalCenter: parent.horizontalCenter
                background: Rectangle {
                  color: "transparent"
                }
                icon.source: "qrc:/qt/qml/Ch14S03/src/resrc/images/tasks.svg"
                icon.color: "transparent"

                SequentialAnimation on y {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0
                    to: -5
                    duration: root.mAnimationDuration * 4
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: -5
                    to: 0
                    duration: root.mAnimationDuration * 4
                    easing.type: Easing.InOutSine
                  }
                }
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("No tasks")
                color: root.mTextColor
                font.pixelSize: 24
                font.weight: Font.Medium
                opacity: 0.5

                SequentialAnimation on opacity {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0.4
                    to: 1.0
                    duration: root.mAnimationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: 1.0
                    to: 0.4
                    duration: root.mAnimationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                }
              }

              Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add a task above to get started")
                color: root.mTextColor
                font.pixelSize: 16
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                opacity: 0.5

                SequentialAnimation on opacity {
                  running: taskListView.count === 0
                  loops: Animation.Infinite
                  NumberAnimation {
                    from: 0.4
                    to: 1
                    duration: root.mAnimationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                  NumberAnimation {
                    from: 1
                    to: 0.4
                    duration: root.mAnimationDuration * 8
                    easing.type: Easing.InOutSine
                  }
                }
              }
            }
          }
        }
      }
    }

    // Task statistics
    TaskStats {
      id: taskStatsId

      Layout.fillWidth: true

      mBackgroundColor: root.mBackgroundColor
      mTextColor: root.mTextColor

      mCardColor: root.mCardColor
      mCardHoveredColor: root.mCardHoveredColor

      mAttentionColor: root.mAttentionColor

      mButtonBorderColor: root.mButtonBorderColor
      mButtonColor: root.mButtonColor
      mButtonEnabledColor: root.mButtonEnabledColor
      mButtonHoveredColor: root.mButtonHoveredColor
      mButtonHoveredEnabledColor: root.mButtonHoveredEnabledColor
      mButtonPressedColor: root.mButtonPressedColor

      mButtonThemeSwitchColor: root.mButtonThemeSwitchColor
      mButtonThemeSwitchEnabledColor: root.mButtonThemeSwitchEnabledColor
      mButtonThemeSwitchHoveredColor: root.mButtonThemeSwitchHoveredColor
      mButtonThemeSwitchHoveredEnabledColor: root.mButtonThemeSwitchHoveredEnabledColor
      mButtonThemeSwitchPressedColor: root.mButtonThemeSwitchPressedColor

      mTaskDoneIconColor: root.mTaskDoneIconColor
      mTaskNotDoneIconColor: root.mTaskNotDoneIconColor

      mFontPixelSize: root.mFontPixelSize
      mSpacing: root.mSpacing
      mMargins: root.mMargins
      mRadius: root.mRadius
      mAnimationDuration: root.mAnimationDuration
      mTotalTasks: taskModel.getStats().total
      mCompletedTasks: taskModel.getStats().completed
      mRemainingTasks: taskModel.getStats().remaining
      mHasCompleted: taskModel.hasCompletedTasks()
      mDarkMode: root.mDarkMode

      onClearCompleted: function () {
        taskModel.clearCompletedTasks();
      }
    }
  }

  Component.onCompleted: function () {
    const win = ApplicationWindow.window;
    if (win) {
      win.header = headerComponent.createObject(win);
    }
  }
}
