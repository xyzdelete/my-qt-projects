pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
  id: root
  property alias textItem: textId
  Text {
    id: textId
  }
  anchors.fill: parent
  color: "red"
}
