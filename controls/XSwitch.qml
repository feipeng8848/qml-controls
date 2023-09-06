import QtQuick 2.12
import QtQuick.Controls 2.12

Switch {
     id: control
     property string checkedText: "checked"
     property string uncheckedText: "unchecked"

     indicator: Rectangle {
         id:back
         implicitWidth: 40
         implicitHeight: 16
         x: control.leftPadding
         y: parent.height / 2 - height / 2
         radius: 7
         color: control.checked ? "#ffffff" : "#e6e6e6"

         Rectangle {
             x: control.checked ? parent.width - width - 2 : 2
             anchors.verticalCenter: back.verticalCenter
             width: 20
             height: 12
             radius: 6
             color: control.checked ? "#be3636" : "#32323b"
         }
     }

     contentItem: Text {
         text: control.checked?checkedText:uncheckedText
         font: control.font
         color: "#ffffff"
         opacity: enabled ? 1.0 : 0.3
         verticalAlignment: Text.AlignVCenter
         leftPadding: control.indicator.width + control.spacing
     }
 }
