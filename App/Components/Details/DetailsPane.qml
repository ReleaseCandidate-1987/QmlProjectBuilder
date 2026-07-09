import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"
import "../../Core"

import QtQml.Models

MaterialPane {
    id: detailsPane
    width: 357

    Label {
        id: label
        text: qsTr("Details")
        font.pointSize: Theme.fontSize.header
        Layout.fillWidth: true
    }

    Label {
        opacity: 0.597
        font.pointSize: Theme.fontSize.small
        text: qsTr("Grundeinstellungen für das neue Projekt.")
        Layout.topMargin: -16
    }

    MaterialTextField {
        placeholderText: "Projekt-Name"
        Layout.fillWidth: true
    }

    RowLayout {
        spacing: 16

        MaterialTextField {
            placeholderText: "Projekt-Pfad"
            Layout.fillWidth: true
        }

        MaterialRoundButton {
            icon.source: Icons.folder
        }
    }

    MaterialHorizontalLine { }

    Label {
        text: `Filter: ${appSettings.resolutionOs}`
        font.pointSize: Theme.fontSize.small
        opacity: 0.5
        Layout.bottomMargin: -14
    }

    DetailsPaneResolution {
        id: detailsPaneResolution
    }

    RowLayout {
        spacing: 16

        MaterialTextField {
            id: tfWidth
            placeholderText: "Breite"
            Layout.fillWidth: true
        }

        MaterialTextField {
            id: tfHeight
            placeholderText: "Höhe"
            Layout.fillWidth: true
        }
    }

    MaterialHorizontalLine { }

    MaterialSwitch {
        Layout.fillWidth: true
        text: "Im Design-Studio öffnen"
        checked: appSettings.openInDesignStudio

        onCheckedChanged: {
            appSettings.openInDesignStudio = checked
        }
    }

    MaterialSwitch {
        Layout.fillWidth: true
        text: "Im QtCreator öffnen"
        checked: appSettings.openInQtCreator

        onCheckedChanged: {
            appSettings.openInQtCreator = checked
        }
    }

}
