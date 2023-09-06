import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import QtQuick.Dialogs 1.0
import "./controls"


Item {
    property string textColor: "white"
    property string bgColor: "#262a34"
    property string dotTempColor
    property string lineTempColor
    property string rangeTempColor
    property bool isAlarm :false
    property int alarmThreshold

    anchors.fill: parent

    ListView{
        id:lv
        anchors.fill: parent
        model:itemModel
    }

    ColorDialog {
        id: colorDialog_dot
        width: 400
        height: 500
        title: qsTr("选择颜色")
        color: "#000000"
    }


    ColorDialog {
        id: colorDialog_line
        title: qsTr("选择颜色")
        width: 400
        height: 500
        color: "#0007c3"
    }


    ColorDialog {
        id: colorDialog_rectangle
        title: qsTr("选择颜色")
        width: 400
        height: 500
        color: "#fb0808"
    }

    ObjectModel{
        id: itemModel

        AccordionItem{
            headerText: "基本参数设置"
            lv:lv
            index: 0
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                color: bgColor
                height: 500
                ColumnLayout{
                    spacing: 15
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    Text {
                        text: qsTr("温度修正")
                        color: textColor
                    }
                    Row{
                        spacing: 30
                        XRadioBtn{
                            text: qsTr("宽动态")
                        }
                        XRadioBtn{
                            text: qsTr("线性")
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("目标发射率")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:emiss_box
                            text: "1.0"
                            width: 70
                            height: 26
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("距离")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:distance_box
                            text: "0"
                            width: 70
                            height: 26
                        }
                        Text {
                            text: qsTr("CM")
                            color: textColor
                            width: 20
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("环境温度")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:airtemp_box
                            text: "25.0"
                            width: 70
                            height: 26
                        }
                        Text {
                            text: qsTr("℃")
                            color: textColor
                            width: 20
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("反射温度")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:refltmp_box
                            text:"0.0"
                            width: 70
                            height: 26
                        }
                        Text {
                            text: qsTr("℃")
                            color: textColor
                            width: 20
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("大气透过率")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{

                            text: ""
                            width: 70
                            height: 26
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("温度修正")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:fix_box
                            text: "0.0"
                            width: 70
                            height: 26
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("湿度")
                            color: textColor
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:humi_box
                            text: "0.45"
                            width: 70
                            height: 26
                        }
                        Text {
                            text: qsTr("%")
                            color: textColor
                            width: 20
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        spacing: 10
                        Text {
                            text: qsTr("镜头焦距")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                            width: 70
                        }
                        XComboBox{
                            id:lens_box
                            height: 30
                            width: 170
                            currentIndex: 0
                            model: ListModel{
                                ListElement{
                                    text:"3.8mm"
                                }
                                ListElement{
                                    text:"6.8mm"
                                }
                                ListElement{
                                    text:"8.2mm"
                                }
                            }
                        }
                    }
                    XButton{
                        height: 30
                        width: 150
                        text: qsTr("设置温度转换参数")
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            var emiss = parseFloat(emiss_box.text)
                            var refltmp = parseFloat(refltmp_box.text)
                            var airtmp = parseFloat(airtemp_box.text)
                            var humi = parseFloat(humi_box.text)
                            var distance = parseFloat(distance_box.text)
                            var fix = parseFloat(fix_box.text)
                            var lens = parseInt(lens_box.currentIndex)
                            showImg.updateFixParam(emiss,refltmp,airtmp,humi,distance,fix,lens)
                        }
                   }
                }
            }

        }


        AccordionItem{
            headerText: "测温分析"
            lv:lv
            index: 2
            content:Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 350
                ColumnLayout{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    spacing: 10

                    GridLayout{
                        rows: 3
                        columns: 4
                        columnSpacing: 10
                        rowSpacing: 10
                        Text {
                            text: qsTr("多点工具")
                            width: 60
                            color: textColor
                        }
                        RadioButton{
                            background: Rectangle{
                                width: 40
                                height: 24
                                radius: 3
                                color: parent.checked ? "#723036" : bgColor
                            }
                            indicator: Image {
                                source: "img/dotAdd.png"
                            }
                        }
                        RadioButton{
                            background: Rectangle{
                                width: 40
                                height: 24
                                radius: 3
                                color: parent.checked ? "#723036" : bgColor
                            }
                            indicator: Image {
                                source: "img/lineDele.png"
                            }
                        }
                        Rectangle{
                            color: colorDialog_dot.color
                            width: 50
                            height: 30
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    colorDialog_dot.open()
                                }
                            }
                            onColorChanged: {
                                dotTempColor = color
                            }
                        }

                        Text {
                            text: qsTr("多线工具")
                            width: 60
                            color: textColor
                        }
                        RadioButton{
                            background: Rectangle{
                                width: 40
                                height: 24
                                radius: 3
                                color: parent.checked ? "#723036" : bgColor
                            }
                            indicator: Image {
                                source: "img/lineAdd.png"
                            }
                        }
                        RadioButton{
                            background: Rectangle{
                                width: 40
                                height: 24
                                radius: 3
                                color: parent.checked ? "#723036" : bgColor
                            }
                            indicator: Image {
                                source: "img/lineDele.png"
                            }
                        }

                        Rectangle{
                            color: colorDialog_line.color
                            width: 50
                            height: 30

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    colorDialog_line.open()
                                }
                            }
                            onColorChanged: {
                                lineTempColor = color
                            }
                        }
                        Text {
                            text: qsTr("多区域工具")
                            width: 60
                            color: textColor
                        }
                        RadioButton{
                            background: Rectangle{
                                width: 40
                                height: 24
                                radius: 3
                                color: parent.checked ? "#723036" : bgColor
                            }
                            indicator: Image {
                                source: "img/rectangleAdd.png"
                            }
                        }
                        RadioButton{
                            background: Rectangle{
                                width: 40
                                height: 24
                                radius: 3
                                color: parent.checked ? "#723036" : bgColor
                            }
                            indicator: Image {
                                source: "img/rectangleDele.png"
                            }
                        }

                        Rectangle{
                            color: colorDialog_rectangle.color
                            width: 50
                            height: 30

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    colorDialog_rectangle.open()
                                }
                            }
                            onColorChanged: {
                                rangeTempColor = color
                            }
                        }
                    }




                    Row {
                        Text {
                            text: qsTr("报警设置")
                            color: textColor
                            width: 60
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:alarm_threshold
                            width: 45
                            text: parseFloat(alarmSlider.value * 100).toFixed(2)
                            enabled: waringSwitch.checked
                            height: 26
                            onTextChanged: {
                                alarmThreshold = parseInt(text)
                            }
                        }
                        Text {
                            text: qsTr("  ℃")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XSwitch{
                            id:waringSwitch
                            checkedText: ""
                            uncheckedText: ""
                            anchors.verticalCenter: parent.verticalCenter                            
                            onCheckedChanged: {
                                if(checked)
                                {
                                    isAlarm = true
                                    return
                                }
                                else
                                {
                                    isAlarm = false
                                }
                            }
                        }
                    }
                    RowLayout {
                        Text {
                            text: qsTr("温度")
                            color: textColor
                        }
                        XSliderH{
                            id:alarmSlider
                            width: 150
                            enabled: waringSwitch.checked
                        }
                        TextEdit{
                            text: parseFloat(alarmSlider.value * 100).toFixed(2)
                            color: textColor
                        }
                    }
                }
            }

        }


        AccordionItem{
            headerText: "测温增强"
            lv:lv
            index: 3
            content:Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 550
                ColumnLayout{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    spacing: 20
                    Text {
                        text: qsTr("外置测温传感器")
                        color: textColor
                    }
                    RowLayout{
                        spacing: 10
                        Layout.leftMargin: 25
                        Rectangle{
                            width: 50
                            height: 30
                            color: bgColor
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("型号")
                                color: textColor
                            }
                        }

                        XComboBox{
                            height: 30
                            width: 150
                            editText: qsTr("16bitNUC")
                            model: ListModel{
                                ListElement{
                                    text:"a"
                                }
                                ListElement{
                                    text:"b"
                                }
                                ListElement{
                                    text:"d"
                                }
                                ListElement{
                                    text:"d"
                                }
                            }
                        }
                    }
                    RowLayout{
                        spacing: 10
                        Layout.leftMargin: 25
                        Rectangle{
                            width: 50
                            height: 30
                            color: bgColor
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("打开位置")
                                color: textColor
                            }
                        }
                        XComboBox{
                            height: 30
                            width: 150
                            editText: qsTr("E:\\A-项目\\网站")
                            model: ListModel{
                                ListElement{
                                    text:"a"
                                }
                                ListElement{
                                    text:"b"
                                }
                                ListElement{
                                    text:"d"
                                }
                                ListElement{
                                    text:"d"
                                }
                            }
                        }
                    }
                    RowLayout{
                        Layout.leftMargin: 25
                        Text {
                            text: qsTr("参数设置")
                            color: textColor
                        }
                    }

                    Text {
                        text: qsTr("外置黑体")
                        color: textColor
                    }

                    RowLayout{
                        Layout.leftMargin: 25
                        spacing: 10
                        Text {
                            text: qsTr("黑体状态")
                            color: textColor
                        }
                        XSwitch{
                            id:blackBodySwitch
                            uncheckedText: ""
                            checkedText: ""
                            onCheckedChanged: {
                                if(checked == true)
                                {
                                    showImg.closeOutsideBlackBody()
                                    return
                                }
                                else
                                {
                                    showImg.setOutsideBlackBody(1,parseFloat(blackBody_temp.value * 100),-1,parseInt(blackBody_x.text),parseInt(blackBody_y.text),0)
                                    return
                                }
                            }
                        }
                    }
                    RowLayout{
                        spacing: 10
                        Layout.leftMargin: 25
                        Text {
                            text: qsTr("坐标")
                            color: textColor
                        }
                        Text{
                            text: qsTr("X")
                            color: textColor
                        }
                        XTextBox{
                            id:blackBody_x
                            text: qsTr("")
                        }

                        Text{
                            text: qsTr("Y")
                            color: textColor
                        }
                        XTextBox{
                            id:blackBody_y
                            text: qsTr("")
                        }
                    }
                    RowLayout{
                        spacing: 10
                        Layout.leftMargin: 25
                        Text {
                            text: qsTr("黑体温度")
                            color: textColor
                        }
                        XSliderH{
                            id:blackBody_temp
                            width: 150
                        }
                        TextEdit{
                            text: parseInt(blackBody_temp.value * 100)
                            color: textColor
                        }
                    }

                    RowLayout{
                        spacing: 10
                        Layout.leftMargin: 25
                        Button{
                            background: Image {
                                source: parent.pressed ? "./img/btnConfirmHL.png":"./img/btnConfirmBG.png"
                            }
                            onClicked: {
                                if(!blackBodySwitch.checked)
                                    return
                                showImg.setOutsideBlackBody(1,parseFloat(blackBody_temp.value * 100),-1,parseInt(blackBody_x.text),parseInt(blackBody_y.text),0)
                            }
                        }
                    }


                    Text {
                        text: qsTr("二次标定")
                        color: textColor

                    }
                    RowLayout{
                        spacing: 10
                        Layout.leftMargin: 25
                        XRadioBtn{
                            text: qsTr("方案1")
                        }
                        XRadioBtn{
                            text: qsTr("方案2")
                        }
                    }

                }
            }

        }

    }
}





