pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Rectangle {
    id: containerRectId
    anchors.fill: parent

    Rectangle {
      id: skyId
      width: parent.width
      height: 200
      // color: "blue"
      gradient: Gradient {
        GradientStop {
          id: skyStartColorId
          position: 0.0
          color: "blue"
        }
        GradientStop {
          id: skyEndColorId
          position: 1.0
          color: "#66CCFF"
        }
      }
    }

    Rectangle {
      id: groundId
      anchors.top: skyId.bottom
      anchors.bottom: parent.bottom
      width: parent.width
      // color: "lime"
      gradient: Gradient {
        GradientStop {
          id: groundStartColorId
          position: 0.0
          color: "lime"
        }
        GradientStop {
          id: groundEndColorId
          position: 1.0
          color: "#66CCFF"
        }
      }
    }

    Image {
      id: treespringId
      x: 50
      y: 100
      width: 200
      height: 300
      source: "qrc:/qt/qml/Ch12S12/src/resrc/images/treespringsmall.png"
    }
    Image {
      id: treeSummerId
      x: 50
      y: 100
      width: 200
      height: 300
      source: "qrc:/qt/qml/Ch12S12/src/resrc/images/treesummersmall.png"
    }
    Rectangle {
      id: sunId
      x: parent.width - 110
      y: 50
      width: 100
      height: 100
      color: "yellow"
      radius: 60
    }

    state: "spring"

    states: [
      State {
        name: "summer"
        // PropertyChanges {
        //   target: skyId
        //   color: "lightblue"
        // }
        PropertyChanges {
          target: skyStartColorId
          color: "lightblue"
        }
        PropertyChanges {
          target: skyEndColorId
          color: "#EECCFF"
        }
        PropertyChanges {
          target: treeSummerId
          opacity: 1
        }
        PropertyChanges {
          target: treespringId
          opacity: 0
        }

        // PropertyChanges {
        //   target: groundId
        //   color: "darkkhaki"
        // }
        PropertyChanges {
          target: groundStartColorId
          color: "lime"
        }
        PropertyChanges {
          target: groundEndColorId
          color: "darkkhaki"
        }
        PropertyChanges {
          target: sunId
          color: "yellow"
        }
      },
      State {
        name: "spring"
        // PropertyChanges {
        //   target: skyId
        //   color: "deepskyblue"
        // }
        PropertyChanges {
          target: skyStartColorId
          color: "deepskyblue"
        }
        PropertyChanges {
          target: skyEndColorId
          color: "#AACCFF"
        }
        PropertyChanges {
          target: treeSummerId
          opacity: 0
        }
        PropertyChanges {
          target: treespringId
          opacity: 1
        }

        // PropertyChanges {
        //   target: groundId
        //   color: "lime"
        // }
        PropertyChanges {
          target: groundStartColorId
          color: "lime"
        }
        PropertyChanges {
          target: groundEndColorId
          color: "#66CCFF"
        }
        PropertyChanges {
          target: sunId
          color: "lightyellow"
        }
      }
    ]

    transitions: [
      Transition {
        from: "*"
        to: "*"
        // from: "summer"
        // to: "spring"
        ColorAnimation {
          duration: 500
        }
        NumberAnimation {
          property: "opacity"
          duration: 500
        }
      }
      // Transition {
      //   from: "spring"
      //   to: "summer"
      //   ColorAnimation {
      //     duration: 500
      //   }
      //   NumberAnimation {
      //     property: "opacity"
      //     duration: 500
      //   }
      // }

    ]

    MouseArea {
      anchors.fill: parent
      onClicked: function () {
        containerRectId.state = (containerRectId.state === "spring" ? "summer" : "spring");
      }
    }
  }
}
