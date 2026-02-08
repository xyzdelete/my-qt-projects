import QtQuick

Item {
  id: root
  required property color backgroundColor
  required property color startColor
  required property color endColor
  required property string easingText
  required property int animDuration
  required property var easingType
  required property int containerWidth
  property var easingBezierCurve: []

  width: containerRectId.width
  height: containerRectId.height
  property int finalX: containerRectId.width - containedRectId.width

  Rectangle {
    id: containerRectId
    width: root.containerWidth
    height: 50
    color: root.backgroundColor

    Text {
      text: root.easingText
      anchors.centerIn: parent
    }
    Rectangle {
      id: containedRectId
      color: root.startColor
      width: 50
      height: 50
      border {
        width: 5
        color: "black"
      }
      radius: 10
      MouseArea {
        anchors.fill: parent
        property bool toRight: false
        onClicked: function () {
          if (toRight === false) {
            // Move to right
            toRight = true;
            // Animate X
            mNumberAnimationId.to = containerRectId.width - containedRectId.width;
            mNumberAnimationId.start();

            // Animate color
            mColorAnimationId.from = root.startColor;
            mColorAnimationId.to = root.endColor;
            mColorAnimationId.start();
          } else {
            // Move to left
            toRight = false;

            // Animate X
            mNumberAnimationId.to = 0;
            mNumberAnimationId.start();

            // Animate color
            mColorAnimationId.from = root.endColor;
            mColorAnimationId.to = root.startColor;
            mColorAnimationId.start();
          }
        }
      }
      NumberAnimation {
        id: mNumberAnimationId
        target: containedRectId
        property: "x"
        easing.type: root.easingType
        easing.bezierCurve: root.easingBezierCurve
        to: root.finalX
        duration: root.animDuration
      }
      ColorAnimation {
        id: mColorAnimationId
        target: containedRectId
        property: "color"
        from: root.startColor
        to: root.endColor
        duration: root.animDuration
      }
    }
  }
}
