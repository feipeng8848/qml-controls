import QtQuick 2.0
import QtQuick.Controls 2.12

Control {
    property string text: "default"
    background: Rectangle{
        id:bg
        width: 72
        height: 28
        radius: 8
        color: "#000000"
        opacity: 0.22
    }

    Image {
        id: img
        source: "../img/minTemp.png"
        anchors.verticalCenter: bg.verticalCenter
        anchors.left: bg.left
        anchors.leftMargin: 5
    }
    Text {
        id: txt
        text: text
        color: "#ffffff"
        anchors.verticalCenter: bg.verticalCenter
        anchors.left: img.right
        anchors.leftMargin: 5
        font.pixelSize: 16
    }
    onTextChanged: {
        txt.text = text
    }
}
