import QtQuick
import QtQuick.Controls
import App

Window {
    id: window
    width: Theme.width
    height: Theme.height
    minimumWidth: 750
    minimumHeight: 650
    visible: true
    title: Theme.title
    flags: Qt.Window | Qt.CustomizeWindowHint
    color: "transparent"
    Material.theme: Theme.isDarkMode ? Material.Dark : Material.Light
    App { id: app; anchors.fill: parent }
}

