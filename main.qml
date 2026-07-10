import QtQuick
import QtQuick.Controls
import App

Window {
    id: window
    width:          app.width   + 32
    height:         app.height  + 32
    maximumHeight:  app.height  + 32
    maximumWidth:   app.width   + 32
    minimumHeight:  app.height  + 32
    minimumWidth:   app.width   + 32
    visible: true
    title: Theme.title
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "transparent"
    Material.theme: Theme.isDarkMode ? Material.Dark : Material.Light
    App { id: app;  }
}

