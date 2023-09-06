import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQml.Models 2.12
import QtQuick.Dialogs 1.2
import Qt.labs.platform 1.1
import "./controls"

Item {
    property string textColor: "white"
    property string bgColor: "#262a34"
    anchors.fill: parent

    ListView{
        id:lv
        anchors.fill: parent
        model:itemModel
    }


    Component.onCompleted: {
        rBtn16NUC.checked = true
        imageSavePath.text = appSetting.getImageSavePath()
        videoSavePath.text = appSetting.getVideoSavePath()
    }



    ObjectModel{
        id: itemModel
        AccordionItem{
            headerText: "模组信息"
            lv:lv
            index: 0
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                color: bgColor
                height: 350
                Column{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    spacing: 10
                    Text{
                        text: qsTr("版本信息")
                        color: textColor
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("模组编号：TheremoX")
                            color: textColor
                        }
                    }

                    Row
                    {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("模组序列号：")
                            color: textColor
                        }
                        Text {
                            id: deviceId
                            color: textColor
                            Connections{
                                target: showImg
                                function onQmlRefeshImg(){
                                    deviceId.text = showImg.deviceId
                                }
                            }
                        }
                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("SDK版本：")
                            color: textColor
                        }
                        Text {
                            id: versionCode
                            color: "white"
                            Connections{
                                target: showImg
                                function onQmlRefeshImg(){
                                    versionCode.text = showImg.sdkVersion.toString(16)
                                }
                            }
                        }
                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("FPGA版本：")
                            color: textColor
                        }
                        Text {
                            id:fwVersion
                            color: textColor
                            Connections{
                                target: showImg
                                function onQmlRefeshImg(){
                                    fwVersion.text = showImg.fwVersion.toString(16)
                                }
                            }
                        }

                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("软件版本：rev 1.0")
                            color: textColor
                        }
                    }

                    Text{
                        text: qsTr("模组工作状态")
                        color: textColor
                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("超温阈值：1-48")
                            color: textColor
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("衬底温度：")
                            color: textColor
                        }
                        Text {
                            id: temp_cavity
                            color: "white"
                            Connections{
                                target: showImg
                                function onQmlRefeshImg(){
                                    temp_cavity.text = showImg.temp_cavity
                                }
                            }
                        }
                        

                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("功率状态：低功率")
                            color: textColor
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("温度状态：超温")
                            color: textColor
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text{
                            text: qsTr("过热次数：6")
                            color: textColor
                        }
                    }

                }
            }
        }


        AccordionItem{
            headerText: qsTr("输入输出设置")
            lv:lv
            index: 1
            content: Rectangle{
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 300
                Column{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    spacing: 15
                    Text {
                        color: textColor
                        text: qsTr("数据输入")
                    }
                    Column{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        XRadioBtn{
                            id:rBtn16NUC
                            text: qsTr("16Bit NUC")
                            checked: false
                            onCheckedChanged: {
                                if(checked == true)
                                {
                                    showImg.setOutputMode_16bitnuc()
                                }
                            }
                        }
                        XRadioBtn{
                            id:rBtnYUYV
                            text: qsTr("YUYV")
                            checked: false
                            onCheckedChanged: {
                                if(checked == true)
                                {
                                    showImg.setOutputMode_yuyv()
                                }
                            }
                        }
                    }
                    Text {
                        color: textColor
                        text: qsTr("控制")
                    }
                    Column{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        XRadioBtn{
                            text: qsTr("串口")
                            checked: true
                        }
                        XRadioBtn{
                            text: qsTr("LAN")
                            enabled: false
                        }
                        XRadioBtn{
                            text: qsTr("BT")
                            enabled: false
                        }
                        XRadioBtn{
                            text: qsTr("WIFI")
                            enabled: false
                        }
                    }
                }
            }
        }

        AccordionItem{
            headerText: "DVP视频流控制"
            lv:lv
            index: 2
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 400
                Column{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    spacing: 15
                    Text {
                        color: textColor
                        text: qsTr("视频模式")
                    }
                    Column{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        XRadioBtn{
                            text: qsTr("DVP")
                            checked: true
                        }
                        XRadioBtn{
                            text: qsTr("LVDS")
                        }
                        XRadioBtn{
                            text: qsTr("模拟")
                        }
                    }
                    Text {
                        color: textColor
                        text: qsTr("数据节点")
                    }
                    Column{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        XRadioBtn{
                            text: qsTr("AGC前")
                            checked: true
                        }
                        XRadioBtn{
                            text: qsTr("AGC后")
                        }
                        XRadioBtn{
                            text: qsTr("伪彩后")
                        }
                    }
                    Text {
                        color: textColor
                        text: qsTr("扩展行数据形式")
                    }
                    Column{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        XRadioBtn{
                            text: qsTr("包含")
                            checked: true
                        }
                        XRadioBtn{
                            text: qsTr("不包含")
                        }
                    }
                }
            }
        }

        AccordionItem{
            lv:lv
            index: 3
            headerText: qsTr("媒体设置")
            content: Rectangle{
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 210
                ColumnLayout{
                    spacing: 10
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    RowLayout{
                        spacing: 20
                        Text {
                            text: qsTr("图片质量")
                            color: textColor
                        }
                        XRadioBtn{
                            text: qsTr("高")
                            checked: true
                        }
                        XRadioBtn{
                            text: qsTr("中")
                        }
                        XRadioBtn{
                            text: qsTr("低")
                        }
                    }
                    RowLayout{
                        spacing: 20
                        Text {
                            text: qsTr("视频质量")
                            color: textColor
                        }
                        XRadioBtn{
                            text: qsTr("高")
                            checked: true
                        }
                        XRadioBtn{
                            text: qsTr("中")
                        }
                        XRadioBtn{
                            text: qsTr("低")
                        }
                    }
                    RowLayout{
                        height: 100
                        spacing: 20
                        Text {
                            text: qsTr("数据输出设置")
                            color: textColor
                        }
                        XComboBox{
                            height: 30
                            width: 150
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
                        height: 100
                        spacing: 10
                        Text {
                            text: qsTr("图片保存设置")
                            color: textColor
                        }
                        XTextBox{
                            id:imageSavePath
                            width: 130
                        }
                        FolderDialog {
                            id: folderDialog_image
                            onFolderChanged: {
                                imageSavePath.text = folderDialog_image.currentFolder.toString().replace("file:///","")
                                appSetting.setImageSavePath(imageSavePath.text + "/")
                            }
                        }
                        XButton{
                            text: qsTr("修改")
                            onClicked: {
                                folderDialog_image.open()
                            }
                        }
                    }
                    RowLayout{
                        height: 100
                        spacing: 10
                        Text {
                            text: qsTr("视频保存设置")
                            color: textColor
                        }
                        XTextBox{
                            id:videoSavePath
                            width: 130
                        }
                        FolderDialog {
                            id: folderDialog_video
                            onFolderChanged: {
                                videoSavePath.text = folderDialog_video.currentFolder.toString().replace("file:///","")
                                appSetting.setVideoSavePath(videoSavePath + "/")
                            }
                        }
                        XButton{
                            text: qsTr("修改")
                            onClicked: {
                                folderDialog_video.open()
                            }
                        }
                    }
                }
            }
        }


        AccordionItem{
            headerText: "挡片设置"
            lv:lv
            index: 4
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 250
                Column{
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    spacing: 15
                    Text {
                        text: qsTr("自动校正")
                        color: textColor
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 10
                        Text {
                            text: qsTr("自动时间")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:autoTempText
                            text: qsTr("40")
                            enabled: autoTimeSwitch.checked
                            width: 50
                            onTextChanged: {
                                if(!autoTimeSwitch.checked)
                                    return
                                showImg.setAutomaticCorrection(parseInt(text))
                            }
                        }
                        Text {
                            text: qsTr("s")
                            color: textColor
                            width:30
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        XSwitch{
                            id:autoTimeSwitch
                            anchors.verticalCenter: parent.verticalCenter
                            checkedText: ""
                            uncheckedText: ""
                            onCheckedChanged: {
                                if(!checked)
                                    return
                                showImg.setAutomaticCorrection(parseInt(autoTempText.text))
                            }
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 10
                        Text {
                            text: qsTr("自动温度")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            text: qsTr("40")
                            enabled: autoTempSwitch.checked
                            width: 50
                        }
                        Text {
                            text: qsTr("℃")
                            color: textColor
                            width: 30
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        XSwitch{
                            id:autoTempSwitch
                            anchors.verticalCenter: parent.verticalCenter
                            checkedText: ""
                            uncheckedText: ""
                        }
                    }
                }
            }
        }


        AccordionItem{
            headerText: "镜头设置"
            lv:lv
            index: 5
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 200
                Column{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    spacing: 15
                    Text {
                        text: qsTr("增益控制")
                        color: textColor
                    }
                    Text {
                        text: qsTr("锅盖标定")
                        color: textColor
                    }
                    Text {
                        text: qsTr("SFFC控制")
                        color: textColor
                    }
                    Text {
                        text: qsTr("NUVFFC控制")
                        color: textColor
                    }
                }
            }
        }



        AccordionItem{
            headerText: "用户校正"
            lv:lv
            index: 6
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                color: bgColor
                height: 550
                Column{
                    spacing: 15
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    Text {
                        text: qsTr("配置控制")
                        color: textColor
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("读取配置")
                            anchors.verticalCenter: parent.verticalCenter
                            color: textColor
                        }
                        XFileDialog{
                            width: 200
                            height: 30
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("保存位置")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XFileDialog{
                            width: 200
                            height: 30
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("导入配置")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XFileDialog{
                            width: 200
                            height: 30
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("开始采样")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("盲元修正")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }

                    }
                }
            }
        }


        AccordionItem{
            headerText: "进阶功能"
            lv:lv
            index: 7
            content: Rectangle {
                anchors.left: parent.left;
                anchors.right: parent.right

                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                color: bgColor
                height: 550
                Column{
                    spacing: 8
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    Text {
                        text: qsTr("节点采样")
                        color: "white"
                        font.pixelSize: 12
                    }
                    Row{
                        spacing:10
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Text {
                            text: qsTr("采样次数")
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            id:samplingTimes
                            width: 50
                            height: 25
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Text {
                            text: qsTr("/s")
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Row{
                        spacing: 15
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        Text {
                            text: qsTr("节点选择")
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XComboBox{
                            width: 200
                            model: ListModel{
                                ListElement{
                                    text:"16bitNUC"
                                }
                            }
                        }
                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("保存位置")
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XFolderDialog{
                            width: 200
                            height: 30
                            anchors.verticalCenter: parent.verticalCenter
                            text: appSetting.getSamplingPath()
                            onTextChanged: {
                                appSetting.setSamplingSavePath(text)
                            }
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("开始采样")
                            color: "white"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Timer{
                            id:samplingTimer
                            repeat: true
                            triggeredOnStart: true
                            onTriggered: {
                                showImg.setIsSampling()
                            }
                        }

                        //开始采样按钮
                        Rectangle{
                            width: 37
                            height: 18
                            radius: 3
                            Image {
                                anchors.fill: parent
                                source: startBtnRecArea.pressed ? "img/startBtnHL.png":"img/startBtnBG.png"
                            }
                            MouseArea{
                                id:startBtnRecArea
                                anchors.fill: parent
                                onClicked: {
                                    if(samplingTimes.text.length > 0)
                                    {
                                        samplingTimer.interval = parseInt(samplingTimes.text) * 1000
                                        samplingTimer.start()
                                    }
                                }
                            }
                        }

                        //结束采样按钮
                        Rectangle{
                            width: 37
                            height: 18
                            radius: 3
                            Image {
                                anchors.fill: parent
                                source: stopBtnRecArea.pressed? "img/stopBtnHL.png":"img/stopBtnBG.png"
                            }
                            MouseArea{
                                id:stopBtnRecArea
                                anchors.fill: parent
                                onClicked: {
                                    samplingTimer.stop()
                                }
                            }
                        }
                    }


                    Text {
                        text: qsTr("工程模式")
                        color: textColor
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("地址")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        ComboBox{
                            id:engineeringModeAddrs
                            editable: true
                            selectTextByMouse: true
                            height: 30
                            width: 200
                            Component.onCompleted: {
                                model = showImg.getEngineeringModeAddrs()
                            }
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("数据")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XTextBox{
                            width: 200
                            height: 30
                        }
                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("读/写")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            anchors.verticalCenter: parent.verticalCenter
                            background:Image{
                                source: parent.pressed ? "img/sysBtnReadHL.png" : "img/sysBtnReadBG.png"
                            }
                        }
                        Text {
                            text: qsTr("读")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            anchors.verticalCenter: parent.verticalCenter
                            background:Image{
                                source: parent.pressed ? "img/sysBtnReadHL.png" : "img/sysBtnReadBG.png"
                            }
                            onClicked: {
                                console.debug(engineeringModeAddrs.displayText)
                                showImg.addEngineeringModeAddrs(engineeringModeAddrs.displayText)
                                engineeringModeAddrs.model = showImg.getEngineeringModeAddrs()
                            }
                        }
                        Text {
                            text: qsTr("写")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }


                    Text {
                        text: qsTr("固件升级")
                        color: textColor
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("查询固件")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            anchors.verticalCenter: parent.verticalCenter
                            background:Image{
                                source: parent.pressed ? "img/sysBtnSearchFirmwareHL.png" : "img/sysBtnSearchFirmwareBG.png"
                            }
                        }
                        Text {
                            text: qsTr("导入程序")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                fdg.open()
                            }
                            FileDialog{
                                id:fdg
                                onFileChanged: {
                                }
                            }

                            background:Image{
                                source: parent.pressed ? "img/sysBtnImportHL.png" : "img/sysBtnImportBG.png"
                            }
                        }
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("升级固件")
                            color: textColor
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button{
                            anchors.verticalCenter: parent.verticalCenter
                            background:Image{
                                source: parent.pressed ? "img/sysBtnLoadFirmwareHL.png":"img/sysBtnLoadFirmwareBG.png"
                            }
                            onClicked: {
                                showImg.loadFirm()
                            }
                        }
                    }
                    Text {
                        text: qsTr("OSD")
                        color: textColor
                    }
                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("LOGO")
                            color: textColor
                            width: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        XFileDialog{
                            width: 200
                        }
                    }

                    Row{
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        spacing: 15
                        Text {
                            text: qsTr("TIME")
                            color: textColor
                            width: 50
                            anchors.verticalCenter: parent.verticalCenter
                        }


                        XComboBox{
                            height: 30
                            width: 150
                            model: ListModel{
                                ListElement{
                                    text:"ThermoX"
                                }
                                ListElement{
                                    text:"Noxt"
                                }
                                ListElement{
                                    text:"BPM6638"
                                }
                            }
                        }
                    }

                    Text {
                        text: qsTr("FFC")
                        color: "white"
                        font.pixelSize: 12
                    }
                }
            }
        }


    }


}
