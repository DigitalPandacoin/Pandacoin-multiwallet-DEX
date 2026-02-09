import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Qt.labs.settings 1.0

import Qaterial 1.0 as Qaterial

import AtomicDEX.MarketMode 1.0
import AtomicDEX.TradingError 1.0
import AtomicDEX.TradingMode 1.0
import App 1.0
import Dex.Themes 1.0 as Dex
import "../../../Components"
import "../../../Constants"

// Simple/Pro toggle group
Item
{
    // property var proViewChart
    property var proViewTrInfo
    property var proViewMarketsOrderBook
    property var proViewPlaceOrderForm

    Item
    {
        width: 350
        height: parent.height

        // Simple/Pro select cursor
        Rectangle
        {
            id: cursorRect
            width: _simpleLabel.width + 28
            height: _simpleLabel.height + 8
            radius: 8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: API.app.trading_pg.current_trading_mode == TradingMode.Simple ? _simpleLabel.horizontalCenter : _proLabel.horizontalCenter
            color: Dex.CurrentTheme.tabSelectedColor
        }

        DexLabel
        {
            id: _simpleLabel
            text: "Simple"
            color: API.app.trading_pg.current_trading_mode == TradingMode.Simple ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            anchors.leftMargin: 16
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
            font.weight: Font.Bold

            DexMouseArea
            {
                id: simple_area
                hoverEnabled: true
                anchors.fill: parent
                onClicked: API.app.trading_pg.current_trading_mode = TradingMode.Simple
            }
        }

        DexLabel
        {
            id: _proLabel
            text: "Pro"
            color: API.app.trading_pg.current_trading_mode == TradingMode.Pro ? Dex.CurrentTheme.foregroundColor : Dex.CurrentTheme.foregroundColor2
            anchors.left: _simpleLabel.right
            anchors.leftMargin: 10 + cursorRect.width / 2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
            font.weight: Font.Bold

            DexMouseArea
            {
                id: pro_area
                hoverEnabled: true
                anchors.fill: parent
                onClicked: API.app.trading_pg.current_trading_mode = TradingMode.Pro
            }
        }
    }

}
