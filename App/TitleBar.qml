import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Core
import "Controls"
import QtQuick.Effects

Rectangle {
    id: titleBar
    height: 64
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    color: Theme.backgroundAlt
    topLeftRadius: 16
    topRightRadius: 16
    
    DragHandler {
        target: null
        onActiveChanged: {
            if ( active )
                window.startSystemMove()
        }
    }
    
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

        MaterialRoundButton {
            id: btnShowHorizontal
            icon.source: Icons.grid_view
            checkable: true
            checked: appSettings.showHorizontal
            onCheckedChanged: {
                appSettings.showHorizontal = checked;
            }
        }
        Item { Layout.fillWidth: true }
        
        RowLayout {
            MaterialRoundButton {
                icon.source: Theme.isDarkMode ? Icons.light_mode : Icons.dark_mode
                onClicked: {
                    Theme.isDarkMode = !Theme.isDarkMode;
                }
            }

            MaterialRoundButton {
                icon.source: Icons.remove
                onClicked: {
                    window.showMinimized()
                }
            }
            
            MaterialRoundButton {
                icon.source: Icons.close
                onClicked: {
                    window.close()
                }
            }
        }
    }
}
