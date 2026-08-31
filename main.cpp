#include "src/cpp/fileutils.h"
#include "src/cpp/projectbuilder.h"
#include "src/cpp/projectwatcher.h"
#include "src/cpp/windowswindowfilter.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

int main(int argc, char *argv[])
{
    qputenv("Q_QUICK_CONTROLS_STYLE", "Material");
    qputenv("QT_QUICK_CONTROLS_CONF", ":/qtquickcontrols2.conf");
    QGuiApplication app(argc, argv);

    WindowsWindowFilter windowsWindowFilter;
    app.installNativeEventFilter(&windowsWindowFilter);

    qmlRegisterType<ProjectWatcher>("App.Core", 1, 0, "ProjectWatcher");
    qmlRegisterType<ProjectBuilder>("App.Core", 1,0, "ProjectBuilder");
    qmlRegisterSingletonType<FileUtils>("App.Core", 1, 0, "FileUtils", &FileUtils::singletonProvider);
    QQmlApplicationEngine engine;
    engine.addImportPath(":/");

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    if ( !engine.rootObjects().isEmpty() ) {
        QWindow *window = qobject_cast<QWindow*>(engine.rootObjects().constFirst());
        if ( window )
            windowsWindowFilter.setWindow(window);
    }

    return QGuiApplication::exec();
}
