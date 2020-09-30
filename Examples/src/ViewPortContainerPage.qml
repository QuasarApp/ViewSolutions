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
            ViewPortPage {
                scrollPos: viewPort.globalPos
                source:  modelData
                viewground: root
                title: "Test ViewPortPage"
                text: "Test ViewPortPage. General text and <i>html code</i>"
            }
        }

        ScrollBar.vertical: ScrollBar {
            onPositionChanged: {
                viewPort.globalPos = position
            }
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


