#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>
#include <QQmlEngine>
class FileUtils : public QObject
{
    Q_OBJECT
public:
    static FileUtils *singletonProvider(QQmlEngine *engine, QJSEngine *scriptEnginge);

    Q_INVOKABLE static bool dirExists(const QString &path);
    Q_INVOKABLE static QString toLocalFile(const QUrl &url);
    Q_INVOKABLE static QString toLocalFile(const QString &path);
    Q_INVOKABLE static QString fromLocalFile(const QString &path);
    static QString read(const QString &path);
    static bool write(const QString &path, const QString &content);
    template<typename... Args>
    static void replaceContent(QString &content, Args&& ...args) {
        ( content.replace( args.first, QVariant::fromValue(args.second).toString() ), ... );
    }

private:
    explicit FileUtils(QObject *parent = nullptr);
    Q_DISABLE_COPY_MOVE(FileUtils)
signals:
};

#endif // FILEUTILS_H
