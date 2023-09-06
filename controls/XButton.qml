import QtQuick 2.0
import QtQuick.Controls 2.12

Control {
    property string text : "button"
    signal clicked
    property string pressedColor: "#096dd9"
    property string normalColor: "#1890ff"

    id:btn
    width: content.width + 30
    height: content.height + 12

    scale: hovered? 1.05 : 1

    background: Rectangle{
        id:bg
        anchors.fill: parent
        color: normalColor
        radius: 5
    }

    Text {
        id: content
        text: qsTr(btn.text)
        color: "#ffffff"
        font.pixelSize: 12
        anchors.verticalCenter: btn.verticalCenter
        anchors.horizontalCenter: btn.horizontalCenter
    }


    MouseArea{
        anchors.fill: btn
        hoverEnabled: true
        onPressedChanged: {
            if(pressed === true)
            {
                bg.color = pressedColor
            }
            else
            {
                bg.color = normalColor
            }
        }
        onClicked: btn.clicked()        

    }
}
