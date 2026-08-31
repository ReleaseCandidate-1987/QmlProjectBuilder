import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import App.Core
import "Controls"

/**
 * Bildet die Hauptoberfläche des QML Project Builders.
 *
 * Die Komponente verbindet die Projekteinstellungen mit der Validierung
 * und übergibt die gesammelten Angaben an den ProjectBuilder.
 */
Rectangle {
    id: app
    width: Theme.width
    height: Theme.height
    anchors.centerIn: parent
    color: Theme.background

    /**
     * Stellt die dauerhaft gespeicherten Anwendungseinstellungen bereit.
     */
    AppSettings { id: appSettings }

    /**
     * Zeigt die benutzerdefinierte Titelleiste der Anwendung an.
     */
    TitleBar { id: titleBar }

    /**
     * Überwacht den ausgewählten Projektpfad und prüft, ob der Projektname verfügbar ist.
     */
    ProjectWatcher {
        id: projectWatcher
        projectPath: detailsPane.projectPath
        projectName:  detailsPane.projectName
    }

    /**
     * Übernimmt den geprüften Projektpfad und Projektnamen für die Projekterstellung.
     */
    ProjectBuilder {
        id: projectBuilder
        projectPath: projectWatcher.projectPath
        projectName: projectWatcher.projectName
    }

    /**
     * Fasst die Projekt- und Schrifteinstellungen zusammen und startet die Projekterstellung.
     */
    MaterialButton {
        id: button
        anchors.left: scrollView.right
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 16
        text: "Projekt erstellen"
        icon.height: 64
        icon.width: 64
        display: AbstractButton.TextUnderIcon
        icon.source: Icons.add
        enabled: detailsPane.allValid
        onClicked: {
            const obj = Object.assign(detailsPane.details, fontPane.fontDetails );
            projectBuilder.build( obj )
        }

        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    /**
     * Stellt die Projekt- und Schrifteinstellungen in einem scrollbareren Bereich dar.
     */
    ScrollView {
        id: scrollView
        anchors.left: parent.left

        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom

        width: 432
        contentHeight: clayout.implicitHeight + 32
        ScrollBar.vertical: ScrollBar {
            anchors {
                top: parent.top; bottom: parent.bottom; right: parent.right
            }
            width: 8
        }

        ColumnLayout {
            id: clayout
            x: 16; y: 16
            height: Math.max(scrollView.height, implicitHeight) - 32
            DetailsPane {
                id: detailsPane
                Layout.preferredWidth: 400
            }

            FontPane {
                id: fontPane
                Layout.preferredWidth: 400
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}