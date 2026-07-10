import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Pane {
    id: control
    width: 200


    rightPadding: 16
    leftPadding: 16
    bottomPadding: 16
    topPadding: 16
    padding: 16
    Material.background: Theme.backgroundAlt
    Material.elevation: 6
    
    property int orientation: Qt.Horizontal
    property int columns: orientation === Qt.Horizontal ? 1 : -1
    property int rows: orientation === Qt.Horizontal ? -1 : 1

    
    default property alias contentItems: gLayout.children
    
    contentItem: GridLayout {
        id: gLayout
        anchors.fill: parent
        anchors.margins: control.padding
        rowSpacing: control.padding
        columnSpacing: control.padding
        rows: control.rows
        columns: control.columns
    }
}
