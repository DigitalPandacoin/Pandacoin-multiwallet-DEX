import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import App 1.0
import "../../../Components"
import "../../../"
import Dex.Themes 1.0 as Dex

Item
{
    id: root

    property string title
    property var    items
    property bool   is_history: false

    ColumnLayout
    {
        width: parent.width
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        HorizontalLine
        {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        DefaultListView
        {
            id: list

            property int            animationTimestamp: 0
            readonly property int   animationTime: 3600
            readonly property int   animationDelay: 100
            property bool           resetAnimation: false

            Layout.fillWidth: true
            Layout.preferredHeight: is_history ? parent.height - 70 : parent.height

            model: items.orders_proxy_mdl
            enabled: !is_history || !API.app.orders_mdl.fetching_busy
            visible: enabled

            // Row
            delegate: OrderLine
            {
                readonly property double anim_time: list.animationTimestamp > index * list.animationDelay ?
                    Math.min((list.animationTimestamp - index * list.animationDelay) / (list.animationTime), 1) : 0

                details: model
                opacity: anim_time
                width: list.width
            }

            populate: Transition
            {
                PropertyAction
                {
                    target: list
                    property: "resetAnimation"
                    value: !list.resetAnimation
                }
            }

            Component.onCompleted:
            {
                console.log("OrderList parent.height = " + parent.height) // 1376
                console.log("OrderList height = " + height) // 0
                console.log("OrderList list.count = " + list.count)
                //spawn_anim_timer.start()
            }

            onResetAnimationChanged:
            {
                list.animationTimestamp = 0
                spawn_anim_timer.repeat = true
                spawn_anim_timer.restart()
            }

            Timer
            {
                id: spawn_anim_timer
                interval: 100
                running: true
                repeat: true
                onTriggered: () => {
                    list.animationTimestamp += interval
                    if (list.animationTimestamp > list.animationDelay * list.count + list.animationTime)
                        repeat = false
                    console.log("OrderList list.animationTimestamp = " + list.animationTimestamp)
                    console.log("OrderList spawn_anim_timer.repeat = " + spawn_anim_timer.repeat)
                }
            }
        }

        Item
        {
            Layout.fillHeight: true
        }

        // Pagination
        DexPaginator
        {
            visible: is_history && list.count > 0
            enabled: list.enabled
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.bottomMargin: 10
            itemsPerPageComboBox.mainBackgroundColor: Dex.CurrentTheme.comboBoxBackgroundColor
            itemsPerPageComboBox.popupBackgroundColor: Dex.CurrentTheme.comboBoxBackgroundColor
        }
    }

    DexLabel
    {
        visible: list.count === 0
        anchors.centerIn: parent
        text: qsTr("No results found")
    }
}
