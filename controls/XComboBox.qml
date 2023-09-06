import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

T.ComboBox {
    id: control
    rightPadding: 5
    spacing: 5
    height: 30
    width: 120
    property string text: control.displayText

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 40
        border.color: "gray"
        border.width: control.visualFocus ? 2 : 1
        radius: 5
    }

    indicator:Rectangle{
        radius: 3
        height: 20
        width: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        color: "#3c4049"
        opacity:pressed?0.5:1

        Image {
            source: "../img/downArrow.png"
            anchors.centerIn: parent
        }
    }


    popup: Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: contentItem.implicitHeight + 2
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            border.color: "gray"
            radius: 5
        }
    }

    delegate: ItemDelegate {
        width: control.width
        height: control.height

        background:Rectangle{
            id:deleRect
            radius: 5
            width: parent.width
            height: parent.height
            color: hovered ? "#dddddd" : "white"
        }

        contentItem: Text {
            id:deleText
            text: modelData
            anchors.centerIn: parent
            anchors.margins: 2
            color: "black"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    contentItem: Text{
        leftPadding: 5
        rightPadding: control.indicator.width + control.spacing
        text: control.displayText
        font: control.font
        color: "black"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
