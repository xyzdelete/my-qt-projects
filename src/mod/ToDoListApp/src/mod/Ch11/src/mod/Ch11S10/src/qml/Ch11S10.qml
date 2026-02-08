pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

Rectangle {
  id: rootId
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  HorizontalHeaderView {
    id: horizontalHeader
    anchors.left: tableViewId.left
    anchors.top: parent.top
    syncView: tableViewId
  }
  VerticalHeaderView {
    id: verticalHeader
    anchors.top: tableViewId.top
    anchors.left: parent.left
    syncView: tableViewId
  }
  TableModel {
    id: tableModelId

    TableModelColumn {
      display: "checked"
    }
    TableModelColumn {
      display: "amount"
    }
    TableModelColumn {
      display: "fruitType"
    }
    TableModelColumn {
      display: "fruitName"
    }
    TableModelColumn {
      display: "fruitPrice"
    }

    rows: [
      {
        checked: false,
        amount: 1,
        fruitType: "Apple",
        fruitName: "Granny Smith",
        fruitPrice: 1.50
      },
      {
        checked: true,
        amount: 4,
        fruitType: "Orange",
        fruitName: "Navel",
        fruitPrice: 2.50
      },
      {
        checked: false,
        amount: 1,
        fruitType: "Banana",
        fruitName: "Cavendish",
        fruitPrice: 3.50
      }
    ]
  }
  TableView {
    id: tableViewId
    anchors.left: verticalHeader.right
    anchors.top: horizontalHeader.bottom
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    columnSpacing: 1
    rowSpacing: 1

    model: tableModelId

    delegate: DelegateChooser {
      DelegateChoice {
        column: 0
        delegate: CheckBox {
          required property var model
          checked: model.display
          onToggled: function () {
            model.display = checked;
          }
        }
      }
      DelegateChoice {
        column: 1
        delegate: SpinBox {
          required property var model
          value: model.display
          onValueModified: function () {
            model.display = value;
          }
        }
      }
      DelegateChoice {
        delegate: TextField {
          required property var model
          text: model.display
          selectByMouse: true
          implicitWidth: 140
          onAccepted: model.display = text
        }
      }
    }
  }

  Button {
    text: "See the data"
    anchors.bottom: parent.bottom
    onClicked: function () {
      ApplicationWindow.window.title = tableModelId.data(tableModelId.index(0, 0), "display");
    }
  }
}
