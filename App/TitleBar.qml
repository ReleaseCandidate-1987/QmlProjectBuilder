import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Core
import "Controls"

/**
 * Stellt die benutzerdefinierte Titelleiste des Anwendungsfensters dar.
 *
 * Die Titelleiste ermöglicht das Verschieben, Minimieren, Maximieren und
 * Schließen des Fensters sowie den Wechsel zwischen Light- und Dark-Mode.
 */
Rectangle {
    id: titleBar
    height: 64
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    color: Theme.backgroundAlt

    /**
     * Wechselt durch einen Doppelklick zwischen maximierter und normaler Fenstergröße.
     */
    MouseArea {
        anchors.fill: parent
        onDoubleClicked: {
            window.visibility = window.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
        }
    }

    /**
     * Übergibt die Bewegung der Titelleiste an die native Fensterverwaltung.
     */
    DragHandler {
        target: null
        onActiveChanged: {
            if ( active )
                window.startSystemMove()
        }
    }

    /**
     * Ordnet das Anwendungsicon, den Titel und die Fensteraktionen an.
     */
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16

        Image {
            id: name
            source: "../assets/icons/icon.ico"
            Layout.preferredHeight: 42
            Layout.preferredWidth: 42
        }

        Label {
            text: Theme.title
            verticalAlignment: Text.AlignVCenter
            leftPadding: 12
            topPadding: -6
            font.pointSize: Theme.fontSize.header
        }

        Item { Layout.fillWidth: true }

        /**
         * Enthält die Aktionen für das Farbschema und die Fenstersteuerung.
         */
        RowLayout {
            /**
             * Wechselt zwischen Light- und Dark-Mode.
             */
            MaterialRoundButton {
                icon.source: Theme.isDarkMode ? Icons.light_mode : Icons.dark_mode
                onClicked: {
                    Theme.isDarkMode = !Theme.isDarkMode;
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: Theme.border
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                Layout.topMargin: 16
                Layout.bottomMargin: 16
            }

            /**
             * Minimiert das Anwendungsfenster.
             */
            MaterialRoundButton {
                icon.source: Icons.remove
                onClicked: {
                    window.showMinimized()
                }
            }

            /**
             * Wechselt zwischen maximierter und normaler Fenstergröße.
             */
            MaterialRoundButton {
                icon.source: window.visibility === Window.Maximized ? Icons.show_max : Icons.square
                icon.width: 18
                icon.height: 18
                onClicked: {
                    window.visibility = window.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
                }
            }

            /**
             * Schließt das Anwendungsfenster.
             */
            MaterialRoundButton {
                icon.source: Icons.close
                onClicked: {
                    window.close()
                }
            }
        }
    }
}