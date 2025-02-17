//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {

    id: root
    property int titlesAligh: Text.AlignHCenter

    property font titlesFont: tokensModel.font_title_uppercase
    property alias rightSubtitleWidget: rightSubtitleControl.contentItem

    property bool closeButtonBorder: true
    property string title: ""
    property bool titleUppercase: true
    property string subTitle: ""
    property bool backButton: false
    property bool fullBackButton: false
    property bool closeButton: false
    property int headerRowHeight: 40

    signal backClicked()
    signal closeClicked()

    columns: 3

    Item {
        implicitWidth: headerRowHeight
        visible: !backButton && titlesAligh === Text.AlignHCenter
    }

    Button {

        // Layout.alignment: Qt.AlignLeft
        visible: backButton
        icon: (root.fullBackButton)? "qrc:/assets/icons/arrowleft_tac.svg"
                                   :"qrc:/assets/icons/arrowleft.svg"
        fontColor: tokensModel.color_text_secondary
        backgroundBorderColor: tokensModel.color_border_secondary
        isFlat: !root.fullBackButton
        text: root.fullBackButton? qsTr("Go Back"): ""
        Layout.preferredHeight: 24
        Layout.preferredWidth: (root.fullBackButton)? implicitWidth: 24
        leftPadding: (root.fullBackButton)? 16 : padding
        rightPadding: (root.fullBackButton)? 16 :padding
        baseHeaght: 16
        padding: 4
        customFocusPolicy: Qt.NoFocus

        onClicked: {
            backClicked()
        }
    }

    Text {
        id: centralTitle
        text: (titleUppercase)? root.title.toUpperCase(): root.title
        horizontalAlignment: root.titlesAligh
        font: titlesFont
        Layout.fillWidth: true;
        Layout.preferredHeight: 40
    }

    ToolButton {
        Layout.alignment: Qt.AlignRight
        icon: "qrc:/assets/icons/dismiss.svg"
        onClicked: closeClicked()
        visible: root.closeButton
        isFlat: !closeButtonBorder

        padding: 10
        baseHeaght: 20
        bordersSize: 2
        customFocusPolicy: Qt.NoFocus
        implicitHeight: headerRowHeight
    }

    Text {
        Layout.row: 1
        Layout.column: (backButton || titlesAligh === Text.AlignHCenter)? 1 : 0

        Layout.minimumHeight: 16
        visible: root.subTitle.length
        wrapMode: Text.WordWrap
        elide: Text.ElideNone
        Layout.fillWidth: true;
        text: root.subTitle
        color: tokensModel.color_text_tertiary
        font: tokensModel.font_subtitle_2
        horizontalAlignment: centralTitle.horizontalAlignment
    }

    Control {
        id: rightSubtitleControl
        Layout.row: 1
        Layout.column: 2

    }
}
