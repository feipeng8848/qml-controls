import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

Slider {
    id: control
    value: 0.5
    orientation:Qt.Vertical
    width: 20

    background: Rectangle {
        id:bg
        x: control.leftPadding + control.availableWidth / 2 - width/2
        y: control.topPadding
        implicitWidth: 6
        implicitHeight: 200
        width: 6
        height: control.availableHeight
        radius: 3
        color: "#d27373"

        Rectangle {
            width: parent.width
            height: control.visualPosition * parent.height
            color: "#bdbebf"
            radius: 3
        }
    }

    handle: Control {
        id:cl
        x:control.leftPadding + control.availableWidth / 2 - width/2
        y:control.topPadding + control.visualPosition * (control.availableHeight - height)
        Image{
            anchors.verticalCenter: cl.verticalCenter
            anchors.horizontalCenter: cl.horizontalCenter
            source: "../img/SliderHandleV.png"
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
