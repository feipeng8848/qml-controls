import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

Slider {
    id: control
    value: 0.5
    orientation:Qt.Vertical
    width: 6

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
        x:control.leftPadding + control.availableWidth / 2 - width/2
        y:control.topPadding + control.visualPosition * (control.availableHeight - height)
        width: 16
        height: 16
        Rectangle{
            height: 16
            width: 16
            radius: 8
            color: "#be3636"
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
