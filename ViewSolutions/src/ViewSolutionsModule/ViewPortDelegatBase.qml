import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Universal 2.14

Item {
    id: delegateItem

    property string source: ""
    property var background: Rectangle {
        border.color: "black"
        anchors.fill: parent
        color: "#00000000"

    }

    property var bloor: Item {
    }

    property var viewground: null
    property real scrollPos: 0
    property int imageMrgin: 5

    property var theme: Material.theme
    property string baseLigtColor: "fafafa"
    property string baseDarkColor: "242424"
    property string baseColor: (theme === Material.Dark)? baseDarkColor: baseLigtColor


    property int viewPortDelegatW: 0
    property int viewPortDelegatH: 0
    property var content: Item {
        anchors.fill: parent
    }

    onBackgroundChanged:{
        updateLayout()
    }

    onContentChanged:{
        updateLayout()
    }

    onBloorChanged:{
        updateLayout()
    }

    width: (viewPortDelegatW)? viewPortDelegatW: (viewground)? viewground.width : 0
    height:  (viewPortDelegatH)? viewPortDelegatH: (viewground)?viewground.height * 0.1 : 0

    onScrollPosChanged: {
        updatePos();
    }

    function updatePos() {
        if (!viewground) {
            return ;
        }

        const viewGlobal = viewground.mapToGlobal(0, 0);
        const img = flickable.mapFromGlobal(viewGlobal.x, viewGlobal.y);

        flickable.contentX = -img.x;
        flickable.contentY = -img.y;
    }

    function updateLayout() {


        if (background !== flickable.backgroundOld) {
            if (flickable.backgroundOld) {
                flickable.backgroundOld.destroy()
            }

            background.parent = this;
            background.anchors.fill = this;
            background.z = 0;
            flickable.backgroundOld = background
        }

        flickable.z = 1;

        if (bloor !== flickable.bloorOld) {
            if (flickable.bloorOld) {
                flickable.bloorOld.destroy()
            }
            bloor.parent = this;
            bloor.anchors.fill = this;
            bloor.z = 2;
            flickable.bloorOld = bloor

        }

        if (content !== flickable.contentOld) {
            if (flickable.contentOld) {
                flickable.contentOld.destroy()
            }
            content.parent = this;
            content.anchors.fill = this;
            content.z = 3;
            flickable.contentOld = content

        }
    }

    Flickable {
        id: flickable

        property var backgroundOld: Item {
        }
        property var bloorOld: Item {
        }
        property var contentOld: Item {
        }


        contentWidth: viewground.width
        contentHeight: viewground.height
        clip: true
        interactive: false

        Image {
            id: image;
            source: delegateItem.source

            fillMode: Image.PreserveAspectFit
            anchors.fill: parent

        }

        anchors.fill: parent
        anchors.margins: imageMrgin
    }


}
