import QtQuick 2.0

Item {
    id:root
    width: 100
    height: 150

    property ListModel model

    Component.completed: {
        for (var i=0;i<model.count;i++)
        {
        }
    }


}
