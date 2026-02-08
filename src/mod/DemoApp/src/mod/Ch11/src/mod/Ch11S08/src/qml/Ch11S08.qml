pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.XmlListModel

Rectangle {
  id: rootId
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  XmlListModel {
    id: mXmlListModelId
    source: "qrc:/qt/qml/Ch11S08/src/resrc/xml/employees.xml"
    query: "/courses/course"

    XmlListModelRole {
      name: "instructor"
      elementName: "instructor"
    }
    XmlListModelRole {
      name: "year"
      elementName: "year"
    }
    XmlListModelRole {
      name: "coursename"
      elementName: "coursename"
    }
    XmlListModelRole {
      name: "hot"
      elementName: "coursename"
      attributeName: "hot"
    }
    onStatusChanged: console.log("XML model status:", status, "count:", count, "error:", errorString())
    onCountChanged: console.log("count", count, "source", source.toString())
  }

  ListView {
    id: mListViewId
    anchors.fill: parent
    model: mXmlListModelId
    delegate: Rectangle {
      id: rectId
      required property string instructor
      required property string coursename
      required property string year
      required property string hot
      width: parent.width
      height: 50
      color: "beige"
      Row {
        spacing: 30
        Text {
          text: rectId.instructor
          font.pixelSize: 10
        }
        Text {
          text: rectId.coursename + " (" + rectId.year + ")"
          font.bold: rectId.hot === "true" ? true : false
          font.pointSize: 10
        }
      }
      MouseArea {
        anchors.fill: parent
        onClicked: function () {
          ApplicationWindow.window.title = "Clicked on: " + rectId.hot;
        }
      }
    }
  }
}
