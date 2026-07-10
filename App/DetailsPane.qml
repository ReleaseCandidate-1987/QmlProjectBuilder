import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import "Controls"
import QtQuick.Dialogs
import App.Core
import QtCore

MaterialPane {
    id: detailsPane
    width: 400

    property alias projectPath: projectPath.text
    property alias projectName: projectName.text

    property bool allValid: projectName.isValid && projectPath.isValid && tfWidth.isValid && tfHeight.isValid
    property var details: ({
                               projectName: projectName.text,
                               projectPath: projectPath.text,
                               width: Number(tfWidth.text),
                               height: Number(tfHeight.text),
                               darkMode: swDarkMode.checked,
                               openDesignStudio: swOpenDesignStudio.checked,
                               openQtCreator: swOpenQtCreator.checked
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

    MaterialTextField {
        id: projectName
        placeholderText: "Projekt-Name"
        text: "Unbenannt"
        Layout.fillWidth: true
        isValid: /^[a-zA-Z]{1}([a-zA-Z0-9_]?)+$/.test(text.trim()) && projectWatcher.projectNameValid


        //Component.onCompleted: isValid = Qt.binding(() => /^[a-zA-Z]{1}([a-zA-Z0-9_]?)+$/.test(text.trim()) && !ProjectBuilder.projectExists(text.trim()))
    }

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

    DetailsPaneResolution {
        id: detailsPaneResolution
    }

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

    MaterialSwitch {
        id: swDarkMode
        Layout.fillWidth: true
        text: "Dark-Mode"
        checked: appSettings.themeDarkMode

        onCheckedChanged: {
            appSettings.themeDarkMode = checked
        }
    }

    MaterialSwitch {
        id: swOpenDesignStudio
        Layout.fillWidth: true
        text: "Im Design-Studio öffnen"
        checked: appSettings.openInDesignStudio

        onCheckedChanged: {
            appSettings.openInDesignStudio = checked
        }
    }

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
