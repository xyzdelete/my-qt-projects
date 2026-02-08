pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Rectangle {
  id: rootId

  anchors.fill: parent
  // color: "#000000"
  border.color: '#4b4a7f'
  border.width: 1

  Connections {
    target: UndoStack
    function onUndone(description, data) {
      itemModel.remove(itemModel.count - 1);
      ToastManager.show("Undone: " + description);
    }
    function onRedone(description, data) {
      itemModel.append({
        itemColor: data
      });
      ToastManager.show("Redone: " + description);
    }
  }

  ListModel {
    id: itemModel
  }

  Column {
    anchors.fill: parent
    anchors.margins: Theme.spacing.small
    spacing: Theme.spacing.small

    Text {
      width: parent.width
      text: "Non-visual singletons: ToastManager & UndoStack"
      font.pixelSize: 18
      font.bold: true
      color: Theme.colors.primary
      wrapMode: Text.Wrap
    }

    Rectangle {
      width: parent.width
      height: 330
      radius: 10
      color: Theme.colors.surface
      border.color: Theme.colors.secondary
      border.width: 1

      Column {
        anchors.fill: parent
        anchors.margins: Theme.spacing.small
        spacing: Theme.spacing.small

        Text {
          text: "UndoStack - add colored items"
          font.pixelSize: 14
          font.bold: true
          color: Theme.colors.primary
        }

        // list goes here
        ListView {
          width: parent.width
          height: 50
          model: itemModel
          clip: true
          spacing: 5

          delegate: Rectangle {
            id: delegateId
            required property var model
            width: ListView.view.width
            height: 30
            radius: 10
            color: model.itemColor

            Text {
              anchors.centerIn: parent
              text: "Item " + (delegateId.model.index + 1)
              color: "white"
              font.pixelSize: 13
              font.bold: true
            }
          }
        }

        // add buttons go here
        Row {
          spacing: Theme.spacing.small
          Button {
            text: "Add Red"
            onClicked: {
              const color = "#E53935";
              itemModel.append({
                itemColor: color
              });
              UndoStack.push("Add red item", color);
              ToastManager.show("Added red item");
            }
          }
          Button {
            text: "Add blue"
            onClicked: {
              const color = "#1E88E5";
              itemModel.append({
                itemColor: color
              });
              UndoStack.push("Add blue item", color);
              ToastManager.show("Added blue item");
            }
          }
        }
        Row {
          spacing: Theme.spacing.small
          Button {
            text: "Add Green"
            onClicked: {
              const color = "#43A047";
              itemModel.append({
                itemColor: color
              });
              UndoStack.push("Add green item", color);
              ToastManager.show("Added green item");
            }
          }
          Button {
            text: "Clear history"
            enabled: UndoStack.count > 0
            onClicked: {
              UndoStack.clear();
              ToastManager.show("History cleared");
            }
          }
        }
        // undo / redo buttons go here

        Row {
          Button {
            text: "Undo: " + (UndoStack.canUndo ? UndoStack.undoText : "")
            enabled: UndoStack.canUndo
            onClicked: UndoStack.undo()
          }
        }
        Row {
          Button {
            text: "Redo: " + (UndoStack.canRedo ? UndoStack.redoText : "")
            enabled: UndoStack.canRedo
            onClicked: UndoStack.redo()
          }
        }
      }
    }

    // ToastManager panel goes here
    Rectangle {
      width: parent.width
      height: 150
      radius: 10
      color: Theme.colors.surface
      border.color: Theme.colors.secondary
      border.width: 1

      Column {
        anchors.fill: parent
        anchors.margins: Theme.spacing.small
        spacing: Theme.spacing.small
        Text {
          text: "ToastManager - manual Controls"
          font.pixelSize: 14
          font.bold: true
          color: Theme.colors.primary
        }

        Row {
          spacing: Theme.spacing.small
          Button {
            text: "Show toast (3 s)"
            onClicked: ToastManager.show("Hello from ToastManager!")
          }
        }
        Row {
          spacing: Theme.spacing.small
          Button {
            text: "Show toast (1 s)"
            onClicked: ToastManager.show("Quick toast!", 1000)
          }
          Button {
            text: "Dismiss"
            enabled: ToastManager.visible
            onClicked: ToastManager.dismiss()
          }
        }
      }
    }
    // status line goes here
    Text {
      text: "History depth: " + UndoStack.count + " | canUndo: " + UndoStack.canUndo + " | canRedo: " + UndoStack.canRedo
      font.pixelSize: 12
      color: Theme.colors.secondary
    }

    Text {
      text: "visible: " + ToastManager.visible + " | duration default: " + ToastManager.duration + " ms"
      font.pixelSize: 12
      color: Theme.colors.secondary
    }
  }

  Rectangle {
    id: toastOverlay
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: 30

    width: toastLabel.implicitWidth + Theme.spacing.large * 2
    height: 40
    radius: 20
    color: Theme.colors.primary
    opacity: ToastManager.visible ? 1.0 : 0.0
    visible: opacity > 0

    Behavior on opacity {
      NumberAnimation {
        duration: 200
        easing.type: Easing.InOutQuad
      }
    }

    Text {
      id: toastLabel
      anchors.centerIn: parent
      text: ToastManager.message
      color: "white"
      font.pixelSize: 14
    }
  }
}
