import QtQuick 2.12
import QtQuick.Controls 2.12

RadioButton {
    id:control
    spacing: 2

    contentItem: Text {
        color: "#ffffff"
        opacity: enabled ? 1.0 : 0.3
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
        text: control.text
    }

    indicator: Rectangle{
        id:bg
        width: 16
        height: 16
        border.color: "white"
        border.width: 2
        color: "#272c36"
        radius: 8
        anchors.verticalCenter: control.verticalCenter


        Rectangle{
            width: 12
            height: 12
            radius: 6
            anchors.verticalCenter: bg.verticalCenter
            anchors.horizontalCenter: bg.horizontalCenter
            color: control.checked?"#be3636":"#272c36"
        }
    }
}
