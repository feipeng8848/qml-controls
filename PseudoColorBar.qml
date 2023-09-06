import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "./controls"

Control{
    id:toolbar
    spacing: 15
    width: 80
    Layout.fillHeight: true
    property string textColor: "white"
    property string bgColor: "#3b3f48"
    property string hlColor: "#be3636"
    property int currentIndex:lv.currentIndex
    property int denoise
    //预览图图像fullname
    property string previewImage
    signal denoiseChange
    //伪彩效果模式修改
    property int pem
    property int param_1: 0
    property int param_2: 255

    function refresh(){
        switch (lv.currentIndex)
        {
        case 0:
            console.debug("case 0 白热")
            showImg.setWhiteHot()
            break;
        case 1:
            console.debug("case 1 黑热")
            showImg.setBlackHot()
            break;
        case 2:
            console.debug("case 2 cool")
            showImg.setCool()
            break;
        case 3:
            console.debug("case 3 骨蓝")
            showImg.setBone()
            break;
        case 4:
            console.debug("case 4 color")
            showImg.setColor()
            break;
        case 5:
            console.debug("case 5 Rain")
            showImg.setRain()
            break;
        case 6:
            console.debug("case 6 Rainbow")
            showImg.setRainbow()
            break;
        case 7:
            console.debug("case 7 sepia")
            showImg.setSepia()
            break;
        case 8:
            console.debug("case 8 Iron")
            showImg.setIron()
            break;
        case 9:
            console.debug("case 9 icefire")
            showImg.setIceFire()
            break;
        case 10:
            console.debug("case 10 globow")
            showImg.setGlobow()
            break;
        case 11:
            console.debug("case 11 绿火")
            showImg.setGreenFire()
            break;
        }
    }

    Connections{
            target: toolbar
            function onDenoiseChange(){
                showImg.set_denoise(denoise)
                refresh()
            }
            function onPemChanged(){
                switch(pem)
                {
                case 0:
                    showImg.closePEM()
                    console.debug("close eff")
                    break
                case 1:
                    showImg.setPEM_1()
                    console.debug("eff1")
                    break
                case 2:
                    showImg.setPEM_2()
                    console.debug("eff2")
                    break
                case 3:
                    showImg.setPEM_3()
                    console.debug("eff3")
                    break
                }
                refresh()
            }
            function onParam_1Changed(){
                console.debug("param_1: " + param_1)
                showImg.set_param1(param_1)
                refresh()
            }
            function onParam_2Changed(){
                console.debug("param_2: " + param_2)
                showImg.set_param2(param_2)
                refresh()
            }
        }


    background: Rectangle{
        anchors.fill:toolbar
        color: bgColor
    }
    contentItem: Control{
        ListView{
                id:lv
                anchors.bottom: imgView.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                highlightMoveDuration: 200
                highlightMoveVelocity: -1
                highlight: Rectangle { color: hlColor;}
                model: ListModel {
                    id: imgPathList
                    ListElement {
                        path: "/img/whitehot.png"
                        name:"白    热"
                    }
                    ListElement {
                        path: "/img/blackhot.png"
                        name:"黑    热"
                    }
                    ListElement {
                        path: "/img/pinkblue.png"
                        name:"粉    蓝"
                    }
                    ListElement {
                        path: "/img/boneblue.png"
                        name:"骨    蓝"
                    }
                    ListElement {
                        path: "/img/colorfulwhite.png"
                        name:"炫    白"
                    }
                    ListElement {
                        path: "/img/colorful.png"
                        name:"炫    彩"
                    }
                    ListElement {
                        path: "/img/rainbow.png"
                        name:"彩    虹"
                    }
                    ListElement {
                        path: "/img/autumn.png"
                        name:"金    秋"
                    }
                    ListElement {
                        path: "/img/ironred.png"
                        name:"铁    红"
                    }
                    ListElement {
                        path: "/img/icefire.png"
                        name:"冰    火"
                    }
                    ListElement {
                        path: "/img/globow.png"
                        name:"寰    红"
                    }
                    ListElement {
                        path: "/img/greenfire.png"
                        name:"绿    火"
                    }
                }
                delegate: RadioButton{
                    width: 80
                    height: 75
                    contentItem: Rectangle{
                        Image {
                            source: path
                            width: parent.width
                            height: parent.height
                        }
                        Text {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -1
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: "#FFFFFF"
                            font.pixelSize: 11
                            font.letterSpacing: 0
                            text: qsTr(name)
                        }
                    }

                    onClicked: {
                        onClicked: lv.currentIndex = index
                    }                    
                }                

                onCurrentIndexChanged: {
                    //调用具体的逻辑
                    refresh()
                }
        }

        Rectangle {
            id:imgView
            width: 80
            height: 80
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            color: bgColor
            Image {
                id:img
                width: 60
                height: 60
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                source: "/img/Video.png"

                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        showImg.showImageFolder(appSetting.getImageSavePath())
                    }
                }
            }


        }
    }


    onPreviewImageChanged: {
        console.debug(previewImage)
        var filename = "file:///" + previewImage
        img.source = filename
    }
}
