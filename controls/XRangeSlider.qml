import QtQuick 2.0
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

RangeSlider {
    id:root
    width: 100
    height: 31
    first.value: 0
    second.value: 1

    property real fir: first.value
    property real sec: second.value
    //伪彩效果模式修改
    //pseudo effect mode
    // 0:close  1:effect_1    2:effect_2
    property int pem

    background: LinearGradient {
        id:bg
        width:secendhandle.x - firsthandle.x
        x:firsthandle.x + 5
        height: 14;
        anchors.verticalCenter: parent.verticalCenter
        gradient: Gradient {
            GradientStop{ id:gs_0; position: 0; }
            GradientStop{ id:gs_1; position: 0.1; }
            GradientStop{ id:gs_2; position: 0.2; }
            GradientStop{ id:gs_3; position: 0.3; }
            GradientStop{ id:gs_4; position: 0.4; }
            GradientStop{ id:gs_5; position: 0.5; }
            GradientStop{ id:gs_6; position: 0.6; }
            GradientStop{ id:gs_7; position: 0.7; }
            GradientStop{ id:gs_8; position: 0.8; }
            GradientStop{ id:gs_9; position: 0.9; }
            GradientStop{ id:gs_10; position: 1;}
        }
        start: Qt.point(0, 0);
        end: Qt.point(width, 0);
    }

    first.handle: Control {
        id: firsthandle
        x: root.first.visualPosition * (root.width ) - root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: 12
        height: 31
        background:Image {
            source: "../img/leftHandle.png"
        }
    }
    second.handle: Control{
        id:secendhandle
        x: root.second.visualPosition * (root.width) - root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: 12
        height:31
        background:Image {
            source: "../img/rightHandle.png"
        }
    }
    //更新伪彩显示条
    function refreshPseudoTable() {
        console.debug("pseudoListrgb.legth is :"+showImg.pseudoList_rgb.length)
        gs_0.color = showImg.pseudoList_rgb[0]
        var index = parseInt(265*gs_1.position)
        gs_1.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_2.position)
        gs_2.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_3.position)
        gs_3.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_4.position)
        gs_4.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_5.position)
        gs_5.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_6.position)
        gs_6.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_7.position)
        gs_7.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_8.position)
        gs_8.color = showImg.pseudoList_rgb[index]
        index =  parseInt(265*gs_9.position)
        gs_9.color = showImg.pseudoList_rgb[index]
        gs_10.color = showImg.pseudoList_rgb[255]
    }

    //不同的效果两个推子要有相关的使能效果，自定义高温只能右边的推子使能，自定义高低温才两个推子都使能
    function noEffectMode(){
        console.debug("close effect")
        firsthandle.enabled = false
        secendhandle.enabled = false
    }
    function effect_1(){
        console.debug("effect_1")
        firsthandle.enabled = true
        secendhandle.enabled = true
    }
    function effect_2(){
        console.debug("effect_2")
        firsthandle.enabled = true
        secendhandle.enabled = true
    }
    function effect_3(){
        noEffectMode()
    }

    onPemChanged: {
        switch(pem)
        {
        case 0:
            noEffectMode()
            break
        case 1:
            effect_1()
            break
        case 2:
            effect_2()
            break
        case 3:
            effect_3()
            break
        }

    }


}
