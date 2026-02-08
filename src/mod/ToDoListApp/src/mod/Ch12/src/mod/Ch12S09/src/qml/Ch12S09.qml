pragma ComponentBehavior: Bound
import QtQuick

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  property int animationDuration: 500
  property color startColor: "beige"
  property color endColor: "blue"

  readonly property var easingCurves: [
    {
      name: "Linear",
      type: Easing.Linear
    },
    {
      name: "InQuad",
      type: Easing.InQuad
    },
    {
      name: "OutQuad",
      type: Easing.OutQuad
    },
    {
      name: "InOutQuad",
      type: Easing.InOutQuad
    },
    {
      name: "OutInQuad",
      type: Easing.OutInQuad
    },
    {
      name: "InCubic",
      type: Easing.InCubic
    },
    {
      name: "OutCubic",
      type: Easing.OutCubic
    },
    {
      name: "InOutCubic",
      type: Easing.InOutCubic
    },
    {
      name: "OutInCubic",
      type: Easing.OutInCubic
    },
    {
      name: "InQuart",
      type: Easing.InQuart
    },
    {
      name: "OutQuart",
      type: Easing.OutQuart
    },
    {
      name: "InOutQuart",
      type: Easing.InOutQuart
    },
    {
      name: "OutInQuart",
      type: Easing.OutInQuart
    },
    {
      name: "InQuint",
      type: Easing.InQuint
    },
    {
      name: "OutQuint",
      type: Easing.OutQuint
    },
    {
      name: "InOutQuint",
      type: Easing.InOutQuint
    },
    {
      name: "OutInQuint",
      type: Easing.OutInQuint
    },
    {
      name: "InSine",
      type: Easing.InSine
    },
    {
      name: "OutSine",
      type: Easing.OutSine
    },
    {
      name: "InOutSine",
      type: Easing.InOutSine
    },
    {
      name: "OutInSine",
      type: Easing.OutInSine
    },
    {
      name: "InExpo",
      type: Easing.InExpo
    },
    {
      name: "OutExpo",
      type: Easing.OutExpo
    },
    {
      name: "InOutExpo",
      type: Easing.InOutExpo
    },
    {
      name: "OutInExpo",
      type: Easing.OutInExpo
    },
    {
      name: "InCirc",
      type: Easing.InCirc
    },
    {
      name: "OutCirc",
      type: Easing.OutCirc
    },
    {
      name: "InOutCirc",
      type: Easing.InOutCirc
    },
    {
      name: "OutInCirc",
      type: Easing.OutInCirc
    },
    {
      name: "InElastic",
      type: Easing.InElastic
    },
    {
      name: "OutElastic",
      type: Easing.OutElastic
    },
    {
      name: "InOutElastic",
      type: Easing.InOutElastic
    },
    {
      name: "OutInElastic",
      type: Easing.OutInElastic
    },
    {
      name: "InBack",
      type: Easing.InBack
    },
    {
      name: "OutBack",
      type: Easing.OutBack
    },
    {
      name: "InOutBack",
      type: Easing.InOutBack
    },
    {
      name: "OutInBack",
      type: Easing.OutInBack
    },
    {
      name: "InBounce",
      type: Easing.InBounce
    },
    {
      name: "OutBounce",
      type: Easing.OutBounce
    },
    {
      name: "InOutBounce",
      type: Easing.InOutBounce
    },
    {
      name: "OutInBounce",
      type: Easing.OutInBounce
    },
    {
      name: "Bezier",
      type: Easing.Bezier,
      bezierCurve: [0.25, 0.1, 0.25, 1.0]
    }
  ]

  Flickable {
    anchors.fill: parent
    contentWidth: width
    contentHeight: curveColumn.implicitHeight
    clip: true

    Column {
      id: curveColumn
      width: parent.width
      spacing: 2

      Repeater {
        model: rootRectangle.easingCurves

        delegate: MovingRectangle {
          required property int index
          required property var modelData

          backgroundColor: "lightgray"
          startColor: rootRectangle.startColor
          endColor: rootRectangle.endColor
          animDuration: rootRectangle.animationDuration
          easingText: (index + 1) + ": " + modelData.name
          easingType: modelData.type
          easingBezierCurve: modelData.bezierCurve !== undefined ? modelData.bezierCurve : []
          containerWidth: curveColumn.width
        }
      }
    }
  }
}
