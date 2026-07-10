#include "fileutils.h"

#include <QDir>

FileUtils::FileUtils(QObject *parent)
    : QObject{parent}
{}


FileUtils *FileUtils::singletonProvider(QQmlEngine *engine, QJSEngine *scriptEnginge)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEnginge)
    return new FileUtils;
}

bool FileUtils::dirExists(const QString &path) {
    const bool exists = QDir(toLocalFile(path)).exists();
    return exists;
}

QString FileUtils::toLocalFile(const QUrl &url) { return url.toLocalFile(); }
QString FileUtils::toLocalFile(const QString &path) {
    const QUrl url(path);
    return url.isLocalFile() ? url.toLocalFile() : path;
}

QString FileUtils::fromLocalFile(const QString &path)
{
    return QUrl::fromLocalFile(path).toString();
}

QString FileUtils::read(const QString &path)
{
    QFile file(path);
    if ( !file.open(QIODevice::ReadOnly | QIODevice::Text))
        return {};

    return file.readAll();
}

bool FileUtils::write(const QString &path, const QString &content)
{
    QFile file(path);
    if ( !file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    file.write(content.toUtf8());
    return true;
}



