import QtQuick 2.15
import QtQuick.Layouts 1.15
import Dex.Components 1.0 as Dex
import Dex.Themes 1.0 as Dex
import "../Constants" as Dex

Dex.MultipageModal
{
    id: root
    width: 560

    property string standard

    signal selected(var assetTicker)

    Component.onDestruction:
    {
        Dex.API.app.portfolio_pg.global_cfg_mdl.all_qrc20_proxy.setFilterFixedString("")
        Dex.API.app.portfolio_pg.global_cfg_mdl.all_erc20_proxy.setFilterFixedString("")
        Dex.API.app.portfolio_pg.global_cfg_mdl.all_bep20_proxy.setFilterFixedString("")
        Dex.API.app.portfolio_pg.global_cfg_mdl.all_smartchains_proxy.setFilterFixedString("")
    }

    Dex.MultipageModalContent
    {
        titleText: qsTr("Choose a valid ") + standard + qsTr(" asset")
        contentSpacing: 8
        flickMax: window.height - 20

        Dex.SearchField
        {
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            Layout.rightMargin: 20
            textField.placeholderText: qsTr("Search an asset")
            textField.onTextChanged:
            {
                switch (standard)
                {
                case "QRC-20": Dex.API.app.portfolio_pg.global_cfg_mdl.all_qrc20_proxy.setFilterFixedString(textField.text)
                    break;
                case "ERC-20": Dex.API.app.portfolio_pg.global_cfg_mdl.all_erc20_proxy.setFilterFixedString(textField.text)
                    break;
                case "BEP-20": Dex.API.app.portfolio_pg.global_cfg_mdl.all_bep20_proxy.setFilterFixedString(textField.text)
                    break;
                default: Dex.API.app.portfolio_pg.global_cfg_mdl.all_smartchains_proxy.setFilterFixedString(textField.text)
                    break;
                }
            }
        }

        Dex.ListView
        {
            id: list
            Layout.preferredHeight: 420
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.rightMargin: 20
            spacing: 8

            model: standard == "QRC-20" ? Dex.API.app.portfolio_pg.global_cfg_mdl.all_qrc20_proxy :
                   standard == "ERC-20" ? Dex.API.app.portfolio_pg.global_cfg_mdl.all_erc20_proxy :
                   standard == "BEP-20" ? Dex.API.app.portfolio_pg.global_cfg_mdl.all_bep20_proxy :
                                          Dex.API.app.portfolio_pg.global_cfg_mdl.all_smartchains_proxy

            delegate: Item
            {
                width: list.width
                height: 40

                Dex.Rectangle
                {
                    anchors.fill: parent
                    color: mouseArea.containsMouse ? Dex.CurrentTheme.buttonColorHovered : "transparent"
                }

                AssetRow
                {
                    id: assetRow
                    height: parent.height
                    ticker: model.ticker
                    type: model.type
                    name: model.name
                }

                Dex.Text
                {
                    visible: !model.enabled
                    anchors.left: assetRow.right
                    anchors.leftMargin: 6
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Disabled")
                    color: Dex.CurrentTheme.warningColor
                    font: Dex.DexTypo.caption
                }

                Dex.MouseArea
                {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.selected(model.ticker)
                }
            }
        }
    }
}
