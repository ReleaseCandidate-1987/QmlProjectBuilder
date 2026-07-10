#ifndef PROJECTBUILDER_H
#define PROJECTBUILDER_H

#include "fileutils.h"

#include <QObject>

#include <QFileSystemWatcher>
#include <QDir>
#include <QJsonObject>

class ProjectBuilder : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString projectPath READ projectPath WRITE setProjectPath NOTIFY projectPathChanged FINAL)
    Q_PROPERTY(QString projectName READ projectName WRITE setProjectName NOTIFY projectNameChanged FINAL)
public:
    explicit ProjectBuilder(QObject *parent = nullptr);

    QString projectPath() const;
    void setProjectPath(const QString &projectPath);

    QString projectName() const;
    void setProjectName(const QString &projectName);

    Q_INVOKABLE void build( const QJsonObject &obj );

signals:
    void projectPathChanged();
    void projectNameChanged();

private:
    template<typename... Args>
    void create( const QString &templatePath, const QString &path, Args&& ...args ) {
        addRelativePath(path);
        QString temp = FileUtils::read(templatePath);
        FileUtils::replaceContent( temp, std::forward<Args>(args)... );
        FileUtils::write(path, temp);
    }
    void write(const QString &path, const QString &content);
    void createQmlTheme( const QString &path, const QJsonObject &obj );
    void createQtPro( const QString &path, const QJsonObject &obj );
    void createQtConf( const QString &path, const QJsonObject &obj );
    void createQmlProject( const QString &path, const QJsonObject &obj );
    void createQrc( const QString &path );
    void addRelativePath( const QString &path );
private:
    QString m_projectPath;
    QString m_projectName;
    QDir m_projectDir;
    QStringList m_relativePaths;

};

#endif // PROJECTBUILDER_H
