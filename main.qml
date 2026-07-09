import QtQuick
import App

Window {
    id: window
    width: Theme.width
    height: Theme.height

    visible: true
    title: Theme.title

    App { id: app; anchors.fill: parent }

}

