//#
//# Copyright (C) 2025-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ViewSolutions
import QtQuick.Effects

Control {
    id: root
    padding: 24

    required property var guiTokens
    property alias text: model.fullText;
    property alias delimiter: model.delimiter
    property alias delegate: contentList.delegate
    readonly property bool isFinished: contentList.currentIndex >= contentList.count - 1

    function next() {
        if (nextButton.visible) {
            nextButton.click()
        }
    }

    contentItem: ColumnLayout {
        ListView {
            id: contentList
            currentIndex: 0
            interactive: false
            // snapMode: ListView.SnapOneItem
            boundsBehavior:Flickable.StopAtBounds
            Layout.fillWidth: true
            Layout.fillHeight: true

            model: StackTextModel {
                id: model;

                onFullTextChanged: {
                    contentList.currentIndex = 0;
                }
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignHCenter


            id: nextButton
            text: qsTr("Next")
            visible: contentList.count > 1 && contentList.currentIndex < contentList.count - 1
            opacity: visible

            Behavior on opacity {
                NumberAnimation {
                    easing.type: Easing.InOutQuad
                    duration: 300
                }
            }

            font: root.font

            onClicked: {
                if (contentList.currentIndex + 1 >= contentList.count) {
                    contentList.currentIndex = 0;
                    return;
                }
                contentList.currentIndex = contentList.currentIndex + 1;
            }

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowBlur: 1.0
                shadowEnabled: true
                shadowColor: root.guiTokens.color_accent_primary
                shadowScale: 1.0
            }

        }
    }

}
