pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls

Item {
  Component.onCompleted: function () {
    BWorker.cppSlot();
  }
}
