import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import "./controls"

Item {
    property string textColor: "white"
    property string bgColor: "#262a34"
    property int denoise
    anchors.fill: parent

    ListView{
        id:lv
        anchors.fill: parent
        model:itemModel
        interactive:false
    }

    ObjectModel{
        id: itemModel
        AccordionItem{
            headerText: "图像控制"
            lv:lv
            index: 0
            content:Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                color: bgColor
                height: 380
                ColumnLayout{
                    spacing: 15
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    RowLayout{
                        height: 100
                        Text {
                            text: qsTr("图像拉伸")
                            color: textColor
                        }
                        XRadioBtn{
                            text: qsTr("宽动态")
                            checked: false
                            onCheckedChanged: {
                                if(checked == true)
                                {
                                    showImg.setStretchMode_Wide()
                                }
                            }
                        }
                        XRadioBtn{
                            text: qsTr("线性")
                            checked: false
                            onCheckedChanged: {
                                if(checked == true)
                                {
                                    showImg.setStretchMode_Line()
                                }
                            }
                        }
                    }

                    RowLayout{
                        ColumnLayout{
                            spacing: 17
                            Text {
                                text: qsTr("亮度")
                                color: textColor
                            }
                            Text {
                                text: qsTr("对比度")
                                color: textColor
                            }
                            Text {
                                text: qsTr("锐化")
                                width: 30
                                color: textColor
                            }
                            Text {
                                text: qsTr("降噪")
                                width: 30
                                color: textColor
                            }
                        }
                        ColumnLayout{
                            XSliderH{
                                id:brightnessSlider
                                width: 200
                                onValueChanged: {
                                    showImg.setBrightness(value*512)
                                }
                            }
                            XSliderH{
                                id:contrastSlider
                                width: 200
                                onValueChanged: {                                    
                                    showImg.setContrast(value*255);
                                }
                            }
                            XSliderH{
                                id:sharpnessSlider
                                width: 200
                                onValueChanged: {
                                    showImg.setSharpness(value*511);
                                }
                            }
                            XSliderH{
                                id:noizeSlider
                                width: 200
                                value:0
                                onValueChanged: {
                                    denoise = parseInt(value*255)
                                }
                            }
                        }
                        ColumnLayout{
                            spacing: 17
                            TextInput{
                                id:brightnessValueText
                                text: parseInt(brightnessSlider.value * 512)
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                id:contrastValueText
                                text: parseInt(contrastSlider.value *255)
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                id:sharpnessValueText
                                text: parseInt(sharpnessSlider.value * 511)
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                id:noizeValueText
                                text: parseInt(noizeSlider.value * 255)
                                width: 10
                                color: textColor
                            }
                        }
                    }



                    //分割线
                    Rectangle{
                        width: parent.width
                        height: 5
                    }

                    Text {
                        id: name
                        text: qsTr("特色功能（找到你的关注点）")
                        font.pixelSize: 16
                        color: textColor
                    }

                    RowLayout{
                        spacing: 5
                        ColumnLayout{
                            XRadioBtn{
                                text: qsTr("静态色阶调整模式")
                            }
                            XRadioBtn{
                                text: qsTr("自定义最低温模式")
                            }
                            XRadioBtn{
                                text: qsTr("自定义高低温模式")
                            }
                        }
                        ColumnLayout{
                            spacing: 20
                            Image {
                                source: "img/mode1.png"
                            }
                            Image {
                                source: "img/mode2.png"
                            }
                            Image {
                                source: "img/mode3.png"
                            }
                        }
                    }

                }
            }
        }


        AccordionItem{
            headerText: "AGC图像增益"
            lv:lv
            index: 1
            content:Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 360
                ColumnLayout{

                    RowLayout{
                        ColumnLayout{
                            spacing: 17
                            Text {
                                text: qsTr("尾部抑制")
                                color: textColor
                            }

                            Text {
                                text: qsTr("最大则增益")
                                color: textColor
                            }
                            Text {
                                text: qsTr("阻尼系数")
                                color: textColor
                            }
                            Text {
                                text: qsTr("自适应对比度增强")
                                color: textColor
                            }
                            Text {
                                text: qsTr("平衡值")
                                color: textColor
                            }
                            Text {
                                text: qsTr("线性百分百")
                                color: textColor
                            }
                            Text {
                                text: qsTr("数字细节增强")
                                color: textColor
                            }
                            Text {
                                text: qsTr("尾部抑制")
                                color: textColor
                            }
                            Text {
                                text: qsTr("平滑因子")
                                color: textColor
                            }
                            Text {
                                text: qsTr("AGC自定义区域选择")
                                color: textColor
                            }

                        }
                        ColumnLayout{
                            spacing: 10
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                            XSliderH{
                                width: 150
                            }
                        }
                        ColumnLayout{
                            spacing: 21
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                            TextInput{
                                text: "40"
                                width: 10
                                color: textColor
                            }
                        }
                    }
                }


            }

        }



        AccordionItem{
            headerText: "高级控制"
            lv:lv
            index: 2
            content:Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 400
                ColumnLayout{

                    Row{
                        spacing: 20
                        Text {
                            text: qsTr("条纹滤波")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                            width: 50
                        }
                        XSwitch{
                            checkedText: ""
                            checked: true
                            uncheckedText: ""
                            onCheckedChanged: {
                                if(checked)
                                {
                                    showImg.turnBandPassFilterOn()
                                    return
                                }
                                else
                                {
                                    showImg.turnBandPassFilterOff()
                                    return
                                }
                            }
                        }
                    }
                    Row{
                        spacing: 20
                        Text {
                            text: qsTr("时域滤波")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                            width: 50
                        }
                        XSwitch{
                            checkedText: ""
                            uncheckedText: ""
                            checked: true
                            onCheckedChanged: {
                                if(checked)
                                {
                                    showImg.turnTimeDomainFilterOn()
                                    return
                                }
                                else
                                {
                                    showImg.turnTimeDomainFilterOff()
                                    return
                                }
                            }
                        }
                    }
                    Row{
                        spacing: 20
                        Text {
                            text: qsTr("空域滤波")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                            width: 50
                        }
                        XSwitch{
                            checkedText: ""
                            uncheckedText: ""
                            checked: true
                        }
                    }

                    Row{
                        spacing: 20
                        Text {
                            text: qsTr("无挡NUC")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                            width: 50
                        }
                        XSwitch{
                            checkedText: ""
                            uncheckedText: ""
                        }
                    }


                    Row{
                        spacing: 20
                        Text {
                            text: qsTr("补充FFC")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                            width: 50
                        }
                        XSwitch{
                            checkedText: ""
                            uncheckedText: ""
                        }
                    }
                }


            }

        }


    }
}
