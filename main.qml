import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import "./controls"
import "main.js" as MainScript

Window{
    id:xwindow
    //TODO:窗体实际大小会比这里设置的大小多出16*39个像素，多显示器切换的时候这部分会压缩窗体出现边框
    width: 1480 - 16
    height: 800 - 39
    visible: true
    color: bgColor
    flags: Qt.Window


    //初始化
        Component.onCompleted:{
            showImg.setCS_RGB()
            showImg.setOutputMode_16bitnuc()
        }

    property string bgColor: "#262a34"
    property string hlColor: "#be3636"
    property string menuContentBG: "#272c36"
    property string pseudoColorBarBGColor: "#3c4049"




    onWindowStateChanged: {
        resetVideoLocation()
    }

    //titlebar
    Rectangle{
        id:titleBar
        height: 35
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: xwindow.visibility == 2 ? 0: 8
        anchors.rightMargin: xwindow.visibility == 2 ? 0: 8
        anchors.topMargin: xwindow.visibility == 2 ? 0: 8
        color: "#000518"

        onHeightChanged: {
            console.debug(height)
            console.debug(width)
        }

        Image {
            id: titleLogo
            source: "img/titleLOGO.png"
            height: 14
            width: 85
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
        }

        Button{
            id:closeBtn
            height: 35
            width: 45
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: titleBar.right
            background: Rectangle{
                height: parent.height
                width: parent.width
                color: closeBtn.hovered ? "red" : "#000518"
            }

            contentItem: Image {
                anchors.fill: parent
                source: "img/titleCloseBtn_normal.png"
            }

            onClicked: {
                showImg.stop()
                showImg.closeSdk()
                Qt.quit()
            }
        }


        Button{
            id:minBtn
            height: 35
            width: 45
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: maxBtn.left
            background: Rectangle{
                height: parent.height
                width: parent.width
                color: minBtn.hovered ? bgColor : "#000518"
            }

            contentItem: Image {
                anchors.fill: parent
                source: "img/titleMinBtn_normal.png"
            }

            onClicked: {
                xwindow.showMinimized()
            }

        }


        Button{
            id:maxBtn
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: closeBtn.left
            height: 35
            width: 45
            background: Rectangle{
                height: parent.height
                width: parent.width
                color: maxBtn.hovered ? bgColor : "#000518"
            }

            contentItem: Image {
                anchors.fill: parent
                source: "img/titleMaxBtn_normal.png"
            }

            visible: xwindow.visibility == 4 ?false:true

            onClicked: {
                xwindow.showMaximized()
            }
        }


        Button{
            id:resizeBtn
            height: 35
            width: 45
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: closeBtn.left
            background: Rectangle{
                width: parent.width
                color: resizeBtn.hovered ? bgColor : "#000518"
            }

            contentItem: Image {
                anchors.fill: parent
                source: "img/titleResizeBtn_normal.png"
            }
            visible: xwindow.visibility == 4 ? true:false

            onClicked: {
                xwindow.showNormal()
            }
        }
    }


    //content
    Item{
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: xwindow.visibility == 2 ? 0: 8
        anchors.rightMargin: xwindow.visibility == 2 ? 0: 8
        anchors.bottomMargin: xwindow.visibility == 2 ? 0: 8
        clip: true
        //导航栏
        Item{
            id:navBarLayout
            width: 60
            height: parent.height
            //导航栏
            SideMenu{
                id:navBar
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: logobg.top
                zmodel:[
                    {
                        hlimg:"/img/homeIconBG.png",
                        bgimg:"/img/homeIconBG.png"
                    },
                    {
                        hlimg:"/img/imgIconBG.png",
                        bgimg:"/img/imgIconBG.png"
                    },
                    {
                        hlimg:"/img/tempIconBG.png",
                        bgimg:"/img/tempIconBG.png"
                    },
                    {
                        hlimg:"/img/settingIconBG.png",
                        bgimg:"/img/settingIconBG.png"
                    },
                    {
                        hlimg:"/img/helpIconBG.png",
                        bgimg:"/img/helpIconBG.png"
                    }
                ]
            }

            //logo
            Rectangle{
                id:logobg
                width: navBar.width
                anchors.bottom: parent.bottom
                height: 80
                color:bgColor
                Image{
                    width: 32
                    height: 32
                    id:logo
                    source: "/img/logo.png"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }

                Rectangle{
                    id:logoLine
                    width: 70
                    color: "white"
                    opacity: 0.3
                    height: 1
                    anchors.centerIn: parent
                    anchors.top: logo.bottom
                    anchors.topMargin: 5
                }

                Text {
                    id: temp_cavity
                    color: "white"
                    anchors.top:logoLine.bottom
                    anchors.topMargin: 3
                    font.pixelSize: 12
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    text:qsTr("hello world")
                }
            }
        }



        //分割线
        Rectangle{
            id:redline
            width: 2
            anchors.left: navBarLayout.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: hlColor
        }



        //二级菜单
        StackLayout{
            id:menuContent
            currentIndex: navBar.currentIndex
            width: 300
            anchors.top: parent.top
            anchors.left: redline.right
            anchors.bottom: parent.bottom

            //homeContent
            Rectangle {
                id: homeContent
                color: menuContentBG
                HomeMenuContent{
                    anchors.left: homeContent.left
                    anchors.top:  homeContent.top
                    anchors.margins: 10
                    onIsCamOpenChanged: {
                        if(isCamOpen)
                        {
                            pBar.refresh()
                            rangeslider.refreshPseudoTable()
                        }
                    }

                    onConnectToDevice: {
                        resetVideoLocationTimer.start()
                    }
                    Timer{
                        id:resetVideoLocationTimer
                        interval: 200
                        repeat: false
                        onTriggered: {
                            resetVideoLocation()
                        }
                    }
                }
            }


            //videoViewSetting
            Rectangle {
                id: imgSettingContent
                color: menuContentBG
                Layout.fillHeight: true

                ImageSettingMentContent{
                    onDenoiseChanged: {
                        pBar.denoise = denoise
                        pBar.denoiseChange()
                    }
                }
            }


            //tempSetting
            Rectangle {
                id: tempSetting
                color: menuContentBG
                TempSettingMenuContent{
                    id:tempSettingMenuContent                    
                    onIsAlarmChanged: {
                        if(isAlarm)
                        {
                            if(alarmThreshold < parseInt(maxTemp.text))
                            {
                                tbar.startAlarm()
                            }
                            return
                        }
                        else
                        {
                            tbar.stopAlarm()
                        }
                    }
                    onAlarmThresholdChanged: {
                        if(!isAlarm)
                        {
                            tbar.stopAlarm()
                            return
                        }

                        if(alarmThreshold < parseInt(maxTemp.text))
                        {
                            tbar.startAlarm()
                            return
                        }
                        else
                        {
                            tbar.stopAlarm()
                            return
                        }

                    }
                }
            }


            //sysSetting
            Rectangle {
                id: sysSetting
                color: menuContentBG
                SysSettingMentContent{

                }
            }


            //help icon
            Rectangle {
                id:help
                color: menuContentBG
                Column{
                    spacing: 5
                    anchors.fill: parent
                    Text {
                        color: "white"
                        text:  appSetting.getAppName()
                    }
                    Text {
                        color: "white"
                        text: appSetting.getRev()
                    }
                    Text {
                        id:imgsavepath
                        color: "white"
                        text:appSetting.getImageSavePath()
                    }
                    Text {
                        id:videosavepath
                        color: "white"
                        text:appSetting.getVideoSavePath()
                    }

                    XButton{
                        width: 150
                        text: qsTr("open Picture Folder")
                        anchors.margins: 3
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            showImg.showImageFolder(appSetting.getImageSavePath())
                        }
                    }
                    XButton{
                        width: 150
                        text: qsTr("open Video Folder")
                        anchors.margins: 3
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: {
                            showImg.showImageFolder(appSetting.getVideoSavePath())
                        }
                    }
                }

            }
        }



        //分割线
        Rectangle{
            id:blackLine
            anchors.top: parent.top
            anchors.left: menuContent.right
            anchors.bottom: parent.bottom
            width: 0
            color: "#000000"
        }



        //视频预览
        Control{
            id:videoViewContent
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: blackLine.right
            anchors.right: pBar.left
            clip: true
            background: Rectangle{
                color: "#1e1e28"
                anchors.fill:videoViewContent
                Image{
                    source: "./img/startLogo.png"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            onHeightChanged: {
                resetVideoLocation()
            }

            onWidthChanged: {
                resetVideoLocation()
            }

            function disableMouseArea(){
                moveArea.enabled = false
                rangeTemp.enabled = false
                lineTemp.enabled = false
            }

            Menu{
                id:videoContentRightMenu
                width: 120
                MenuItem{
                    text: qsTr("手形工具")
                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        moveArea.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("+测温点")

                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        dotTemp.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("-测温点")
                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        dotTemp.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("+测温线")
                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        lineTemp.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("-测温线")
                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        lineTemp.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("+测温区域")
                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        rangeTemp.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("-测温区域")
                    onTriggered: {
                        moveArea.enabled = false
                        rangeTemp.enabled = false
                        lineTemp.enabled = false
                        dotTemp.enabled = false

                        rangeTemp.enabled = true
                    }
                }
                MenuItem{
                    text: qsTr("清除所有")
                    onTriggered: {
                        tempMeasurement.clearDots()
                        tempMeasurement.clearLines()
                        tempMeasurement.clearRanges()
                        canvas_line.clear()
                        canvas_range.clear()
                    }
                }
            }

            contentItem: Control{
                id:videoContent
                anchors.fill: parent
                //图像的原始尺寸，从directshow中获取
                property int imgOriginalHeight
                property int imgOriginalWidth

                //图片经过铺满缩放和手动调节比例缩放后的实际显示像素尺寸
                property int imgRealHeight
                property int imgRealWidth

                //测温点的原始坐标从directshow中拿到
                property int max_original_x
                property int max_original_y
                property int min_original_x
                property int min_original_y

                //视频画面
                Image {
                    id: videoImg
                    fillMode:Image.PreserveAspectFit

                    property int start_x: 0
                    property int start_y: 0
                    property bool isReverseH: false
                    property bool isReverseV: false

                    //平移工具
                    MouseArea{
                        id:moveArea
                        enabled: true
                        anchors.fill: parent
                        drag.target: videoImg
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        cursorShape: (containsMouse? (pressed? Qt.ClosedHandCursor: Qt.OpenHandCursor): Qt.OpenHandCursor);
                        onWheel: {
                            //每次滚动都是100的倍数
                            var datla = wheel.angleDelta.y/100
                            if(datla > 0)
                            {
                                videoImg.width = videoImg.width / 0.9
                                videoImg.height = videoImg.height / 0.9
                            }
                            else
                            {
                                videoImg.width = videoImg.width * 0.9
                                videoImg.height = videoImg.height * 0.9
                            }
                        }

                        onDoubleClicked: {
                            resetVideoLocation()
                        }

                        onClicked: {
                            if(mouse.button == Qt.RightButton)
                            {
                                videoContentRightMenu.popup()
                            }
                        }
                    }


                    //视频录制时间控件
                    XVideoTimer{
                        id:videotimer
                        visible: false
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    //当showImg的qmlRefreshImg信号发生的时候执行
                    Connections{
                        target: showImg
                        function onQmlRefeshImg(){
                            if(!tbar.freeVideo)
                            {
                                videoImg.source = "image://imgProvider/" + Math.random()

                                //从direchshow中拿到图像的原始坐标和图像原始尺寸
                                videoContent.imgOriginalHeight = showImg.getImageHeight()
                                videoContent.imgOriginalWidth = showImg.getImageWidth()
                                videoContent.max_original_x = showImg.getMaxTemp_X()
                                videoContent.max_original_y = showImg.getMaxTemp_Y()
                                videoContent.min_original_x = showImg.getMinTemp_X()
                                videoContent.min_original_y = showImg.getMinTemp_Y()

                                if(videoImg.state !== Image.Null)
                                {
                                    maxTemp.visible = true
                                    minTemp.visible = true
                                }
                                else
                                {
                                    maxTemp.visible = false
                                    minTemp.visible = false
                                }

                                //相对于显示图片的实际像素的测温点实际坐标
                                var rate = videoImg.width / videoContent.imgOriginalWidth
                                var max_real_x = videoContent.max_original_x * rate
                                var max_real_y = videoContent.max_original_y * rate
                                var min_real_x = videoContent.min_original_x * rate
                                var min_real_y = videoContent.min_original_y * rate

                                if(videoImg.isReverseH)
                                {
                                    max_real_x = videoImg.width - max_real_x
                                    min_real_x = videoImg.width - min_real_x
                                }

                                if(videoImg.isReverseV)
                                {
                                    max_real_y = videoImg.height - max_real_y
                                    min_real_y = videoImg.height - min_real_y
                                }

                                //计算出图片左上角原点尺寸，把测温点坐标叠加上即可
                                maxTemp.anchors.leftMargin = max_real_x
                                maxTemp.anchors.topMargin = max_real_y

                                minTemp.anchors.leftMargin = min_real_x
                                minTemp.anchors.topMargin = min_real_y

                                maxTemp.text = parseInt(showImg.getMaxTemp())
                                minTemp.text = parseInt(showImg.getMinTemp())
                                minTemp_foot.text = minTemp.text
                                maxTemp_foot.text = maxTemp.text

                            }
                        }
                    }


                    //点测温，这些都是临时画板，仅仅为了实时渲染
                    Item{
                        id:dotTemp
                        enabled: false
                        anchors.fill: parent
                        MouseArea{
                            id:dotTempArea
                            enabled: parent.enabled
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            onClicked: {
                                if(mouse.button == Qt.RightButton)
                                {
                                    videoContentRightMenu.popup()
                                }
                            }
                            //当鼠标按下时调用本函数
                            onPressed: {
                            }
                            onReleased: {
                                if(mouse.button == Qt.LeftButton)
                                {
                                    //从sdk中拿到据
                                    var rate = videoContent.imgOriginalHeight / videoImg.height
                                    var x = mouse.x * rate
                                    var y = mouse.y * rate
                                    var t = showImg.getPointTemp(x,y)
                                    tempMeasurement.addDot(videoContent.imgOriginalWidth,videoContent.imgOriginalHeight,mouse.x,mouse.y,t)
                                }
                            }
                        }
                    }


                    //线测温
                    Item {
                        id: lineTemp
                        enabled: false
                        anchors.fill: parent
                        property string color

                        property real startX     //储存鼠标开始时的坐标
                        property real startY
                        property real stopX      //储存鼠标结束时的坐标
                        property real stopY
                        property bool isMouseMoveEnable: false//是否允许鼠标移动绘制事件

                        MouseArea{
                            id:lineTempArea
                            enabled: parent.enabled
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            //当鼠标按下时调用本函数
                            onPressed: {
                                lineTemp.startX = mouse.x;
                                lineTemp.startY = mouse.y;
                                lineTemp.isMouseMoveEnable = true
                            }

                            //当鼠标press位置改变，调用本函数
                            onPositionChanged: {
                                if (lineTemp.isMouseMoveEnable){
                                    canvas_line.requestPaint()   //绘制函数
                                }
                            }
                            onClicked: {
                                if(mouse.button == Qt.RightButton)
                                {
                                    videoContentRightMenu.popup()
                                }
                            }
                            onReleased: {
                                if(mouse.button == Qt.LeftButton)
                                {
                                    tempMeasurement.addLine(canvas_line.width,canvas_line.height,lineTemp.startX,lineTemp.startY,lineTemp.stopX,lineTemp.stopY)
                                    canvas_line.clear()
                                }
                            }
                        }

                        Canvas{
                            id:canvas_line
                            anchors.fill:parent
                            enabled: parent.enabled
                            opacity: 0.5

                            function clear(){
                                var ctx = getContext("2d")
                                ctx.clearRect(0,0,width,height)
                                requestPaint()
                            }

                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.lineWidth = 3
                                ctx.strokeStyle = tempSettingMenuContent.lineTempColor
                                ctx.clearRect(0,0,width,height)

                                //鼠标没有按下，绘制图形容器中存储的所有图形
                                if(!lineTempArea.pressed)
                                {
                                    var count = tempMeasurement.getLinesSize()
                                    if(count <= 0)
                                        return
                                    ctx.beginPath()
                                    for(var i = 0 ;i < count ; i++)
                                    {
                                        var sx = tempMeasurement.getLineStartXAt(i)
                                        var sy = tempMeasurement.getLineStartYAt(i)
                                        var ex = tempMeasurement.getLineEndXAt(i)
                                        var ey = tempMeasurement.getLineEndYAt(i)
                                        ctx.moveTo(sx,sy)
                                        ctx.lineTo(ex,ey)
                                        ctx.stroke()
                                    }
                                    return
                                }


                                //开始绘制
                                ctx.beginPath()
                                //起点
                                ctx.moveTo(lineTemp.startX,lineTemp.startY)
                                //记录移动终点
                                lineTemp.stopX =lineTempArea.mouseX
                                lineTemp.stopY =lineTempArea.mouseY
                                ctx.lineTo(lineTemp.stopX,lineTemp.stopY)
                                ctx.stroke()
                            }
                        }
                    }


                    //区域测温
                    Item{
                        id:rangeTemp
                        enabled: false
                        anchors.fill: parent
                        property string color

                        property real startX     //储存鼠标开始时的坐标
                        property real startY
                        property real stopX      //储存鼠标结束时的坐标
                        property real stopY
                        property bool isMouseMoveEnable: false//是否允许鼠标移动绘制事件

                        MouseArea{
                            id:rangeTempArea
                            enabled: parent.enabled
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton

                            onClicked: {
                                if(mouse.button == Qt.RightButton)
                                {
                                    videoContentRightMenu.popup()
                                }
                            }

                            onPressed: {
                                rangeTemp.startX = mouse.x;
                                rangeTemp.startY = mouse.y;
                                rangeTemp.isMouseMoveEnable = true
                            }

                            //当鼠标press且位置改变，调用本函数
                            onPositionChanged: {
                                if (rangeTemp.isMouseMoveEnable){
                                    canvas_range.requestPaint()   //绘制函数
                                }
                            }

                            onReleased: {
                                if(mouse.button == Qt.LeftButton)
                                {
                                    //获取区域内所有的点及其温度就可以测温
                                    tempMeasurement.addRange(canvas_range.width,canvas_range.height,rangeTemp.startX,rangeTemp.startY,rangeTemp.stopX ,rangeTemp.stopY)
                                    canvas_range.clear()
                                }

                            }
                        }

                        Canvas{
                            id:canvas_range
                            anchors.fill:parent
                            enabled: parent.enabled
                            opacity: 0.5

                            function clear(){
                                var ctx = getContext("2d")
                                ctx.clearRect(0,0,width,height)
                                requestPaint()
                            }

                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.lineWidth = 3
                                ctx.strokeStyle = tempSettingMenuContent.rangeTempColor

                                ctx.clearRect(0,0,width,height)

                                if(!rangeTempArea.pressed)
                                {
                                    var count = tempMeasurement.getRangesSize()
                                    if(count <= 0)
                                        return
                                    ctx.beginPath()
                                    for(var i = 0 ;i < count ; i++)
                                    {
                                        var sx = tempMeasurement.getRangeStartXAt(i)
                                        var sy = tempMeasurement.getRangeStartYAt(i)
                                        var ex = tempMeasurement.getRangeEndXAt(i)
                                        var ey = tempMeasurement.getRangeEndYAt(i)
                                        ctx.moveTo(sx,sy)
                                        ctx.strokeRect(sx,sy,ex-sx,ey-sy)
                                        ctx.stroke()
                                    }
                                    return
                                }
                                //开始绘制
                                ctx.beginPath()
                                ctx.moveTo(rangeTemp.startX,rangeTemp.startY)

                                //记录移动终点
                                rangeTemp.stopX =rangeTempArea.mouseX
                                rangeTemp.stopY =rangeTempArea.mouseY

                                //绘制长方形
                                ctx.strokeRect(rangeTemp.startX,rangeTemp.startY,rangeTemp.stopX-rangeTemp.startX,rangeTemp.stopY-rangeTemp.startY)
                                ctx.stroke()
                            }
                        }
                    }

                }

                //点测温、线测温、区域测温绘制
                Image{
                    id:tempMeasurementDrawingBoard
                }

                //屏幕最高温
                XMaxTempPanel{
                    id: maxTemp
                    anchors.top: videoImg.top
                    anchors.left: videoImg.left
                    visible:false

                    onTextChanged: {
                        if(!tempSettingMenuContent.isAlarm)
                        {
                            tbar.stopAlarm()
                            return
                        }

                        if(parseInt(text) > tempSettingMenuContent.alarmThreshold)
                        {
                            tbar.startAlarm()
                            return
                        }
                        else{
                            tbar.stopAlarm()
                        }
                    }
                }

                //屏幕最低温
                XMinTempPanel{
                    id:minTemp
                    anchors.top: videoImg.top
                    anchors.left: videoImg.left
                    visible:false
                }


                Control{
                    id:foot
                    height: 45
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    background: Rectangle{
                        color:"#3b3f48"
                        anchors.fill: parent
                    }
                    contentItem: Item{
                        Row{
                            anchors.fill: parent
                            spacing: 10
                            leftPadding: 10
                            XComboBox{
                                anchors.verticalCenter: parent.verticalCenter
                                height: 25
                                width: 150
                                model: ListModel{
                                    ListElement{
                                        text:"关闭效果"
                                    }
                                    ListElement{
                                        text:"自定义高低温模式"
                                    }
                                    ListElement{
                                        text:"自定义最低温模式"
                                    }
                                    ListElement{
                                        text:"静态色阶调整模式"
                                    }
                                }
                                onTextChanged: {
                                    pBar.pem = currentIndex
                                    rangeslider.pem = currentIndex
                                }
                            }

                            Text {
                                id:minTemp_foot
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("28.8℃")
                                color: "white"
                            }
                            XRangeSlider{
                                id:rangeslider
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 450
                                onFirChanged: {
                                    pBar.param_1 = parseInt(first.value * 255)
                                }
                                onSecChanged: {
                                    pBar.param_2 = parseInt(second.value * 255)
                                }
                            }
                            Text {
                                id:maxTemp_foot
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("28.8℃")
                                color: "white"
                            }
                            XTextBox{
                                height: 26
                                width: 30
                                text: "20"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("℃")
                                color: "white"
                            }
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("---")
                                color: "white"
                            }
                            XTextBox{
                                height: 26
                                width: 30
                                text: "50"
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("℃")
                                color: "white"
                            }
                        }
                    }
                }
            }
        }


        //pseudoColorContent
        PseudoColorBar{
            id:pBar
            anchors.top: parent.top
            anchors.right: tbar.left
            anchors.bottom: parent.bottom
            onCurrentIndexChanged: {
                rangeslider.refreshPseudoTable()
            }
        }


        //toolbar
        XToolBar{
            id:tbar
            anchors.right: parent.right
            onImgscalevalueChanged: {
                videoImg.width = videoContent.width * (parseInt(imgscalevalue) / 50)
                videoImg.height = videoContent.height * (parseInt(imgscalevalue) / 50)
            }
            onFreeVideoChanged: {
                if(freeVideo)
                {

                }
                else{

                }
            }


            onVideoRecTimeLengthChanged: {
                videotimer.text = videoRecTimeLength
            }


            onIsRecordingChanged: {
                videotimer.visible = isRecording
            }

            onResetVideo: {
                resetVideoLocation()
            }

            onIsReverseHChanged: {
                videoImg.isReverseH = isReverseH
            }

            onIsReverseVChanged: {
                videoImg.isReverseV = isReverseV
            }

            //拍照
            onCaptureImage: {
                //需要指定图像文件名称，不需要指定文件目录，只用文件名即可
                var filename = getNowFormatTime()
                pBar.previewImage = showImg.saveImage(filename + ".bmp")
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

    }


    function resetVideoLocation(){
        var w = videoContent.width
        var h = w * videoContent.imgOriginalHeight / videoContent.imgOriginalWidth
        if(h > videoContent.height - foot.height)
        {
            h = videoContent.height
            w = h * videoContent.imgOriginalWidth / videoContent.imgOriginalHeight

            videoImg.height = h
            videoImg.width = w

            videoImg.x = (videoContent.width - videoImg.width)/ 2
            videoImg.y = videoContent.y
            return
        }
        videoImg.height = h
        videoImg.width = w

        videoImg.x = videoContent.x
        videoImg.y = (videoContent.height - videoImg.height - foot.height)/2
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}
}
##^##*/
