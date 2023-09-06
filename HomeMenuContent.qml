import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtCharts 2.3
import "./controls"

Item {
    property string textColor: "white"
    property string bgColor: "#262a34"
    property bool isCamOpen: false
    signal connectToDevice

    onConnectToDevice:{
        histTimer.start()
    }

    ColumnLayout{
        spacing: 10

        Text {
            text: qsTr("标准模式")
            font.pixelSize: 20
            color: textColor
        }
        RowLayout{
            height: 100
            spacing: 20
            Text {
                text: qsTr("设备型号")
                color: textColor
            }
            XComboBox{
                id:devNameList
                height: 30
                width: 170
                Component.onCompleted: {
                    model = showImg.devNameList
                }
            }
        }

        RowLayout{
            height: 100
            spacing: 20
            Text {
                text: qsTr("连接设备")
                color: textColor
            }
            XSwitch{
                id:camSwitch
                checkedText:""
                uncheckedText:""
                onCheckedChanged: {
                    if(checked == true)
                    {
                        showImg.start(devNameList.text)
                        showImg.initsdk()
                        isCamOpen = true
                        connectToDevice()                        
                        return
                    }
                    else{
                        showImg.stop()
                        showImg.closeSdk()
                        isCamOpen = false
                        return
                    }
                }
            }
        }
        RowLayout{
            spacing: 20
            Text {
                text: qsTr("测温模式")
                color: textColor
            }
            XRadioBtn{
                text: qsTr("人体")
                checked: true
            }
            XRadioBtn{
                text: qsTr("工业")
            }
        }

        Text {
            text: qsTr("直方图")
            color: "white"
        }
        ChartView{
            id:histogramView
            width: 280
            height: 220
            //抗锯齿
            antialiasing: true
            animationOptions:SeriesAnimations
            //theme: ChartView.ChartThemeDark
            margins.left: 0
            margins.top: 0
            margins.bottom: 0
            margins.right: 0
            backgroundColor: "#272c36"
            plotAreaColor: "#ffffff"
            titleFont.family: "微软雅黑"
            titleFont.pixelSize: 12
            legend.visible: false

            //x轴
            ValueAxis {
                id: axisX
                min: 0
                max: 20
                labelsColor: "white"
                tickCount: 4
            }
            //y轴
            ValueAxis {
                id: axisY
                labelsColor: "white"
                max: 50
                labelFormat: "%.0e"
            }

            ScatterSeries {
                id: series2
                axisX: axisX
                axisY: axisY
            }

            LineSeries {
                id:lineseries
                color: "#646464"
                width: 2
                name: qsTr("像素数量")
                axisX: axisX
                axisY: axisY


                XYPoint { x: 0; y: 0 }
                XYPoint { x: 1.1; y: 23.1 }
                XYPoint { x: 1.1; y: 21.1 }
                XYPoint { x: 2.1; y: 2.11 }
                XYPoint { x: 3.1; y: 10.1 }
                XYPoint { x: 10.1; y: 14.1 }
                XYPoint { x: 11.1; y: 2.1 }
                XYPoint { x: 12.1; y: 12.4 }
                XYPoint { x: 14.1; y: 12.6 }
                XYPoint { x: 15.1; y: 21.1 }
                XYPoint { x: 17.1; y: 8.1 }
                XYPoint { x: 18.1; y: 6.1 }
                XYPoint { x: 19.1; y: 5.1 }
                XYPoint { x: 21.1; y: 4.1 }
                XYPoint { x: 22.1; y: 2.1 }
            }


            Timer{
                repeat: true
                interval: 2000
                id:histTimer
                triggeredOnStart: true
                onTriggered: {
                    axisX.min = showImg.getHistMinX()
                    axisX.max = showImg.getHistManX()
                    lineseries.clear()

                    console.debug("----------------start record---------------")
                    console.debug(showImg.getHistValueAt(showImg.getHistMinX()+1 + "hello get histvalue at minx"))
                    console.debug(showImg.getHistMinX())
                    console.debug(showImg.getHistManX())

                    var start_i  = showImg.getHistMinX()
                    if(start_i - 500  < 0)
                    {
                        start_i = 0
                    }
                    else
                    {
                        start_i = start_i - 500
                    }
                    var end_i = showImg.getHistManX()
                    if(end_i + 500 > showImg.getHistLength())
                    {
                        end_i = showImg.getHistLength()
                    }
                    else{
                        end_i = end_i + 500
                    }

                    var maxvalue = 0;
                    for(var i = start_i ; i< end_i;i=i+5 )
                    {
                        var v = showImg.getHistValueAt(i)
                        if(maxvalue < v)
                            maxvalue = v
                        lineseries.append(parseInt(i),v)
                    }
                    axisY.max = maxvalue + maxvalue * 0.1
                }
            }

        }

        Text {
            text: qsTr("中心点温度曲线")
            color: textColor
        }

        ChartView{
            id:centerTempView
            width: 280
            height: 220
            //抗锯齿
            antialiasing: true
            animationOptions:SeriesAnimations
            //theme: ChartView.ChartThemeDark
            margins.left: 0
            margins.top: 0
            margins.bottom: 0
            margins.right: 0
            backgroundColor: "#272c36"
            plotAreaColor: "#ffffff"
            titleFont.family: "微软雅黑"
            titleFont.pixelSize: 12
            legend.visible: false

            //x轴
            ValueAxis {
                id: axisX_center
                min: 0
                max: 20
                labelsColor: "white"
                tickCount: 4
            }
            //y轴
            ValueAxis {
                id: axisY_center
                labelsColor: "white"
                max: 50
                labelFormat: "%.0e"
            }

            LineSeries {
                id:lineseries_centertemp
                color: "#646464"
                width: 2
                name: qsTr("像素数量")
                axisX: axisX_center
                axisY: axisY_center


                XYPoint { x: 0; y: 0 }
                XYPoint { x: 1.1; y: 23.1 }
                XYPoint { x: 1.1; y: 21.1 }
                XYPoint { x: 2.1; y: 2.11 }
                XYPoint { x: 3.1; y: 10.1 }
                XYPoint { x: 10.1; y: 14.1 }
                XYPoint { x: 11.1; y: 2.1 }
                XYPoint { x: 12.1; y: 12.4 }
                XYPoint { x: 14.1; y: 12.6 }
                XYPoint { x: 15.1; y: 21.1 }
                XYPoint { x: 17.1; y: 8.1 }
                XYPoint { x: 18.1; y: 6.1 }
                XYPoint { x: 19.1; y: 5.1 }
                XYPoint { x: 21.1; y: 4.1 }
                XYPoint { x: 22.1; y: 2.1 }
            }

        }

    }
}
