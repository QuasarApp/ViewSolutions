import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import ViewSolutionsModule 1.0

Page {
    id: root

    ListView {
        id: viewPort
        property real globalPos: 0
        anchors.fill: parent
        delegate: Component {
            ViewPortGradientPage {
                source:  modelData
                viewground: root
                height: root.height / 3
                title: "Test ViewPortPage"
                text: "Test ViewPortPage. General text and <i>html code</i>"
                contentX: viewPort.contentX
                contentY: viewPort.contentY

            }
        }

        ScrollBar.vertical: ScrollBar {
        }


        model: [
            "qrc:/img/res/LOGO.png",
            "qrc:/img/res/LOGO-GREAN.png",
            "qrc:/img/res/LOGO-ORANGE.png",
            "qrc:/img/res/LOGO-RED.png",
            "qrc:/img/res/LOGO.png",
            "qrc:/img/res/LOGO-GREAN.png",
            "qrc:/img/res/LOGO-ORANGE.png",
            "qrc:/img/res/LOGO-RED.png",
            "qrc:/img/res/LOGO.png",
            "qrc:/img/res/LOGO-GREAN.png",
            "qrc:/img/res/LOGO-ORANGE.png",
            "qrc:/img/res/LOGO-RED.png",
            "qrc:/img/res/LOGO.png",
            "qrc:/img/res/LOGO-GREAN.png",
            "qrc:/img/res/LOGO-ORANGE.png",
            "qrc:/img/res/LOGO-RED.png",
            "qrc:/img/res/LOGO.png",
            "qrc:/img/res/LOGO-GREAN.png",
            "qrc:/img/res/LOGO-ORANGE.png",
            "qrc:/img/res/LOGO-RED.png",
        ]
    }
}


