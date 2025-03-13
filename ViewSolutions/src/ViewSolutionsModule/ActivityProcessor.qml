//#
//# Copyright (C) 2020-2025 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


import QtQuick
import QtQuick.Controls

Page {
    id: root

    // use Comonent delegates only
    property alias initialItem: stackView.initialItem
    property alias currentItem: stackView.currentItem
    property int titlesAligh: Text.AlignLeft

    property alias depth: stackView.depth
    property bool cache: true
    property bool enableHeader: true

    padding: 0
    clip: true

    background: Item{}

    header: ActivityProcessorHeader {
        id: headerView
        visible: root.enableHeader
        title: {
            if (root.enableHeader && stackView.currentItem && stackView.currentItem.title) {
                return stackView.currentItem.title
            }

            return ""
        }

        backButton:  root.enableHeader && stackView.depth > 1 &&  (stackView.currentItem && stackView.currentItem.buttonBack)

        closeButton: root.enableHeader && (stackView.currentItem && stackView.currentItem.closeButton)
        titlesAligh: root.titlesAligh
        onBackClicked: {
            root.popItem()
        }

    }

    contentItem: StackView {
        id: stackView

        property var link : root

        Connections {
            target: (stackView.currentItem && stackView.currentItem.finish)? stackView.currentItem : null

            function onFinish() {
                root.popItem()
            }
        }

        padding: 0

        implicitWidth: (stackView.currentItem)? stackView.currentItem.implicitWidth: 0
        implicitHeight: (stackView.currentItem)? stackView.currentItem.implicitHeight: 0

        property int durationAnimation: 400
        popEnter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 0
                    to: 1
                    duration: stackView.durationAnimation
                }
                NumberAnimation {
                    properties: "x"
                    from: (stackView.mirrored ? -1 : 1) * -stackView.width
                    to: 0
                    duration: stackView.durationAnimation
                    easing.type: Easing.OutCubic
                }
            }
        }

        popExit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: stackView.durationAnimation / 2
                }
                NumberAnimation {
                    properties: "x"
                    from: 0
                    to: (stackView.mirrored ? -1 : 1) * stackView.width
                    duration: stackView.durationAnimation
                    easing.type: Easing.OutCubic
                }
            }
        }

        pushEnter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 0
                    to: 1
                    duration: stackView.durationAnimation
                }
                NumberAnimation {
                    properties: "x"
                    from: (stackView.mirrored ? -1 : 1) * stackView.width
                    to: 0
                    duration: stackView.durationAnimation
                    easing.type: Easing.OutCubic
                }
            }
        }

        pushExit: Transition {
            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: stackView.durationAnimation / 2
                }
                NumberAnimation {
                    properties: "x"
                    from: 0
                    to: (stackView.mirrored ? -1 : 1) * -stackView.width
                    duration: stackView.durationAnimation
                    easing.type: Easing.OutCubic
                }
            }
        }
    }


    // create new activity from component with model activityModel, after drop this activity will be called callback function
    // Note The callback function works only with ActivityPage childs.
    function newActivityFromComponent(component, activityModel, callback) {
        var activity = component.createObject(stackView);
        if (activity === null) {
            // Error Handling
            console.error("Error creating Activity object. " + component.errorString());
            return;
        }

        if (activityModel && typeof(activity.model) != "undefined") {
            activity.model = activityModel;
        }


        if (typeof(activity.activityCallBack) === "function"
                && typeof(callback) === "function") {
            activity.activityCallBack = callback;
        }
        stackView.push(activity);

        return activity;
    }

    // create new activity from file with model activityModel, after drop this activity will be called callback function
    // Note The callback function works only with ActivityPage childs.
    function newActivity(viewFile, activityModel, callback) {

        if (!viewFile || !viewFile.length) {
            console.error("Failed to create activity. view object is invalid");
            return;
        }

        var component = Qt.createComponent(viewFile);

        if (component.status === Component.Ready) {


            var activity = component.createObject(stackView);
            if (activity === null) {
                // Error Handling
                console.error("Error creating Activity object");
                return;
            }

            if (activityModel && typeof(activity.model) != "undefined") {
                activity.model = activityModel;
            }


            stackView.push(activity);

            if (typeof(activity.activityCallBack) === "function"
                    && typeof(callback) === "function") {
                activity.activityCallBack = callback;
            }

            return activity;

        } else if (component.status === Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    // create new activity from file with custom propery list "properties", after drop this activity will be called callback function
    // Note The callback function works only with ActivityPage childs.
    function newActivityWithProp(viewFile, properties, callback) {

        if (!viewFile || !viewFile.length) {
            console.error("Failed to create activity. view object is invalid");
            return;
        }

        var component = Qt.createComponent(viewFile);

        if (component.status === Component.Ready) {

            var activity = component.createObject(stackView, properties);
            if (activity === null) {
                // Error Handling
                console.error("Error creating Activity object");
                return;
            }

            stackView.push(activity);

            if (typeof(activity.activityCallBack) === "function"
                    && typeof(callback) === "function") {
                activity.activityCallBack = callback;
            }
            return activity;

        } else if (component.status === Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    // create new activity from component with custom propery list "properties", after drop this activity will be called callback function
    // Note The callback function works only with ActivityPage childs.
    function newActivityFromComponentWithProp(component, properties, callback) {

        var activity = component.createObject(stackView, properties);
        if (activity === null) {
            // Error Handling
            console.error("Error creating Activity object. " + component.errorString());
            return;
        }

        stackView.push(activity);

        if (typeof(activity.activityCallBack) === "function"
                && typeof(callback) === "function") {
            activity.activityCallBack = callback;
        }

        return activity;
    }

    function popItem() {
        let actionRequire = stackView.currentItem && stackView.currentItem.requireAction && stackView.currentItem.requireAction();

        if (actionRequire) {
            return false;
        }

        var item = stackView.pop();
        if (item) {
            if (item.activityCallBack) {
                item.activityCallBack()
            }
            item.destroy(1000);
        }

        return true;
    }

    function resetState() {
        if (cache && stackView.depth < 3) {

            // About limitation: the stackView.pop can't change focus to first element if the elements depth bigger then 2.

            while(stackView.depth > 1) {
                if (!popItem()) {
                    break;
                }
            }
            if (stackView.currentItem && typeof(stackView.currentItem.resetState) === "function") {
                stackView.currentItem.resetState();
            }

        } else {
            stackView.clear()
            stackView.push(stackView.initialItem)
        }
    }

}
