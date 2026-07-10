import QtQuick
import QtQuick.Controls.Material

Switch {
    id: switch1
    text: ""
    
    leftPadding: 0
    rightPadding: 0
    LayoutMirroring.enabled: true
    font.pointSize: Theme.fontSize.control
    Material.foreground: checked ? Material.accent : Theme.foreground
}
