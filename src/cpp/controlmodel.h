#ifndef CONTROLMODEL_H
#define CONTROLMODEL_H

#include <QAbstractListModel>
#include <QJsonObject>
#include <QObject>

struct Control
{
    QString name;
    QString fileName;
    QString path;
    QString content;
};

class ControlModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        FileNameRole,
        PathRole,
        ContentRole
    };
    explicit ControlModel(QObject *parent);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void clear();
    Q_INVOKABLE void remove(int row);
    Q_INVOKABLE bool append( const QString &path );
    Q_INVOKABLE bool containsName( const QString &name ) const ;
    Q_INVOKABLE QJsonObject toObject() const;

private:
    QList<Control> m_controls;

};

#endif // CONTROLMODEL_H
