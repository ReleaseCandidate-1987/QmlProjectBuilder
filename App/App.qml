import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Core
import "Controls"
import QtQuick.Effects

Rectangle {
    id: app
    width: glayout.implicitWidth + 32
    height: glayout.implicitHeight + 32 + titleBar.height
    anchors.centerIn: parent
    color: Theme.background
    radius: 12

    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Material.accent
        shadowBlur: 0.5
    }

    ProjectWatcher {
        id: projectWatcher
        projectPath: detailsPane.projectPath
        projectName:  detailsPane.projectName
    }

    ProjectBuilder {
        id: projectBuilder
        projectPath: projectWatcher.projectPath
        projectName: projectWatcher.projectName
    }

    ControlLoader {
        id: controlLoader
        Component.onCompleted: load();

    }

    AppSettings { id: appSettings }

    TitleBar { id: titleBar }

    GridLayout {
        id: glayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 16
        rowSpacing: 16
        columnSpacing: 16
        columns: appSettings.showHorizontal ? 3 : 2
        rows: 2

        DetailsPane {
            id: detailsPane
            Layout.preferredWidth: 400
            Layout.rowSpan: 2
            Layout.columnSpan: 1
        }

        ControlPane {
            id: controlPane
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.preferredWidth: 400
            Layout.rowSpan: 2
        }

        FontPane {
            id: fontPane
            Layout.preferredWidth: 400
            Layout.columnSpan: 1
        }

        MaterialButton {
            id: button
            text: "Projekt erstellen"
            Layout.fillWidth: true
            Layout.fillHeight: true
            icon.height: 64
            icon.width: 64
            display: AbstractButton.TextUnderIcon
            icon.source: Icons.add
            enabled: detailsPane.allValid
            onClicked: {
                const obj = Object.assign(detailsPane.details, fontPane.fontDetails, controlLoader.toObject() );
                projectBuilder.build( obj )
            }
        }
    }


}

























