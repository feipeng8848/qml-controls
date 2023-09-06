import QtQuick 2.10
import QtQuick.Controls 2.3
import "./controls"

ListView {
    id: listView
    spacing: 0
    clip: true

    property string bgColor: "#262a34"
    property string hlColor: "#be3636"
    property var zmodel: []

    property var zclickedCall: null

    currentIndex: 0

    onZmodelChanged: {
        drawModel()
    }

    Rectangle{
        anchors.fill: parent
        color: bgColor
        z: -1
    }

    function drawModel(){
        listModel.clear()
        if(zmodel.length > 0){
            for(var i = 0; i < zmodel.length; i++){
                listModel.append(zmodel[i])
            }
        }
        currentIndex = currentIndex
    }


    property ListModel listModel: ListModel {}


    delegate: ItemDelegate {
        id: itemDelegate
        width: listView.width
        height: 60
        highlighted: ListView.isCurrentItem
        Item {
            anchors.fill: parent
            property bool imgExist: typeof(hlimg) !== "undefined"
            property bool fontIconExist: typeof(fontIcon) !== "undefined"

            Rectangle {
                id:placeholder
                anchors{
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: 10
                color: "transparent"
            }

            Image {
                id: image
                width: parent.imgExist ? 50 : 0
                height: 50
                source: parent.imgExist ? (highlighted ? hlimg : bgimg) : ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                visible: parent.imgExist
            }
        }

        onClicked: {
            listView.currentIndex = index
            if(zclickedCall != null){
                zclickedCall(index,zmodel[index])
            }
        }

        background: Rectangle {
            color: highlighted ? hlColor :bgColor
            Rectangle {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                height: parent.height
                width: 4
                color: highlighted ? hlColor :bgColor
            }
        }
    }


    model: listView.listModel
}
