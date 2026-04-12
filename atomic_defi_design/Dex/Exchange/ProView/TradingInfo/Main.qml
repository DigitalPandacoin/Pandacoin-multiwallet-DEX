import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import Qaterial 1.0 as Qaterial

import Dex.Themes 1.0 as Dex
import Dex.Components 1.0 as Dex
import AtomicDEX.MarketMode 1.0
import "../../../Constants"
import "../../../Components"
import "../../Trade"
import "../../ProView"

ColumnLayout
{
    Layout.preferredWidth: 450
    Layout.fillHeight: true
    property alias currentIndex: tabView.currentIndex

    Qaterial.LatoTabBar
    {
        id: tabView
        property int pair_chart_idx: 0
        property int order_idx: 1
        property int history_idx: 2

        background: null
        Layout.leftMargin: 6

        Qaterial.LatoTabButton
        {
            text: qsTr("Chart")
            font.pixelSize: 14
            textColor: checked ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            textSecondaryColor: Dex.CurrentTheme.foregroundColor2
            indicatorColor: Dex.CurrentTheme.foregroundColor
        }
        Qaterial.LatoTabButton
        {
            text: qsTr("Orders")
            font.pixelSize: 14
            textColor: checked ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            textSecondaryColor: Dex.CurrentTheme.foregroundColor2
            indicatorColor: Dex.CurrentTheme.foregroundColor
        }
        Qaterial.LatoTabButton
        {
            text: qsTr("History")
            font.pixelSize: 14
            textColor: checked ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            textSecondaryColor: Dex.CurrentTheme.foregroundColor2
            indicatorColor: Dex.CurrentTheme.foregroundColor
        }
    }

    Rectangle
    {
        Layout.preferredWidth: 450
        Layout.preferredHeight: parent.height - tabView.height - 32
        color: Dex.CurrentTheme.floatingBackgroundColor
        radius: 10

        Qaterial.SwipeView
        {
            id: swipeView
            interactive: false
            currentIndex: tabView.currentIndex
            anchors.fill: parent
            clip: true

            ColumnLayout
            {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.topMargin: 8
                spacing: 7
                visible: currentIndex === tabView.pair_chart_idx
                enabled: visible

                TickerSelectors
                {
                    id: selectors
                    Layout.preferredWidth: 435
                    Layout.preferredHeight: 85
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8
                }

                Chart
                {
                    id: chart
                    Layout.preferredWidth: 435
                    Layout.fillHeight: true
                    Layout.topMargin: 8
                    Layout.leftMargin: 5
                    Layout.rightMargin: 5
                }

                PriceLineSimplified
                {
                    id: price_line
                    Layout.preferredWidth: 435
                    Layout.preferredHeight: 40
                    Layout.bottomMargin: 12
                    Layout.leftMargin: 5
                    Layout.rightMargin: 5
                }
            }

            OrdersPage
            {
                page_index: currentIndex
                visible: currentIndex === tabView.order_idx
                enabled: visible
            }

            OrdersPage
            {
                page_index: currentIndex
                is_history: true
                visible: currentIndex === tabView.history_idx
                enabled: visible
            }

            onCurrentIndexChanged:
            {
                if (currentIndex !== tabView.pair_chart_idx) {
                    swipeView.currentItem.update()
                }
            }
        }
    }
}
