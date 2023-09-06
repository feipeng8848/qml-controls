import QtQuick 2.0
import QtQuick.Controls 2.12

Control{
    property string text : "00:08:10"
    id:root
    width: 100
    height: 26
    Rectangle{
        id:bg
        anchors.fill: parent
        radius: 5
        color: "black"
        opacity: 0.5
    }
    Rectangle{
        id:reddot
        width: 5
        height: 5
        radius: 2
        anchors.left: parent.left
        anchors.leftMargin:8
        color: "red"
        anchors.verticalCenter: bg.verticalCenter
    }
    Text {
        id: content
        text:text
        anchors.verticalCenter: bg.verticalCenter
        anchors.left: reddot.right
        anchors.leftMargin: 5
        color: "white"
        font.pixelSize: 18
    }
    onTextChanged: {
        content.text = root.text
    }

}
