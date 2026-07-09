import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Controls"
import "Components/Details"
Rectangle {
    id: app
    width: Theme.width
    height: Theme.height
    color: Theme.background

    AppSettings {
        id: appSettings
    }

    DetailsPane {
        id: detailsPane
        x: 516
        y: 343
    }
}

























