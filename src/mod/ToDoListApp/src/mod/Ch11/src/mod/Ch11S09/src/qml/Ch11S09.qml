pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: rootId
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    width: parent.width
    height: parent.height
    color: "#EBEBEB"

    ListModel {
      id: modelId
      ListElement {
        our_color: "red"
      }
      ListElement {
        our_color: "green"
      }
      ListElement {
        our_color: "blue"
      }
      ListElement {
        our_color: "yellow"
      }
      ListElement {
        our_color: "black"
      }
      ListElement {
        our_color: "dodgerblue"
      }
      ListElement {
        our_color: "purple"
      }
      ListElement {
        our_color: "magenta"
      }
      ListElement {
        our_color: "yellowgreen"
      }
      ListElement {
        our_color: "skyblue"
      }
    }

    Component {
      id: delegateId
      Column {
        id: columnId
        scale: PathView.scale
        opacity: PathView.isCurrentItem ? 1 : 0.3
        required property string our_color
        readonly property bool is_current: PathView.isCurrentItem
        Rectangle {
          anchors.horizontalCenter: textId.horizontalCenter
          width: 64
          height: 64
          radius: 20
          color: columnId.our_color
          Text {
            id: rectTextId
            anchors.centerIn: parent
          }
          MouseArea {
            anchors.fill: parent
            onClicked: function () {
              if (columnId.is_current) {
                rectTextId.text = "Clicked on " + columnId.our_color;
              } else {
                rectTextId.text = "Not current item";
              }
            }
          }
        }
        Text {
          id: textId
          text: columnId.our_color
          font.pixelSize: 24
        }
      }
    }
    PathView {
      anchors.fill: parent
      model: modelId
      delegate: delegateId
      focus: true

      path: Path {
        // Starting Point
        startX: rootId.width / 2
        startY: rootId.height - 50

        PathAttribute {
          name: "scale"
          value: 1
        }

        PathCubic {
          x: 50
          y: rootId.height / 2
          control1X: rootId.width / 2 - rootId.width / 8
          control1Y: rootId.height
          control2X: 0
          control2Y: rootId.height / 2 + rootId.height / 8
        }

        PathAttribute {
          name: "scale"
          value: 0.5
        }

        PathCubic {
          x: rootId.height / 2
          y: 50
          control1X: 0
          control1Y: (rootId.height / 2 - rootId.height / 8)
          control2X: (rootId.width / 2 - rootId.height / 8)
          control2Y: 0
        }

        PathAttribute {
          name: "scale"
          value: 0.3
        }

        PathCubic {
          x: rootId.width - 50
          y: rootId.height / 2
          control1X: rootId.height / 2 + rootId.width / 8
          control1Y: 0
          control2X: rootId.width
          control2Y: rootId.height / 2 - rootId.height / 8
        }

        PathAttribute {
          name: "scale"
          value: 0.5
        }

        PathCubic {
          x: rootId.width / 2
          y: rootId.height - 50
          control1X: rootId.width
          control1Y: rootId.height / 2 + rootId.height / 8
          control2X: rootId.width / 2 + rootId.width / 8
          control2Y: rootId.height
        }

        PathAttribute {
          name: "scale"
          value: 1
        }
      }

      Keys.onLeftPressed: decrementCurrentIndex()
      Keys.onRightPressed: incrementCurrentIndex()
    }
  }
}
