import QtQuick 2.0
import QtQuick.Controls 2.12

Control {
    id: control
    property real bgRadius: 3
    property alias text:txt.text


    height: 30
    width: 50

    opacity: enabled?1:0.5

    clip: true

    background: Rectangle {
        id:bg
        width: parent.width
        height: parent.height
        radius: bgRadius
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    TextEdit{
        id:txt
        anchors.left: bg.left
        anchors.top: bg.top
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: bg.verticalCenter
        anchors.horizontalCenter: bg.horizontalCenter
        anchors.leftMargin: 5
        selectionColor: "#3399ff"
        selectedTextColor: "#FFFFFF"
        selectByMouse: true
        text: control.text
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
