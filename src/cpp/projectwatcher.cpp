#include "projectwatcher.h"

#include <QDir>

ProjectWatcher::ProjectWatcher(QObject *parent)
    : QObject{parent}
{
    connect(&m_pathWatcher, &QFileSystemWatcher::directoryChanged, this, &ProjectWatcher::updateProjectPathExists);
    connect(&m_pathWatcher, &QFileSystemWatcher::directoryChanged, this, &ProjectWatcher::updateProjectNameExists);

    connect(&m_nameWatcher, &QFileSystemWatcher::directoryChanged, this, &ProjectWatcher::updateProjectNameExists);
    connect(&m_nameWatcher, &QFileSystemWatcher::directoryChanged, this, &ProjectWatcher::updateProjectPathExists);
}

bool ProjectWatcher::projectPathValid() const { return m_projectPathValid; }
bool ProjectWatcher::projectNameValid() const { return m_projectNameValid; }

void ProjectWatcher::updateProjectPathExists()
{
    const bool valid = QDir(m_projectPath).exists();

    if ( m_projectPathValid == valid )
        return;

    m_projectPathValid = valid;
    emit projectPathValidChanged();
}

void ProjectWatcher::updateProjectNameExists()
{
    if ( m_projectName.isEmpty() || m_projectPath.isEmpty() || !QDir(m_projectPath).exists() ) {
        m_projectNameValid = false;
        emit projectNameValidChanged();
        return;
    }

    const bool valid = !QDir(m_projectPath + "/" + m_projectName).exists();
    if ( m_projectNameValid == valid )
        return;

    m_projectNameValid = valid;
    emit projectNameValidChanged();
}

void ProjectWatcher::updateProjectPathWatcher()
{
    const QStringList directories = m_pathWatcher.directories();

    if ( !directories.isEmpty() )
        m_pathWatcher.removePaths(directories);

    if ( m_projectPath.isEmpty() )
        return;

    const QFileInfo info( m_projectPath );
    const QString parentPath = info.absoluteDir().absolutePath();

    if ( QDir(parentPath).exists() )
        m_pathWatcher.addPath(parentPath);
}

void ProjectWatcher::updateNameWatcher()
{
    const QStringList directories = m_nameWatcher.directories();

    if ( !directories.isEmpty() )
        m_nameWatcher.removePaths(directories);

    if ( m_projectPath.isEmpty() )
        return;

    if ( !QDir(m_projectPath).exists() )
        return;

    m_nameWatcher.addPath(m_projectPath);
}

QString ProjectWatcher::projectName() const { return m_projectName; }

void ProjectWatcher::setProjectName(const QString &projectName)
{
    if (m_projectName == projectName)
        return;
    m_projectName = projectName;

    updateProjectNameExists();
    updateNameWatcher();
    emit projectNameChanged();
}

QString ProjectWatcher::projectPath() const { return m_projectPath; }
void ProjectWatcher::setProjectPath(const QString &projectPath)
{

    if ( !QDir(projectPath).exists() )
        return;

    m_projectPath = projectPath;

    updateProjectPathExists();
    updateProjectNameExists();
    updateProjectPathWatcher();
    updateNameWatcher();
    emit projectPathChanged();
}
