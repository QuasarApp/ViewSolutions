import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14

import ViewSolutionsModule 1.0

Page {
    id: root
    ListModel {
        id: myModel
        ListElement { type: "Dog"; age: 8 }
        ListElement { type: "Cat"; age: 5 }
    }

    ViewPortContainer {
        anchors.fill: parent
        viewPortDelegat: ViewPortDelegat {
            background:  "qrc:/img/res/LOGO.png"
            anchors.margins: 20
        }

        model: myModel
    }
}


