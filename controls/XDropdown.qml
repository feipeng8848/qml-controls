import QtQuick 2.0
import QtQuick.Controls 2.12

Item {
    id:root
    width: 120
    height: 30

    property string bgcolor: "white"
    property string bgbordercolor: "#dcdcdc"

    Rectangle{
        anchors.fill: parent
        color:bgcolor
        radius: 5
        border.color: bgbordercolor
        border.width: 1
    }
}
