#ifndef PROJECTBUILDER_H
#define PROJECTBUILDER_H

#include "fileutils.h"

#include <QObject>

#include <QFileSystemWatcher>
#include <QDir>
#include <QJsonObject>

/**
 * Erstellt ein neues QML-Projekt anhand der ausgewählten Einstellungen.
 *
 * Der ProjectBuilder legt die benötigte Ordnerstruktur an, verarbeitet die
 * Projektvorlagen und erzeugt die dazugehörige Ressourcendatei.
 */
class ProjectBuilder : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString projectPath READ projectPath WRITE setProjectPath NOTIFY projectPathChanged FINAL)
    Q_PROPERTY(QString projectName READ projectName WRITE setProjectName NOTIFY projectNameChanged FINAL)
public:
    /**
     * Erstellt einen ProjectBuilder.
     *
     * @param parent Übergeordnetes QObject.
     */
    explicit ProjectBuilder(QObject *parent = nullptr);

    /**
     * Gibt das Zielverzeichnis des neuen Projekts zurück.
     *
     * @return Der aktuell festgelegte Projektpfad.
     */
    QString projectPath() const;

    /**
     * Legt das Zielverzeichnis des neuen Projekts fest.
     *
     * @param projectPath Neuer Projektpfad.
     */
    void setProjectPath(const QString &projectPath);

    /**
     * Gibt den Namen des neuen Projekts zurück.
     *
     * @return Der aktuell festgelegte Projektname.
     */
    QString projectName() const;

    /**
     * Legt den Namen des neuen Projekts fest.
     *
     * @param projectName Neuer Projektname.
     */
    void setProjectName(const QString &projectName);

    /**
     * Erstellt das Projekt mit den übergebenen Einstellungen.
     *
     * @param obj Einstellungen für Projektgröße, Darstellung, Schriftart und das anschließende Öffnen des Projekts.
     */
    Q_INVOKABLE void build( const QJsonObject &obj );

signals:
    /**
     * Wird ausgelöst, wenn sich der Projektpfad geändert hat.
     */
    void projectPathChanged();

    /**
     * Wird ausgelöst, wenn sich der Projektname geändert hat.
     */
    void projectNameChanged();

private:
    /**
     * Erstellt eine Datei aus einer Vorlage und ersetzt darin die übergebenen Platzhalter.
     *
     * @param templatePath Pfad der verwendeten Vorlage.
     * @param path Zielpfad der zu erstellenden Datei.
     * @param args Paare aus Platzhaltern und den dazugehörigen Ersatzwerten.
     */
    template<typename... Args>
    void create( const QString &templatePath, const QString &path, Args&& ...args ) {
        addRelativePath(path);
        QString temp = FileUtils::read(templatePath);
        FileUtils::replaceContent( temp, std::forward<Args>(args)... );
        FileUtils::write(path, temp);
    }

    /**
     * Schreibt einen Inhalt in eine Datei und nimmt deren Pfad in die Ressourcenliste auf.
     *
     * @param path Pfad der zu erstellenden Datei.
     * @param content Zu schreibender Inhalt.
     */
    void write(const QString &path, const QString &content);

    /**
     * Erstellt die Ressourcendatei aus den zuvor erfassten Projektdateien.
     *
     * @param path Zielpfad der Ressourcendatei.
     */
    void createQrc( const QString &path );

    /**
     * Nimmt den relativen Pfad einer erstellten Datei in die Ressourcenliste auf.
     *
     * @param path Absoluter Pfad der erstellten Datei.
     */
    void addRelativePath( const QString &path );
private:
    QString m_projectPath;
    QString m_projectName;
    QDir m_projectDir;
    QStringList m_relativePaths;

};

#endif // PROJECTBUILDER_H