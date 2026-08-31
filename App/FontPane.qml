import "Controls"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

/**
 * Erfasst die typografischen Einstellungen für das neue QML-Projekt.
 *
 * Schriftfamilie, Schriftgröße und Schriftstärke werden zusammengefasst
 * und durch eine Vorschau direkt dargestellt.
 */
MaterialPane {
    id: fontPane

    /**
     * Stellt die ausgewählten Schrifteinstellungen für die Projekterstellung bereit.
     */
    property var fontDetails: ({
                                   fontFamily: cbFontFamily.currentText,
                                   fontSize: sbSize.value,
                                   fontWeight: sbWeight.value
                               });

    width: 400
    Label {
        id: label
        text: qsTr("Typografie")
        font.pointSize: Theme.fontSize.header
        Layout.fillWidth: true
    }

    Label {
        opacity: 0.597
        font.pointSize: Theme.fontSize.small
        text: qsTr("Auswahl einer Schriftart.")
        Layout.topMargin: -16
        Layout.fillWidth: true
    }

    /**
     * Zeigt die verfügbaren Schriftfamilien an und speichert die aktuelle Auswahl.
     */
    MaterialComboBox {
        id: cbFontFamily
        currentIndex: appSettings.fontFamilyIndex
        Layout.fillWidth: true
        model: ["Bebas Neue", "DM Sans", "Fira Sans", "Inter", "JetBrains Mono", "Montserrat", "Onest",
            "Open Sans",  "Orbitron", "Roboto" ]
        onCurrentIndexChanged: appSettings.fontFamilyIndex = currentIndex
    }

    /**
     * Ermöglicht die Auswahl von Schriftgröße und Schriftstärke.
     */
    RowLayout {
        spacing: 16

        ColumnLayout {
            /**
             * Legt die Standardschriftgröße des neuen Projekts fest.
             */
            MaterialSpinBox {
                id: sbSize
                value: 10; to: 92; from: 6;
                Layout.fillWidth: true
            }

            Label {
                opacity: 0.5
                text: "Größe"
                font.pointSize: Theme.fontSize.small
            }
        }
        ColumnLayout {
            /**
             * Legt die Standardschriftstärke des neuen Projekts fest.
             */
            MaterialSpinBox {
                id: sbWeight
                value: 400; stepSize: 100; to: 1000; from: 100;
                Layout.fillWidth: true
            }

            Label {
                opacity: 0.5
                text: "Stärke"
                font.pointSize: Theme.fontSize.small
            }
        }
    }

    /**
     * Zeigt eine Vorschau der ausgewählten Schriftfamilie an.
     */
    Label {
        text: `${cbFontFamily.currentText} 0123456789`
        font.family: cbFontFamily.currentText
        Layout.fillWidth: true
        elide: "ElideRight"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: Theme.fontSize.header
        Layout.preferredHeight: 42
        Layout.topMargin: 16
    }
}