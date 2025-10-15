/*
 * Copyright (C) 2018-2024 QuasarApp.
 * Distributed under the GPLv3 software license, see the accompanying
 * Everyone is permitted to copy and distribute verbatim copies
 * of this license document, but changing it is not allowed.
*/

import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id : root;
    readonly property var model: notificationService;
    readonly property var msg: model.notify
    readonly property var qst: model.question

    readonly property var history: model.history

    NotificationForm {
        id: notyfyView
        titleText : root.msg.title();
        text: (root.msg)? root.msg.text(): "";
        img: (root.msg && root.msg.img().length)? root.msg.img(): getDefaultImage((root.msg)? root.msg.type(): 0);
        type: (root.msg)? root.msg.type(): 0;

        x: parent.width - width - margin;
        y: margin;

        width: Math.min(440, root.width);

    }

    YesNoQuestion {
        id: questionMsgBox
        titleText : root.qst.title();
        text: (root.qst)? root.qst.text(): "";
        img: (root.qst && root.qst.img().length)? root.qst.img(): defImg;
        type: 0;

        x: parent.width / 2  - width / 2;
        y: parent.height / 2 - height / 2;

        width: Math.min(440, root.width);

        onAccepted: {
            if (root.model) {
                root.model.questionComplete(true, root.qst.type())
            }
        }

        onRejected: {
            if (root.model) {
                root.model.questionComplete(false, root.qst.type())
            }
        }
    }

    onMsgChanged: {

        if (msg.isValid()) {
            notyfyView._show();
        }
    }

    onQstChanged: {
        if (qst.isValid()) {
            questionMsgBox._show();
        }
    }

    NotificationHistoryView {
        id: history
        width: Math.min(Math.max(Math.min(parent.width * 0.6, 1024 ), 320), parent.width)
        height: Math.min(Math.max(Math.min(parent.height * 0.6, 720), 240), parent.height)

        anchors.centerIn: parent
    }

    Connections {
        target: root.model
        function onSigShowHistory() {
            history.open()
        }
    }
}
