import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    id:toolbar
    width: 80
    Layout.fillHeight: true
    color: bgColor

    property string textColor: "white"
    property string bgColor: "#262a34"
    property string hlColor: "#be3636"
    property int imgscalevalue: 0
    property bool freeVideo: false

    property string videoRecTimeLength
    property bool isRecording: false
    property int h : 0
    property int m : 0
    property int s : 0

    property bool isReverseH: false
    property bool isReverseV: false

    property string imageFormat: "bmp"

    property bool isAlarmOn: false

    signal captureImage()
    signal resetVideo()



    Column{
        spacing: 10
        width: parent.width
        anchors.fill: parent


        //拍照按钮
        Rectangle{
            id:captureBtn
            width: parent.width
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter
            color:bgColor
            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                id:captureBGImg
                Layout.alignment: Qt.AlignHCenter
                source: captureBtn.pressed ? "/img/TBBtnCaptureHL.png":"/img/TBBtnCaptureBG.png"
            }

            Text {
                text: imageFormat
                color: "white"
                anchors.horizontalCenter:  captureBtn.horizontalCenter
                anchors.bottom: captureBtn.bottom
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: {
                    if(mouse.button == Qt.LeftButton)
                    {
                        captureImage()
                        return
                    }
                    else
                    {
                        captureMenu.popup()
                    }

                }
                onPressed: {
                    if(mouse.button == Qt.LeftButton)
                    {
                        captureBGImg.source = "/img/TBBtnCaptureHL.png"
                    }
                }

                onPressedChanged: {
                    if(pressed)
                    {
                        return
                    }
                    else
                    {
                        captureBGImg.source = "/img/TBBtnCaptureBG.png"
                    }
                }
            }

            Menu{
                id:captureMenu
                width: 50
                height: 80
                spacing: 10
                background: Rectangle{
                    width: parent.width
                    height: parent.height
                    color: "white"
                    border.color: "gray"
                    border.width: 1
                }

                MenuItem{
                    text: qsTr("bmp")
                    onTriggered: {
                        imageFormat = "bmp"
                    }
                    anchors.margins: 3
                }
                MenuItem{
                    text: qsTr("raw")
                    anchors.margins: 3
                    onTriggered: {
                        imageFormat = "raw"
                    }
                }
            }
        }

        //录像按钮
        Switch{
            id:recordBtn
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter

            property date starttime
            property string videoFileName

            Timer{
                    id:countdown
                    interval: 1000
                    repeat: true
                    triggeredOnStart: true//这一设置保证了立即触发，如果没有，会有延迟
                    onTriggered: {
                        s+=1
                        if(s == 60)
                        {
                            s = 0
                            m +=1
                        }
                        if(m == 60)
                        {
                            m = 0
                            h += 1
                        }
                        videoRecTimeLength = (h+":").padStart(3,"0") + (m+":").padStart(3,"0") + (s+"").padStart(2,"0")
                    }
            }

            background: Rectangle{
                color:bgColor
                width: recordBtn.width
            }

            indicator: ColumnLayout{
                width: recordBtn.width
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: recordBtn.checked ? "/img/TBBtnEndRecord.png":"/img/TBBtnStartRecord.png"
                }
            }

            //ToolTip.visible: hovered
            //ToolTip.text: "录像"
            //ToolTip.timeout: 5000
            //ToolTip.delay: 100

            onClicked: {
                if(recordBtn.checked == true)
                {
                    countdown.start()
                    h = 0
                    m = 0
                    s = 0
                    isRecording = true

                    //录像文件名rec_YYYYMMDDHHmmss.avi
                    //从配置文件中拿到保存目录
                     videoFileName = getNowFormatTime() + ".avi"
                    //拼接目录与文件名
                    showImg.startRecordVideo(videoFileName)

                }
                else
                {
                    countdown.stop()
                    isRecording = false
                    showImg.stopRecordVideo()
                    showImg.showVideoFolder(videoFileName)
                }
            }
        }

        //内部矫正
        Button{
            id:shutterBtn
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            background:Rectangle{
                color:bgColor
            }
            contentItem:ColumnLayout{
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: shutterBtn.pressed ? "/img/TBBtnShutterHL.png":"/img/TBBtnShutterBG.png"
                }
            }

            ToolTip.visible: hovered
            ToolTip.text: "内部矫正"
            ToolTip.timeout: 5000
            ToolTip.delay: 100

            onClicked: {
                showImg.setInternalShutter()
            }
        }

        //外部矫正
        Button{
            id:bgCorrectionBtn
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            background:Rectangle{
                color:bgColor
            }
            contentItem: ColumnLayout{
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: bgCorrectionBtn.pressed ? "/img/TBBtnBackgroundCorrectionHL.png":"/img/TBBtnBackgroundCorrectionBG.png"
                }
            }

            ToolTip.visible: hovered
            ToolTip.text: "外部矫正"
            ToolTip.timeout: 5000
            ToolTip.delay: 100

            onClicked: {
                showImg.setExternalShutter()
            }
        }


        //分割线
        Rectangle{
            width: 60
            height: 1
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }


        XCheckBox{
            anchors.horizontalCenter:  parent.horizontalCenter
            text: qsTr("画面冻结")
            font.pixelSize: 10
            checked: false
            onCheckedChanged:
            {
                freeVideo = checked
            }
        }

        //放大镜按钮
        Button{
            id:magnifier
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            background:Rectangle{
                color:bgColor
            }
            contentItem: ColumnLayout{
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: magnifier.pressed ? "/img/magnifierHL.png":"/img/magnifierBG.png"
                }
            }
            onClicked: {
                if(vslider.value !== 1)
                {
                    vslider.value += 0.01
                }
            }
        }


        //滚动条缩放
        XIconSliderV{
            id:vslider
            anchors.horizontalCenter: parent.horizontalCenter
            value:0.5
            height: 120
        }

        //放大倍数
        TextInput{
            anchors.horizontalCenter: parent.horizontalCenter
            color: textColor
            text: parseInt(vslider.value*100)
            onTextChanged: {
                imgscalevalue = text
            }
        }


        //恢复窗口按钮
        Button{
            id:resizeBtn
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            background:Rectangle{
                color:bgColor
            }
            contentItem: ColumnLayout{
                height: 50
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: resizeBtn.pressed ? "img/cancelHL.png":"/img/cancelBG.png"
                }
            }
            onClicked: {
                resetVideo()
                vslider.value = 0.5
            }

            ToolTip{
                x:resizeBtn.x - width + 10
                timeout: 5000
                delay: 100
                visible: resizeBtn.hovered
                text: "重置画面"
                background: Rectangle{
                    anchors.fill: parent
                    color: "#FFFFFF"
                    radius: 3
                    border.color: "#aaaaaa"
                    border.width: 1
                }
                onVisibleChanged: {
                    if(visible)
                    {
                        y=y+50
                    }
                    else
                    {
                        y=y-50
                    }
                }
            }
        }


        //分割线
        Rectangle{
            width: 60
            height: 1
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }


        //画面水平翻转
        Flipable{
            id: reverseHBtn
            property bool flipped: false
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            back: Image { source: "/img/TBBtnReverseHHL.png"; anchors.centerIn: parent }

            front: Image { source: "/img/TBBtnReverseHBG.png"; anchors.centerIn: parent}

            transform: Rotation {
                id: rotation
                origin.x: reverseHBtn.width/2
                origin.y: reverseHBtn.height/2
                axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states: State {
                name: "back"
                PropertyChanges { target: rotation; angle: 180 }
                when: reverseHBtn.flipped
            }

            transitions: Transition {
                NumberAnimation { target: rotation; property: "angle"; duration: 400 }
            }

            MouseArea {
                anchors.fill: reverseHBtn
                onClicked: {
                    reverseHBtn.flipped = !reverseHBtn.flipped
                    isReverseH = !isReverseH
                    if(reverseHBtn.flipped == true){
                        showImg.setMirrorHorizontal()
                        return
                    }
                    else{
                        showImg.closeMirrorHorizontal()
                        return
                    }
                }
            }
        }

        //画面竖直翻转
        Flipable{
            id: reverseVBtn
            property bool flipped: false
            width: parent.width
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            back: Image { source: "/img/TBBtnReverseVHL.png"; anchors.centerIn: parent }

            front: Image { source: "/img/TBBtnReverseVBG.png"; anchors.centerIn: parent}

            transform: Rotation {
                id: rotationV
                origin.x: reverseHBtn.width/2
                origin.y: reverseHBtn.height/2
                axis.x: 1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                angle: 0    // the default angle
            }

            states: State {
                name: "back"
                PropertyChanges { target: rotationV; angle: 180 }
                when: reverseVBtn.flipped
            }

            transitions: Transition {
                NumberAnimation { target: rotationV; property: "angle"; duration: 400 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    reverseVBtn.flipped = !reverseVBtn.flipped
                    isReverseV = !isReverseV
                    if(reverseVBtn.flipped == true){
                        showImg.setMirrorVertical()
                        return
                    }
                    else{
                        showImg.closeMirrorVertical()
                        return
                    }
                }
            }
        }


        Image {
            width: 20
            height: 28
            anchors.horizontalCenter: parent.horizontalCenter
            id:alarmImage
            source: "../img/alarm_off.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    startAlarm()
                }
                onDoubleClicked: {
                    stopAlarm()
                }
            }
            Timer{
                repeat: true
                interval: 500
                triggeredOnStart: true
                id:alarm_timer
                onTriggered: {
                    isAlarmOn = !isAlarmOn
                }
            }
        }



    }

    onIsAlarmOnChanged: {
        if(isAlarmOn)
        {
            alarmImage.source = "../img/alarm_off.png"
            return
        }
        else
        {
            alarmImage.source = "../img/alarm_on.png"
        }
    }


    function startAlarm(){
        alarm_timer.start()
        console.log("temp alarm, temp threshold is :"+ tempSettingMenuContent.alarmThreshold +", current max temp is :"+ maxTemp.text)
    }
    function stopAlarm(){
        alarm_timer.stop()
        alarmImage.source = "../img/alarm_off.png"
    }


    //获取当前日期，格式YYYY-MM-DD
    function getNowFormatDay(nowDate) {
        var ch = "-"
        if(nowDate === null){
            nowDate = new Date();
        }
        var day = nowDate.getDate();
        var month = nowDate.getMonth() + 1;//注意月份需要+1
        var year = nowDate.getFullYear();
        //补全0，并拼接
        return year + ch + completeDate(month) + ch +completeDate(day);
    }

    //获取当前时间，格式YYYY-MM-DD HH:mm:ss
    function getNowFormatTime() {
        var nowDate = new Date();
        var colon = ":";
        var h = nowDate.getHours();
        var m = nowDate.getMinutes();
        var s = nowDate.getSeconds();
        //补全0，并拼接
        return getNowFormatDay(nowDate) + " " + completeDate(h) + colon + completeDate(m) + colon + completeDate(s);
    }

    //补全0
    function completeDate(value) {
        return value < 10 ? "0"+value:value;
    }
}
