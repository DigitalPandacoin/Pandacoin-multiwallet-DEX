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
            readonly property int   animationTime: 1200
            readonly property int   animationDelay: 50
            property bool           resetAnimation: false

            Layout.fillWidth: true
            Layout.fillHeight: true
            //Layout.preferredHeight: is_history ? parent.height - 70 : parent.height

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

            //onResetAnimationChanged:
            Component.onCompleted:
            {
                list.animationTimestamp = 0
                spawn_anim_timer.repeat = true
                console.log("OrderList parent.height = " + parent.height) // 1376
                console.log("OrderList height = " + height) // 0
                console.log("OrderList list.count = " + list.count)
                console.log("OrderList list.width = " + list.width)
                console.log("OrderList list.animationDelay = " + list.animationDelay)
                console.log("OrderList list.animationTime = " + list.animationTime)
                console.log("OrderList list.animationTimestamp = " + list.animationTimestamp)
                console.log("OrderList list.resetAnimation = " + list.resetAnimation)
                console.log("OrderList spawn_anim_timer.repeat = " + spawn_anim_timer.repeat)
                spawn_anim_timer.restart()
            }

            Timer
            {
                id: spawn_anim_timer
                interval: 50
                repeat: true
                onTriggered: () => {
                    list.animationTimestamp += interval
                    if (list.animationTimestamp > list.animationDelay * list.count + list.animationTime)
                        repeat = false
                    console.log("Timer list.animationTimestamp = " + list.animationTimestamp)
                    console.log("Timer repeat = " + repeat)
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
