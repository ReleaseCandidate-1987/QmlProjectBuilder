#include "projectbuilder.h"
#include <QDir>
#include <QDesktopServices>
#include <QJsonArray>

ProjectBuilder::ProjectBuilder(QObject *parent)
    : QObject{parent}
{

}

QString ProjectBuilder::projectPath() const { return m_projectPath; }
void ProjectBuilder::setProjectPath(const QString &projectPath)
{
    if (m_projectPath == projectPath)
        return;

    m_projectPath = projectPath;
    emit projectPathChanged();
}

QString ProjectBuilder::projectName() const { return m_projectName; }
void ProjectBuilder::setProjectName(const QString &projectName)
{
    if (m_projectName == projectName)
        return;

    m_projectName = projectName;
    emit projectNameChanged();
}

void ProjectBuilder::build(const QJsonObject &obj)
{
    m_relativePaths.clear();
    m_projectDir = QDir(m_projectPath + "/" + m_projectName );

    const QStringList folders = { "App", "App/Components", "App/Style", "App/Controls", "App/Core", "App/Dialogs",
                                 "src/cpp", "src/js", "assets/icons" };

    // Ordner erstellen ----
    for (const QString &folder: folders )
        m_projectDir.mkpath(folder);

    // Defaults ----
    const QString qmlProjectPath = m_projectDir.filePath(m_projectName + ".qmlproject");
    const QString qtProjectPath = m_projectDir.filePath(m_projectName + ".pro");

    const QString importTheme = "import App.Style";
    const QString mode = obj["darkMode"].toBool() ? "Dark" : "Light" ;


    // Main ----
    create(":/assets/templates/main.cpp.template", m_projectDir.filePath("main.cpp"));
    create(":/assets/templates/main.qml.template", m_projectDir.filePath("main.qml"));
    create( ":/assets/templates/pro.template", qtProjectPath,
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() }
           );

    create( ":/assets/templates/qmlproject.template", qmlProjectPath,
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() }
           );

    create( ":/assets/templates/qtquickcontrols2.conf.template", m_projectDir.filePath("qtquickcontrols2.conf"),
           std::pair{ "{APP_DARKMODE}", mode },
           std::pair{ "{APP_FONT_FAMILY}", obj["fontFamily"].toString() },
           std::pair{ "{APP_FONT_SIZE}", obj["fontSize"].toInt()  },
           std::pair{ "{APP_FONT_WEIGHT}", obj["fontWeight"].toInt()  }
           );

    // App.qml / qmldir ----
    create(":/assets/templates/App.qml.template", m_projectDir.filePath("App/App.qml"));
    create(":/assets/templates/app.qmldir.template", m_projectDir.filePath("App/qmldir"));
    create(":/assets/templates/AppSettings.qml.template", m_projectDir.filePath("App/AppSettings.qml"),
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() },
            std::pair{ "{APP_DARKMODE}", obj["darkMode"].toBool() }
           );
    create(":/assets/templates/Responsive.qml.template", m_projectDir.filePath("App/Responsive.qml"));

    // Style ----
    create(":/assets/templates/Style.ColorPalette.qml.template", m_projectDir.filePath("App/Style/ColorPalette.qml"),
           std::pair{ "{APP_DARKMODE}", obj["darkMode"].toBool() }
           );

    create(":/assets/templates/Style.Fonts.qml.template", m_projectDir.filePath("App/Style/Fonts.qml"),
           std::pair{ "{APP_FONT_FAMILY}", obj["fontFamily"].toString() }
           );

    create(":/assets/templates/Style.Theme.qml.template", m_projectDir.filePath("App/Style/Theme.qml"),
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() },
           std::pair{ "{APP_WIDTH}", obj["width"].toInt() },
           std::pair{ "{APP_HEIGHT}", obj["height"].toInt() }
           );

    create(":/assets/templates/Style.Icons.qml.template", m_projectDir.filePath("App/Style/Icons.qml") );
    create(":/assets/templates/Style.qmldir.template", m_projectDir.filePath("App/Style/qmldir") );


    // Direktes schreiben (qmldir) ----
    write(m_projectDir.filePath("App/Core/qmldir"), "");
    write(m_projectDir.filePath("App/Components/qmldir"), importTheme);
    write(m_projectDir.filePath("App/Controls/qmldir"), importTheme);
    write(m_projectDir.filePath("App/Dialogs/qmldir"), importTheme);

    // ====
    createQrc(m_projectDir.filePath(m_projectName + ".qrc"));   
    m_relativePaths.clear();

    if ( obj["openDesignStudio"].toBool() ) {
        QDesktopServices::openUrl(QUrl::fromLocalFile(qmlProjectPath));
    }
    if ( obj["openQtCreator"].toBool() ) {
        QDesktopServices::openUrl(QUrl::fromLocalFile(qtProjectPath));
    }
}

void ProjectBuilder::write(const QString &path, const QString &content)
{
    addRelativePath(path);
    FileUtils::write(path, content);
}


void ProjectBuilder::createQrc(const QString &path)
{
    QString resources;
    for ( const QString &relativePath: std::as_const(m_relativePaths))
        resources += "\t<file>" + relativePath + "</file>\n";

    QString temp = FileUtils::read(":/assets/templates/qrc.template");
    FileUtils::replaceContent( temp, std::pair{ "{APP_RESOURCES}", resources.trimmed() } );
    FileUtils::write(path, temp);
}

void ProjectBuilder::addRelativePath(const QString &path) {
    m_relativePaths.append(m_projectDir.relativeFilePath(path));
}


















