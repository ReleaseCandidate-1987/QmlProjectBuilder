import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Core
import "Controls"

/**
 * Verwaltet die Komponenten, die beim Erstellen eines Projekts in den Export einbezogen werden.
 *
 * Komponenten können geladen, per Drag-and-drop hinzugefügt und einzeln
 * oder vollständig aus der Auswahl entfernt werden.
 */
MaterialPane {
    id: controlPane

    Label {
        text: qsTr("Controls")
        font.pointSize: Theme.fontSize.header
        Layout.fillWidth: true
    }

    Label {
        opacity: 0.597
        font.pointSize: Theme.fontSize.small
        text: qsTr("Komponenten in den Export einbeziehen.")
        Layout.topMargin: -16
    }

    /**
     * Enthält die Aktionen zum erneuten Laden und Leeren der Komponentenliste.
     */
    RowLayout {
        Item { Layout.fillWidth: true }

        /**
         * Lädt die verfügbaren Komponenten erneut.
         */
        MaterialRoundButton {
            icon.source: Icons.refresh
            onClicked: { controlLoader.load(); }
        }

        /**
         * Entfernt alle Komponenten aus der aktuellen Auswahl.
         */
        MaterialRoundButton {
            icon.source: Icons.delete_sweep
            icon.color: Qt.lighter(Material.color(Material.Red), 1.25)
            onClicked: listView.model.clear()
        }
    }

    /**
     * Zeigt die Komponenten an, die für den Export ausgewählt wurden.
     */
    ListView {
        id: listView
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 1
        clip: true

        ScrollBar.vertical: ScrollBar { policy: "AsNeeded"; width: 8 }

        model: controlLoader.model

        /**
         * Nimmt abgelegte Dateien entgegen und fügt deren lokale Pfade der Komponentenliste hinzu.
         */
        DropArea {
            anchors.fill: parent

            onEntered: function ( drag ) {
                drag.accepted = drag.hasUrls
            }

            onDropped: function( drop ) {
                for( let i = 0; i < drop.urls.length; ++i ) {
                    const path = FileUtils.toLocalFile(drop.urls[i]);
                    controlLoader.append(path);
                }
            }
        }

        /**
         * Stellt eine ausgewählte Komponente dar und ermöglicht deren Entfernung.
         */
        delegate: Item {
            width: ListView.view.width
            height: 42

            Rectangle {
                anchors.fill: parent
                radius: 4
                color: index % 2 === 0 ? Theme.background : Theme.backgroundMuted
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 8
                spacing: 8
                Label {
                    text: name
                    font.pointSize: Theme.fontSize.small
                    Layout.fillWidth: true
                    elide: "ElideRight"
                }

                MaterialRoundButton {
                    icon.source: Icons.close
                    Layout.preferredHeight: 24
                    Layout.preferredWidth: 24
                    icon.color: Qt.lighter(Material.color(Material.Red), 1.25)
                    onClicked: {
                        listView.model.remove(index);
                    }
                }
            }

        }
    }
}