pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore

Rectangle {
  id: root
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  function fetchData(url, callback) {
    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
        ApplicationWindow.window.title = "HEADERS RECEIVED";
      } else if (xhr.readyState === XMLHttpRequest.DONE) {
        ApplicationWindow.window.title = "DONE";
        if (xhr.status === 200) {
          ApplicationWindow.window.title = "resource found" + xhr.responseText.toString();
          callback(xhr.responseText.toString());
        } else {
          ApplicationWindow.window.title = "Something went wrong";
          callback(null);
        }
      }
    };

    xhr.open("GET", url);
    xhr.send();
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 0

    ListModel {
      id: mListModelId
    }

    ListView {
      id: mListViewId
      model: mListModelId
      delegate: mDelegatId
      Layout.fillWidth: true
      Layout.fillHeight: true
    }

    Button {
      id: mButtonId
      Layout.fillWidth: true
      text: "Fetch"
      onClicked: function () {
        root.fetchData("https://jsonplaceholder.typicode.com/users", function (response) {
          if (response) {
            var object = JSON.parse(response);

            object.forEach(function (userdata) {
              mListModelId.append({
                "userdata": userdata.name
              });
            });
          } else {
            ApplicationWindow.window.title = "Something went wrong";
          }
        });
      }
    }
    Component {
      id: mDelegatId
      Rectangle {
        id: rectangleId
        required property string userdata
        width: parent.width
        height: textId.implicitHeight + 30
        color: "beige"
        radius: 5
        border.color: "yellowgreen"
        Text {
          id: textId
          width: parent.width
          height: parent.height
          anchors.centerIn: parent
          text: rectangleId.userdata
          font.pointSize: 13
          wrapMode: Text.WordWrap
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
        }
      }
    }
  }
}
