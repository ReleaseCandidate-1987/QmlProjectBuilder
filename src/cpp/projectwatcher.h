#ifndef PROJECTWATCHER_H
#define PROJECTWATCHER_H

#include <QObject>
#include <QFileSystemWatcher>

class ProjectWatcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString projectPath READ projectPath WRITE setProjectPath NOTIFY projectPathChanged FINAL)
    Q_PROPERTY(bool projectPathValid READ projectPathValid NOTIFY projectPathValidChanged FINAL)
    Q_PROPERTY(QString projectName READ projectName WRITE setProjectName NOTIFY projectNameChanged FINAL)
    Q_PROPERTY(bool projectNameValid READ projectNameValid NOTIFY projectNameValidChanged FINAL)
public:
    explicit ProjectWatcher(QObject *parent = nullptr);

    bool projectPathValid() const;
    bool projectNameValid() const;

    QString projectPath() const;
    void setProjectPath(const QString &projectPath);

    QString projectName() const;
    void setProjectName(const QString &projectName);



signals:
    void projectPathValidChanged();
    void projectNameValidChanged();
    void projectPathChanged();
    void projectNameChanged();

private:
    void updateProjectPathExists();
    void updateProjectNameExists();
    void updateProjectPathWatcher();
    void updateNameWatcher();

private:
    QFileSystemWatcher m_pathWatcher;
     QFileSystemWatcher m_nameWatcher;
    QString m_projectPath;
    QString m_projectName;
    bool m_projectPathValid = false;
    bool m_projectNameValid = true;

};

#endif // PROJECTWATCHER_H
