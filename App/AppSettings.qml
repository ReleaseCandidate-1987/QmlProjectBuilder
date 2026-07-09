import QtQuick
import QtCore

Settings {
    id: appSettings

    property var initSettings: {
        Qt.application.name = Theme.title
        Qt.application.domain = Theme.title + ".de"
        Qt.application.organization = Theme.title + "_org"
    }

    property int sizesIndex: 0
    property bool openInDesignStudio: false
    property bool openInQtCreator: false
    property int resolutionIndex: 0
    property string resolutionOs: "Desktop"
}
