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

        if (background) {
            background.parent = this;
            background.anchors.fill = this;
            background.z = 0;
        }

        flickable.z = 1;

        if (bloor) {
            bloor.parent = this;
            bloor.anchors.fill = this;
            bloor.z = 2;
        }

        if (content) {
            content.parent = this;
            content.anchors.fill = this;
            content.z = 3;
        }
    }

    Flickable {
        id: flickable
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
