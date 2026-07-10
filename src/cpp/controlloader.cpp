#include "controlloader.h"
#include <QDebug>
#include <QCoreApplication>
#include <QDir>
#include <QTimer>

ControlLoader::ControlLoader(QObject *parent)
    : QObject{parent}, m_model(this)
{

}

void ControlLoader::load()
{
    emit loadingStarted();
    m_batchIndex = 0;
    m_paths.clear();
    m_model.clear();

    QDir dir(QCoreApplication::applicationDirPath() + "/Controls" );

    if ( !dir.exists() ){
        dir.mkpath(".");
        return;
    }

    const QFileInfoList entryInfoList = dir.entryInfoList( {"*.qml"} );
    if ( entryInfoList.isEmpty() )
        return;


    for ( const QFileInfo &info : entryInfoList) {
        m_paths.append(info.absoluteFilePath());
    }

    loadBatched();
}

ControlModel *ControlLoader::model() { return &m_model; }

void ControlLoader::append(const QString &path)
{
    if ( !m_model.append(path))
        return;

    QFileInfo info(path);
    QFile::copy(path, QCoreApplication::applicationDirPath() + "/Controls/" + info.fileName()  );
}

QJsonObject ControlLoader::toObject() const { return m_model.toObject(); }

void ControlLoader::loadBatched()
{
    int count = 0;

    while (count < m_batchSize && m_batchIndex < m_paths.length() ) {
        m_model.append(m_paths[m_batchIndex]);
        ++count;
        ++m_batchIndex;
    }

    if ( m_batchIndex < m_paths.length() ) {
        QTimer::singleShot(10, this, &ControlLoader::loadBatched);
    } else {
        m_batchIndex = 0;
        m_paths.clear();
    }

}
































