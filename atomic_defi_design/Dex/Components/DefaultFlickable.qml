import QtQuick 2.15
import QtQuick.Controls 2.15

Flickable {
    id: root

    property bool scrollbar_visible: contentHeight > height
    property int rightMargin: 3

    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: DefaultScrollBar {
        policy: root.scrollbar_visible ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        anchors.rightMargin: root.rightMargin
    }

    clip: true
}
