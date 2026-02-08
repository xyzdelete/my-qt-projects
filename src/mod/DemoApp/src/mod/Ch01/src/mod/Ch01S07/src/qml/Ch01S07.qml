pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import com.github.xyzdelete

Rectangle {
  id: rootRectangle
  anchors.fill: parent
  color: "transparent"
  border.color: '#0400ff'
  border.width: 1

  Movie {
    id: movieId
    title: "Titanic"
    mainCharacter: "Leonardo D"
  }

  // Film {
  //   id: movieId
  //   title: "Titanic"
  //   mainCharacter: "Leonardo D"
  // }

  Button {
    text: "Invoke created object"
    onClicked: function () {
      movieId.title = "Fast and Furious";
      movieId.mainCharacter = "Vin Diesel";
      print("New " + movieId.title + ", " + movieId.mainCharacter);
    }
  }
}
