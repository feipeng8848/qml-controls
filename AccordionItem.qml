import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "./controls"

Item {
    id:panel
    property string headerText:"nothing"
    default property Item content
    property ListView lv
    property bool checked
    property real index
    width: lv.width
    height: 44

    Column{
        anchors.fill: panel
        spacing: 0        

        //header button
        Rectangle{
            width: panel.width
            height: 40
            color: "#262d37"
            Text {
                text: headerText
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
                font.pixelSize: 15
            }
            Image {
                width: 25
                height: 25
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                source: lv.currentIndex == index ?"img/upArrow.png":"img/downArrow.png"
            }
            MouseArea{
                anchors.fill : parent
                onClicked: {
                    if(lv.currentIndex == index)
                    {
                        lv.currentIndex = -1
                        return
                    }
                    lv.currentIndex = index
                }
            }
        }

        //header line
        Rectangle{
            id:headerLine
            height: 1
            color: "#000000"
            width: panel.width
            visible: lv.currentIndex == index ? true :false
        }

        //panelContent
        Control {
            id:panelContent
            width: panel.width
            height: content.height
            contentItem: content
            visible: lv.currentIndex == index ? true :false
            onVisibleChanged: {
                if(panelContent.visible)
                {
                    panel.height = content.height + 44
                }
                else{
                    panel.height = 44
                }
            }
        }

        //foot line
        Rectangle{
            id:footLine
            height: 1
            width: panel.width
            color: "#000000"
        }
    }

}
