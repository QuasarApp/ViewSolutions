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
                source:  modelData
                viewground: viewPort
                listView: viewPort
                width: viewPort.width

                height: root.height / 3
                title: "Test ViewPortPage"
                text: "Test ViewPortPage. General text and <i>html code</i>"
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


