#include "controlmodel.h"
#include "src/cpp/fileutils.h"

#include <QFileInfo>
#include <QJsonArray>
#include <algorithm>

ControlModel::ControlModel(QObject *parent) : QAbstractListModel(parent) {}

int ControlModel::rowCount(const QModelIndex &parent) const
{
    if ( parent.isValid() )
        return 0;

    return m_controls.size();
}

QVariant ControlModel::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() )
        return {};

    if ( index.row() < 0 || index.row() >= m_controls.size() )
        return {};

    const Control control = m_controls.at(index.row());

    switch (role) {
    case NameRole:
        return control.name;
    case FileNameRole:
        return control.fileName;
    case PathRole:
        return control.path;
    case ContentRole:
        return control.content;
    default:
        return {};
    }
}

QHash<int, QByteArray> ControlModel::roleNames() const
{
    return {
             { NameRole, "name" },
             { FileNameRole, "fileName" },
             { PathRole, "path" },
             { ContentRole, "content" },
             };
}

void ControlModel::clear()
{
    beginResetModel();
    m_controls.clear();
    endResetModel();
}

void ControlModel::remove(int row)
{
    if ( row < 0 || row >= m_controls.size() )
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_controls.removeAt(row);
    endRemoveRows();
}

bool ControlModel::append(const QString &path)
{
    QFileInfo controlInfo(path);

    if ( containsName(controlInfo.baseName()))
        return false;

    const QString content = FileUtils::read(path);

    beginInsertRows(QModelIndex(), m_controls.size(), m_controls.size() );
    m_controls.append({
        controlInfo.baseName(),
        controlInfo.fileName(),
        controlInfo.absoluteFilePath(),
        content
    });
    endInsertRows();
    return true;
}

bool ControlModel::containsName(const QString &name) const
{
    return std::ranges::any_of(m_controls, [&name](const Control &control) {
        return control.name == name;
    });
}

QJsonObject ControlModel::toObject() const
{
    QJsonObject controlObject;
    QJsonArray arr;

    for ( const Control &control: m_controls ) {
        QJsonObject obj;
        obj["name"] = control.name;
        obj["fileName"] = control.fileName;
        obj["path"] = control.path;
        obj["content"] = control.content;
        arr.append(obj);
    }

    controlObject["controls"] = arr;
    return controlObject;
}













































