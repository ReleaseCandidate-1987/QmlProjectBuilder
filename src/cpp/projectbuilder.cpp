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
    m_projectDir = QDir(m_projectPath + "/" + m_projectName );
    const QStringList folders = { "App", "App/Style", "App/Components", "App/Controls", "App/Core", "App/Dialogs",
                                 "src/cpp", "src/js", "assets/icons" };

    for (const QString &folder: folders )
        m_projectDir.mkpath(folder);

    const QString qmlProjectPath = m_projectDir.filePath(m_projectName + ".qmlproject");
    const QString qtProjectPath = m_projectDir.filePath(m_projectName + ".pro");

    createQmlTheme(m_projectDir.filePath("App/Style/Theme.qml"), obj);
    createQmlFonts(m_projectDir.filePath("App/Style/Fonts.qml"), obj);

    createQtPro(qtProjectPath, obj);
    createQmlProject(qmlProjectPath, obj);
    createQtConf(m_projectDir.filePath("qtquickcontrols2.conf"), obj);

    create(":/assets/templates/App.qml.template", m_projectDir.filePath("App/App.qml"));
    create(":/assets/templates/app.qmldir.template", m_projectDir.filePath("App/qmldir"));
    create(":/assets/templates/AppSettings.qml.template", m_projectDir.filePath("App/AppSettings.qml"));
    create(":/assets/templates/Icons.qml.template", m_projectDir.filePath("App/Style/Icons.qml"));
    create(":/assets/templates/style.qmldir.template", m_projectDir.filePath("App/Style/qmldir"));
    create(":/assets/templates/main.cpp.template", m_projectDir.filePath("main.cpp"));
    create(":/assets/templates/main.qml.template", m_projectDir.filePath("main.qml"));

    write(m_projectDir.filePath("App/Core/qmldir"), "");
    write(m_projectDir.filePath("App/Compoments/qmldir"), "import App.Style");
    write(m_projectDir.filePath("App/Controls/qmldir"), "import App.Style");
    write(m_projectDir.filePath("App/Dialogs/qmldir"), "import App.Style");

    const QJsonArray arr = obj["controls"].toArray();
    for ( const QJsonValue &value: arr ) {
        if ( !value.isObject() )
            continue;

        const QString fileName = value["fileName"].toString();
        const QString content = value["content"].toString();
         write(m_projectDir.filePath("App/Controls/" + fileName ), content);

    }

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

void ProjectBuilder::createQmlTheme(const QString &path, const QJsonObject &obj)
{
    create( ":/assets/templates/Theme.qml.template", path,
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() },
           std::pair{ "{APP_WIDTH}", obj["width"].toInt() },
           std::pair{ "{APP_HEIGHT}", obj["height"].toInt() },
           std::pair{ "{APP_DARKMODE}", obj["darkMode"].toBool() }
           );
}

void ProjectBuilder::createQmlFonts(const QString &path, const QJsonObject &obj)
{
    create( ":/assets/templates/Fonts.qml.template", path,
           std::pair{ "{APP_FONT_FAMILY}", obj["fontFamily"].toString() }
           );
}

void ProjectBuilder::createQtPro(const QString &path, const QJsonObject &obj)
{
    create( ":/assets/templates/pro.template", path,
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() }
           );
}

void ProjectBuilder::createQtConf(const QString &path, const QJsonObject &obj)
{
    const QString mode = obj["darkMode"].toBool() ? "Dark" : "Light" ;
    create( ":/assets/templates/qtquickcontrols2.conf.template", path,
           std::pair{ "{APP_DARKMODE}", mode },
           std::pair{ "{APP_FONT_FAMILY}", obj["fontFamily"].toString() },
           std::pair{ "{APP_FONT_SIZE}", obj["fontSize"].toInt()  },
           std::pair{ "{APP_FONT_WEIGHT}", obj["fontWeight"].toInt()  }
           );
}

void ProjectBuilder::createQmlProject(const QString &path, const QJsonObject &obj)
{
    create( ":/assets/templates/qmlproject.template", path,
           std::pair{ "{APP_PROJECTNAME}", obj["projectName"].toString() }
           );
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
//    <file>App/App.qml</file>



void ProjectBuilder::addRelativePath(const QString &path) { m_relativePaths.append(m_projectDir.relativeFilePath(path)); }


















