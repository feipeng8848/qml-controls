var tempControlComp
var tempControl

function createTempControl() {
    tempControlComp = Qt.createComponent("./controls/XButton.qml");
    if (tempControlComp.status === Component.Ready)
    {
        tempControl = tempControlComp.createObject(xwindow, {x: 100, y: 100})
        tempControl.width = 120
        tempControl.height = 50
        tempControl.text = "txt"
    }
    else
    {
        tempControlComp.statusChanged.connect(finshedCreation)
    }

}

function set()
{
    tempControl.text = ""
}

function finshedCreation(){
    if (tempControlComp.status === Component.Ready)
    {
        tempControl = tempControlComp.createObject(xwindow, {x: 100, y: 100})
    }
}
