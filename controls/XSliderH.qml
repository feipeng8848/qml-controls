import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

Slider {
    id: control
    property alias control: control
    value: 0.5

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.width
        implicitHeight: 6
        width: control.availableWidth
        height: implicitHeight
        radius: 3
        color: "#bdbebf"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: "#d27373"
            radius: 3
        }
    }

    handle: Control {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 16
        implicitHeight: 16
        Rectangle{
            height: 16
            width: 16
            radius: 8
            color: "#be3636"
        }
    }
}
