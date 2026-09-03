import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import "Controls"
import QtQuick.Dialogs
import App.Core
import QtCore

/**
 * Erfasst und überprüft die Grundeinstellungen für das neue QML-Projekt.
 *
 * Dazu gehören Projektname, Zielverzeichnis, Fenstergröße, Farbschema
 * und die Programme, in denen das fertige Projekt geöffnet werden soll.
 */
MaterialPane {
    id: detailsPane
    width: 400

    /**
     * Stellt den ausgewählten Projektpfad für andere Komponenten bereit.
     */
    property alias projectPath: projectPath.text

    /**
     * Stellt den eingegebenen Projektnamen für andere Komponenten bereit.
     */
    property alias projectName: projectName.text

    /**
     * Gibt an, ob alle erforderlichen Projekteinstellungen gültig sind.
     */
    property bool allValid: projectName.isValid && projectPath.isValid && tfWidth.isValid && tfHeight.isValid

    /**
     * Fasst die ausgewählten Projekteinstellungen für die Projekterstellung zusammen.
     */
    property var details: ({
                               projectName: projectName.text,
                               projectPath: projectPath.text,
                               width: Number(tfWidth.text),
                               height: Number(tfHeight.text),
                               darkMode: swDarkMode.checked,
                               openDesignStudio: swOpenDesignStudio.checked,
                               openQtCreator: swOpenQtCreator.checked,
                               buildSystem: buildCb.currentText
                           })

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

    /**
     * Prüft den Projektnamen auf gültige Zeichen und ein bereits vorhandenes Projektverzeichnis.
     */
    MaterialTextField {
        id: projectName
        placeholderText: "Projekt-Name"
        text: "Unbenannt"
        Layout.fillWidth: true
        isValid: /^[a-zA-Z]{1}([a-zA-Z0-9_]?)+$/.test(text.trim()) && projectWatcher.projectNameValid
    }

    /**
     * Zeigt den ausgewählten Projektpfad an und ermöglicht die Auswahl eines Zielverzeichnisses.
     */
    RowLayout {
        spacing: 16

        MaterialTextField {
            id: projectPath
            readOnly: true
            placeholderText: "Projekt-Pfad"
            Layout.fillWidth: true
            text: FileUtils.toLocalFile(appSettings.projectPath)
            isValid: text.trim().length > 0 && projectWatcher.projectPathValid
        }

        MaterialRoundButton {
            icon.source: Icons.folder
            onClicked: {
                folderDialog.currentFolder = !FileUtils.dirExists( projectPath.text )
                        ? StandardPaths.writableLocation(StandardPaths.HomeLocation) : appSettings.projectPath

                folderDialog.open()
            }

            /**
             * Übernimmt das ausgewählte Verzeichnis als neuen Projektpfad.
             */
            FolderDialog {
                id: folderDialog
                onAccepted: {
                    appSettings.projectPath = selectedFolder;
                }
            }
        }
    }

    MaterialHorizontalLine { }

    Label {
        text: `Filter: ${appSettings.resolutionOs}`
        font.pointSize: Theme.fontSize.small
        opacity: 0.5
        Layout.bottomMargin: -14
    }

    /**
     * Ermöglicht die Auswahl einer vordefinierten Fensterauflösung.
     */
    DetailsPaneResolution {
        id: detailsPaneResolution
    }

    /**
     * Ermöglicht die manuelle Eingabe der Fensterbreite und Fensterhöhe.
     */
    RowLayout {
        spacing: 16

        MaterialTextField {
            id: tfWidth
            placeholderText: "Breite"
            Layout.fillWidth: true
            isValid: text.trim().length > 0
            validator: RegularExpressionValidator {
                regularExpression: /^[0-9]{1,4}$/
            }
        }

        MaterialTextField {
            id: tfHeight
            placeholderText: "Höhe"
            Layout.fillWidth: true
            isValid: text.trim().length > 0
            validator: RegularExpressionValidator {
                regularExpression: /^[0-9]{1,4}$/
            }
        }
    }

    MaterialHorizontalLine { }

    /**
     * Legt das Build-System fest.
     */
    MaterialComboBox {
        id: buildCb
        model: ["qmake", "CMake"]
        currentIndex: appSettings.buildIndex
        Layout.fillWidth: true
        onActivated: appSettings.buildIndex = currentIndex;
    }

    /**
     * Legt das Farbschema des neuen Projekts fest und speichert die Auswahl.
     */
    MaterialSwitch {
        id: swDarkMode
        Layout.fillWidth: true
        text: "Dark-Mode"
        checked: appSettings.themeDarkMode

        onCheckedChanged: {
            appSettings.themeDarkMode = checked
        }
    }

    /**
     * Legt fest, ob das erstellte Projekt anschließend in Qt Design Studio geöffnet wird.
     */
    MaterialSwitch {
        id: swOpenDesignStudio
        Layout.fillWidth: true
        text: "Im Design-Studio öffnen"
        checked: appSettings.openInDesignStudio

        onCheckedChanged: {
            appSettings.openInDesignStudio = checked
        }
    }

    /**
     * Legt fest, ob das erstellte Projekt anschließend in Qt Creator geöffnet wird.
     */
    MaterialSwitch {
        id: swOpenQtCreator
        Layout.fillWidth: true
        text: "Im QtCreator öffnen"
        checked: appSettings.openInQtCreator

        onCheckedChanged: {
            appSettings.openInQtCreator = checked
        }
    }
}