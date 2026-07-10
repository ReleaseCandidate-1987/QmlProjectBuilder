import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import App.Core
import "Controls"

MaterialPane {
    id: controlPane

    Label {
        text: qsTr("Controls")
        font.pointSize: Theme.fontSize.header
        Layout.fillWidth: true
    }
    
    Label {
        opacity: 0.597
        font.pointSize: Theme.fontSize.small
        text: qsTr("Komponenten in den Export einbeziehen.")
        Layout.topMargin: -16
    }

    
    RowLayout {
        Item { Layout.fillWidth: true }
        MaterialRoundButton {
            icon.source: Icons.refresh
            onClicked: {
                controlLoader.load();
            }
            
        }
        MaterialRoundButton {
            icon.source: Icons.delete_sweep
            icon.color: Qt.lighter(Material.color(Material.Red), 1.25)
            onClicked: listView.model.clear()
        }
    }
    
    ListView {
        id: listView
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 1
        clip: true
        
        ScrollBar.vertical: ScrollBar { policy: "AsNeeded"; width: 8 }
        
        model: controlLoader.model

        DropArea {
            anchors.fill: parent

            onEntered: function ( drag ) {
                drag.accepted = drag.hasUrls
                console.log(drag.accepted)
            }

            onDropped: function( drop ) {
                for( let i = 0; i < drop.urls.length; ++i ) {
                    const path = FileUtils.toLocalFile(drop.urls[i]);
                    controlLoader.append(path);
                    console.log(path)
                }
            }
        }
        
        delegate: Item {
            width: ListView.view.width
            height: 42
            
            Rectangle {
                anchors.fill: parent
                radius: 4
                color: index % 2 === 0 ? Theme.background : Theme.backgroundMuted
            }
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 8
                spacing: 8
                Label {
                    text: name
                    font.pointSize: Theme.fontSize.small
                    Layout.fillWidth: true
                    elide: "ElideRight"
                }
                
                MaterialRoundButton {
                    icon.source: Icons.close
                    Layout.preferredHeight: 24
                    Layout.preferredWidth: 24
                    icon.color: Qt.lighter(Material.color(Material.Red), 1.25)
                    onClicked: {
                        listView.model.remove(index);
                    }
                }
            }
            
        }
    }
    
}
