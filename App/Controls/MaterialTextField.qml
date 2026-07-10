import QtQuick
import QtQuick.Controls.Material

TextField {
    id: control
    bottomPadding: 0
    topPadding: 0
    implicitHeight: 42
    font.pointSize: Theme.fontSize.control
    placeholderText: "Placeholder Text"
    property bool isValid: true
    Material.accent: isValid ? Material.LightGreen : Material.Red
}
