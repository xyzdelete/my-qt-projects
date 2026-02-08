pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls.Material

Item {
  id: rootId
  required property RepositoryListModel repoModel
  property alias model: scrollModeComboBoxId.model
  property alias currentIndex: scrollModeComboBoxId.currentIndex
  property alias text: contentItemTextId.text
  signal activated

  ComboBox {
    id: scrollModeComboBoxId
    anchors.fill: parent

    onActivated: rootId.activated()

    background: Rectangle {
      radius: 10
      border.color: Theme.glassBorder
      gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop {
          position: 0.0
          color: Theme.backgroundGlassCardGradientStart
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
        GradientStop {
          position: 1.0
          color: Theme.backgroundGlassCardGradientEnd
          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDuration
            }
          }
        }
      }
    }

    contentItem: Text {
      id: contentItemTextId
      topPadding: 0
      bottomPadding: 0
      leftPadding: 0
      rightPadding: 0

      verticalAlignment: Qt.AlignVCenter
      horizontalAlignment: Qt.AlignHCenter

      color: Theme.textPrimary
      font.pointSize: 12
      elide: Text.ElideRight
    }

    indicator: Text {
      x: scrollModeComboBoxId.width - width - 10
      y: (scrollModeComboBoxId.height - height) / 2
      color: Theme.textPrimary
      text: "▼"
      font.pixelSize: 12
    }

    popup: Popup {
      id: scrollModeComboBoxPopupId
      padding: 0
      width: scrollModeComboBoxId.width
      background: Rectangle {
        radius: 10
        border.width: 1
        border.color: Theme.glassBorder
        color: Theme.backgroundGlass
      }

      contentItem: ListView {
        clip: true
        implicitHeight: contentHeight
        model: scrollModeComboBoxId.popup.visible ? scrollModeComboBoxId.delegateModel : null
        currentIndex: scrollModeComboBoxId.highlightedIndex
      }
    }

    delegate: ItemDelegate {
      id: scrollModeComboBoxItemDelegate

      required property string modelData
      required property int index

      width: scrollModeComboBoxId.width

      readonly property bool selected: scrollModeComboBoxId.currentIndex === scrollModeComboBoxItemDelegate.index

      text: modelData

      highlighted: scrollModeComboBoxId.highlightedIndex === index
      background: Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        color: scrollModeComboBoxItemDelegate.selected ? Theme.accentHover : Theme.backgroundGlass
        radius: 10
        border.color: scrollModeComboBoxItemDelegate.selected ? Theme.glassBorder : "transparent"
      }
      contentItem: Text {
        text: scrollModeComboBoxItemDelegate.text
        color: Theme.textPrimary
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
      }

      HoverHandler {
        cursorShape: Qt.PointingHandCursor
      }
    }

    HoverHandler {
      cursorShape: Qt.PointingHandCursor
    }
  }
}
