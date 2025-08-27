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
import QtQuick.Effects

Page {
    id: root

    property var guiTokens: modelsStorage.getModel("GUITokens")
    property bool readyToRun: false
    property int slide: 0;
    property alias mainContent: mainLabel.contentItem
    property int slideDuration: 8000
    property int animationDurattion: 1000
    property bool busyIndicator: true

    property string readyMessage: qsTr("World is ready to play : Press any button to play")
    property string defaultMessage: qsTr("Generation of a huge world")
    property int prefferedContentWidth: 900

    signal ready();

    function startSlideShow() {
        mainLabel.opacity = 0;
        root.slide = 0;
        mainLabelSideAnimation.restart();
    }

    padding: 32

    contentItem: ColumnLayout {
        spacing: 24

        Control {
            id: mainLabel

            opacity: 0

            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.prefferedContentWidth
            Layout.fillHeight: true


            SequentialAnimation {
                id: mainLabelSideAnimation
                running: true

                NumberAnimation {
                    target: mainLabel;
                    property: "opacity";
                    easing.type: Easing.InQuint
                    to: 1;
                    duration: root.animationDurattion
                }

                PauseAnimation {
                    duration: root.slideDuration
                }

                NumberAnimation {
                    target: mainLabel;
                    property: "opacity";
                    easing.type: Easing.OutQuint
                    to: 0.0;
                    duration: root.animationDurattion

                }

                PauseAnimation {
                    duration: 100
                }

                onFinished: {
                    root.slide ++;
                    mainLabelSideAnimation.start();

                }

            }

        }


        RowLayout {

            spacing: 16

            BusyIndicator {
                opacity: 0
                visible: !root.readyToRun && root.busyIndicator
                running: true
            }

            Item {
                Layout.fillWidth: true

                id: loadingTextBox

                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite

                    NumberAnimation {
                        target: loadingTextBox;
                        property: "opacity";
                        easing.type: Easing.OutQuad
                        to: 1;
                        duration: {
                            if (root.readyToRun) {
                                return 500;
                            }

                            return 2000
                        }
                    }

                    NumberAnimation {
                        target: loadingTextBox;
                        property: "opacity";
                        easing.type: Easing.InQuad
                        to: 0.5;
                        duration: {
                            if (root.readyToRun) {
                                return 500;
                            }

                            return 2000
                        }
                    }
                }

                Label {
                    id: loadingText
                    text: {
                        if (root.readyToRun) {
                            return root.readyMessage
                        }

                        return root.defaultMessage
                    }


                    font: root.guiTokens.font_subtitle_1
                    color: root.guiTokens.color_text_secondary

                    anchors.centerIn: parent
                }

                MultiEffect {
                    source: loadingText
                    anchors.fill: loadingText
                    shadowBlur: 1.0
                    shadowEnabled: true
                    shadowColor: root.guiTokens.color_accent_primary
                    shadowScale: 1.1
                }

            }


            BusyIndicator {
                visible: !root.readyToRun && root.busyIndicator
                running: true


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


    Keys.onPressed: (event) => {
                        if (root.readyToRun) {
                            root.ready();
                        }
                    }
}
