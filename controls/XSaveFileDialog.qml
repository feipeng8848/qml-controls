import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.0

Control {
    property alias text:content.text

    width: 120
    height: 30
    clip: true
    background: Rectangle{
        id:bg
        anchors.fill: parent
        radius: 5
        color: "white"
    }

    Text {
        id:content
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 3
        text: qsTr("")
        width: parent.width - 30
        clip: true

        ToolTip.visible: (content.text!=="")&& hovered
        ToolTip.text:text
        ToolTip.timeout: 5000
        ToolTip.delay: 100
    }

    Rectangle{
        id:indicate_bg
        width: 20
        height: 20
        color: "#3c3f48"
        anchors.verticalCenter: bg.verticalCenter
        anchors.right: bg.right
        anchors.rightMargin: 5
        radius: 3
        Image {
            width: 20
            height: 20
            source: "../img/rightArrow.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                fdl.open()
            }
            onPressedChanged: {
                if(pressed)
                {
                    indicate_bg.opacity = 0.8
                    return
                }
                else
                {
                    indicate_bg.opacity = 1
                }
            }
        }
    }


   FileDialog{
        id:fdl
        onFileChanged: {
            content.text = file.toString().replace("file:///","").toString()
        }
    }


}
