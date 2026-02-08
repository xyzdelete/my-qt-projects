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

  ColumnLayout {
    width: parent.width
    height: parent.height

    Label {
      text: "Non Editable Combo"
      wrapMode: Label.Wrap
      Layout.fillWidth: true
    }

    ComboBox {
      id: nonEditableCombo
      model: ["One", "Two", "Three", "Four"]
      onActivated: function () {
        ApplicationWindow.window.title = "[" + nonEditableCombo.currentIndex + "] " + nonEditableCombo.currentText + " is activated";
      }
      Layout.fillWidth: true
    }

    Label {
      text: "Editable Combo"
      wrapMode: Label.Wrap
      Layout.fillWidth: true
    }

    ComboBox {
      id: editableComboId
      editable: true
      textRole: "text"
      Layout.fillWidth: true
      model: ListModel {
        id: model
        ListElement {
          text: "Dog"
          location: "Kigali"
        }
        ListElement {
          text: "Chicken"
          location: "Beijing"
        }
        ListElement {
          text: "Cat"
          location: "Mumbai"
        }
        ListElement {
          text: "Meerkat"
          location: "Paris"
        }
      }

      onActivated: function () {
        ApplicationWindow.window.title = "[" + editableComboId.currentIndex + "] " + editableComboId.currentText + " is activated";
      }

      onAccepted: function () {
        if (editableComboId.find(editableComboId.editText) === -1) {
          model.append({
            text: editableComboId.editText,
            location: "US"
          });
        }
      }
    }

    Button {
      text: "Capture current element"
      Layout.fillWidth: true
      onClicked: function () {
        ApplicationWindow.window.title = "[" + model.get(editableComboId.currentIndex).text + "]: " + model.get(editableComboId.currentIndex).location;
      }
    }

    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
  }
}
