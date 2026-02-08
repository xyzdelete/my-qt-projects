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

  function downloadData(url, callback) {
    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
        textId.text = "HEADERS RECEIVED";
      } else if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          callback(xhr.responseText.toString());
        } else {
          textId.text = "Something went wrong";
          callback(null);
        }
      }
    };

    xhr.open("GET", url);
    xhr.send();
  }

  TextArea {
    id: textAreaId
    anchors.fill: parent
    textFormat: TextArea.RichText
    text: "Html Data here"
  }

  Text {
    id: textId
  }

  MouseArea {
    anchors.fill: parent
    onClicked: function () {
      textId.text = "clicked";
      root.downloadData("https://jsonplaceholder.typicode.com/", function (response) {
        if (response) {
          textAreaId.text = response;
        } else {
          // null
          textAreaId.text = "Some error";
        }
      });
    }
  }
}
