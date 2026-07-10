#ifndef CONTROLLOADER_H
#define CONTROLLOADER_H

#include "src/cpp/controlmodel.h"
#include <QObject>

class ControlLoader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ControlModel *model READ model  CONSTANT  FINAL)
public:
    explicit ControlLoader(QObject *parent = nullptr);
    Q_INVOKABLE void load();

    ControlModel *model();
    Q_INVOKABLE void append( const QString &path );
    Q_INVOKABLE QJsonObject toObject() const;
signals:
    void loadingStarted();
private:
    void loadBatched();
private:
    ControlModel m_model;
    QStringList m_paths;
    int m_batchSize = 1;
    int m_batchIndex = 0;
};

#endif // CONTROLLOADER_H
