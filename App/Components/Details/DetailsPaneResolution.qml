import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"
import "../../Core"

import QtQml.Models

RowLayout {
    id: detailsPaneResolution
    spacing: 16
    
    MaterialComboBox {
        id: cbSizes
        Layout.fillWidth: true
        
        currentIndex: appSettings.sizesIndex
        
        ResolutionModel {
            id: resolutionModel
        }
        
        SortFilterProxyModel {
            id: filterModel
            model: resolutionModel
            
            filters: [
                FunctionFilter {
                    component RoleData: QtObject {
                        property string os
                    }
                    
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
    MaterialRoundButton {
        id: btnFilter
        icon.source: Icons.filter_alt
        property alias menu: menu
        
        onClicked: {
            if (menu.visible)
                return
            
            menu.popup()
        }
        
        MaterialMenu {
            id: menu

            Repeater {
                id: repeater
                model: ["Desktop", "iOS", "iPadOS", "Android", "Android Tablet"]
                
                MaterialMenuItem {
                    text: modelData
                    Material.foreground: appSettings.resolutionOs === modelData ? Material.accent : Theme.foreground
                    
                    onClicked: {
                        // GEÄNDERT: OS speichern
                        appSettings.resolutionOs = modelData
                        appSettings.resolutionIndex = index
                        appSettings.sizesIndex = 0
                        
                        // GEÄNDERT: Filter aktualisieren
                        filterModel.invalidate()
                        
                        // GEÄNDERT: Auswahl auf ersten Eintrag setzen
                        cbSizes.currentIndex = 0
                    }
                }
            }
        }
    }
    
    
}
