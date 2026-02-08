pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Page {
    anchors.fill: parent
    Action {
      id: newActionId
      text: qsTr("New")
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/newFileIcon.png"
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on new";
      }
    }
    Action {
      id: openActionId
      text: qsTr("Open...")
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/openIcon.png"
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on open";
      }
    }
    Action {
      id: saveActionId
      text: qsTr("Save")
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/saveIcon.png"
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on save";
      }
    }
    Action {
      id: saveAsActionId
      text: qsTr("Save As...")
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/saveAsIcon.png"
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on save as";
      }
    }

    Action {
      id: quitActionId
      text: qsTr("Quit")
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/quitIcon.png"
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on quit";
      }
    }

    Action {
      id: cutActionId
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/cutIcon.png"
      text: qsTr("Cut")
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on cut";
      }
    }
    Action {
      id: copyActionId
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/copyIcon.png"
      text: qsTr("Copy")
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on copy";
      }
    }
    Action {
      id: pasteActionId
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/pasteIcon.png"
      text: qsTr("Paste")
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on paste";
      }
    }

    Action {
      id: undoActionId
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/undoIcon.png"
      text: qsTr("Undo")
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on undo";
      }
    }
    Action {
      id: redoActionId
      icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/redoIcon.png"
      text: qsTr("Redo")
      onTriggered: function () {
        mStackId.currentItem.textItem.text = "Clicked on redo";
      }
    }

    Component {
      id: menuBarComponent
      MenuBar {
        id: menuBarId
        Menu {
          id: fileMenuId
          title: qsTr("File")
          MenuItem {
            action: newActionId
          }
          MenuItem {
            action: openActionId
          }
          MenuItem {
            action: saveActionId
          }
          MenuItem {
            action: saveAsActionId
          }

          MenuSeparator {}

          MenuItem {
            action: quitActionId
          }
        }
        Menu {
          id: cutMenuId
          title: qsTr("Edit")
          MenuItem {
            action: cutActionId
          }
          MenuItem {
            action: copyActionId
          }
          MenuItem {
            action: pasteActionId
          }

          MenuSeparator {}

          MenuItem {
            action: undoActionId
          }
          MenuItem {
            action: redoActionId
          }
        }
        Menu {
          id: helpMenu
          title: qsTr("Help")
          Action {
            id: helpActionId
            icon.source: "qrc:/qt/qml/Ch08S19/src/resrc/images/info.png"
            text: qsTr("About")
            onTriggered: function () {
              mStackId.currentItem.textItem.text = "Clicked on about";
            }
          }
        }
      }
    }

    Component {
      id: toolBarComponent
      ToolBar {
        Row {
          anchors.fill: parent
          ToolButton {
            action: newActionId
          }
          ToolButton {
            action: saveActionId
          }
          ToolButton {
            action: saveAsActionId
          }
          ToolButton {
            action: quitActionId
          }
        }
      }
    }

    Component {
      id: tabBarComponent
      TabBar {
        id: mTabBar
        width: parent.width
        TabButton {
          text: qsTr("Page1")
          onClicked: function () {
            mStackId.pop();
            mStackId.push("Page1.qml");
            ApplicationWindow.window.title = "Number of items: " + mStackId.depth;
          }
        }
        TabButton {
          text: qsTr("Page2")
          onClicked: function () {
            mStackId.pop();
            mStackId.push("Page2.qml");
            ApplicationWindow.window.title = "Number of items: " + mStackId.depth;
          }
        }
        TabButton {
          text: qsTr("Page3")
          onClicked: function () {
            mStackId.pop();
            mStackId.push("Page3.qml");
            ApplicationWindow.window.title = "Number of items: " + mStackId.depth;
          }
        }
      }
    }

    StackView {
      id: mStackId
      anchors.fill: parent
      initialItem: Page1 {}
    }

    Component.onCompleted: function () {
      const win = ApplicationWindow.window;
      if (win) {
        win.menuBar = menuBarComponent.createObject(win);
        win.header = toolBarComponent.createObject(win);
        win.footer = tabBarComponent.createObject(win);
      }
    }
  }
}
