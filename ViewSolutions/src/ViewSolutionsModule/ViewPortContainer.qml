import QtQuick 2.14
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Controls.Universal 2.14

ListView {
    id: root



    property var viewPortDelegat: null
    onViewPortDelegatChanged: {
        if (viewPortDelegat && viewPortDelegat instanceof ViewPortDelegat) {
            viewPortDelegat.viewground = root
            if (delegateItem)
                viewPortDelegat.parent = delegateItem

        }
    }

    Component {
        id: baseDelegate
        Item {
            id: delegateItem

            width: viewPortDelegat.width
            height: viewPortDelegat.height

            Component.onCompleted:  {
                if (viewPortDelegat)
                    viewPortDelegat.parent = delegateItem
            }
        }
    }

    delegate: baseDelegate
}
