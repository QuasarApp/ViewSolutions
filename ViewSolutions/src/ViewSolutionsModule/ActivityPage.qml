//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls

Control {
    property string title: ""

    // shows the back button with text
    property bool buttonBack: true

    // shows the header of the ActivityProcessor (if is it not to abble atomaticaly)
    property bool headerVisible: true


    // shows close button on the ActivityProcessor header
    property bool closeButton: true
    // attach to this property link to ActivityProcessor (if is it not to abble atomaticaly)
    property var activityProcessorLink: (parent && parent.link)? parent.link: null

    // emit this signal when you finish work on this page. The ActivityProcessor will inoke pop method.
    signal finish();

    // invoked by ActivityProcessor when the will be invoked resetState of ActivityProcessor
    property var resetState: () => {}

    // this is lambda function with required action of this page.
    // If is it not null then MainActivityProcessor will execute this action and forbide distroy this UI.
    property var requireAction: null

    // This is call back function, If this function exists its will be called before pop object from main activity, but if requireAction is null.
    // Note: this field will fill if you add callback function on newActivityWithProp, newActivity or newActivityFromComponent functions!
    property var activityCallBack: () => {}
    property bool saveChangesInUnsaved: false

}
