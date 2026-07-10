import QtQuick
import QtQuick.Controls.Material

Button {
    id: button
    text: qsTr("Button")
    bottomInset: 0
    topInset: 0
    rightPadding: 16
    leftPadding: 16
    bottomPadding: 0
    topPadding: 0
    Material.roundedScale: Material.SmallScale
    Material.background: Theme.backgroundAlt
    font.pointSize: Theme.fontSize.control
    Material.elevation: 6
}
