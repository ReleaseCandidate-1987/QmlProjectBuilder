import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import "Controls"
import "Core"

import QtQml.Models

/**
 * Stellt die Auswahl vordefinierter Fensterauflösungen bereit.
 *
 * Die verfügbaren Auflösungen werden nach dem ausgewählten Betriebssystem
 * beziehungsweise Gerätetyp gefiltert und in die Größenfelder übernommen.
 */
RowLayout {
    id: detailsPaneResolution
    spacing: 16

    /**
     * Zeigt die gefilterten Auflösungen an und übernimmt die ausgewählte Größe.
     */
    MaterialComboBox {
        id: cbSizes
        Layout.fillWidth: true

        currentIndex: appSettings.sizesIndex

        /**
         * Enthält alle verfügbaren Auflösungen und die zugehörigen Gerätetypen.
         */
        ResolutionModel { id: resolutionModel }

        /**
         * Beschränkt das Auflösungsmodell auf den aktuell ausgewählten Gerätetyp.
         */
        SortFilterProxyModel {
            id: filterModel
            model: resolutionModel

            filters: [
                FunctionFilter {
                    component RoleData: QtObject {
                        property string os
                    }

                    /**
                     * Prüft, ob ein Eintrag zum ausgewählten Gerätetyp gehört.
                     *
                     * @param data Enthält den Gerätetyp des aktuellen Modelleintrags.
                     * @return true, wenn der Eintrag dem aktiven Filter entspricht.
                     */
                    function filter(data: RoleData): bool {
                        return data.os === appSettings.resolutionOs
                    }
                }
            ]

            Component.onCompleted: {
                filterModel.invalidate()
                cbSizes.currentIndex = appSettings.sizesIndex
            }
        }

        model: filterModel
        textRole: "name"

        onCurrentIndexChanged: {
            if (currentIndex < 0)
                return

            const proxyIndex = filterModel.index(currentIndex, 0)
            const sourceIndex = filterModel.mapToSource(proxyIndex)

            if (sourceIndex.row < 0)
                return

            const obj = resolutionModel.get(sourceIndex.row)

            tfWidth.text = obj.width
            tfHeight.text = obj.height
            appSettings.sizesIndex = currentIndex
        }
    }

    /**
     * Öffnet das Filtermenü für die Auswahl des gewünschten Gerätetyps.
     */
    MaterialRoundButton {
        id: btnFilter
        icon.source: Icons.filter_alt

        /**
         * Stellt das Filtermenü für andere Komponenten bereit.
         */
        property alias menu: menu

        onClicked: {
            if (menu.visible)
                return

            menu.popup()
        }

        /**
         * Zeigt die verfügbaren Geräte- und Betriebssystemgruppen an.
         */
        MaterialMenu {
            id: menu

            Repeater {
                id: repeater
                model: ["Desktop", "iOS", "iPadOS", "Android", "Android Tablet"]

                /**
                 * Aktiviert den ausgewählten Filter und setzt die Auflösungsauswahl zurück.
                 */
                MaterialMenuItem {
                    text: modelData
                    Material.foreground: appSettings.resolutionOs === modelData ? Material.accent : Theme.foreground

                    onClicked: {
                        appSettings.resolutionOs = modelData
                        appSettings.resolutionIndex = index
                        appSettings.sizesIndex = 0
                        filterModel.invalidate()
                        cbSizes.currentIndex = 0
                    }
                }
            }
        }
    }
}