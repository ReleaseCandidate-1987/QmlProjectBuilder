#ifndef PROJECTWATCHER_H
#define PROJECTWATCHER_H

#include <QObject>
#include <QFileSystemWatcher>

/**
 * Überwacht den ausgewählten Projektpfad und prüft, ob der Projektname verwendet werden kann.
 *
 * Änderungen im Dateisystem werden automatisch erkannt, sodass die Gültigkeit
 * von Projektpfad und Projektname in der Benutzeroberfläche aktuell bleibt.
 */
class ProjectWatcher : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString projectPath READ projectPath WRITE setProjectPath NOTIFY projectPathChanged FINAL)
    Q_PROPERTY(bool projectPathValid READ projectPathValid NOTIFY projectPathValidChanged FINAL)
    Q_PROPERTY(QString projectName READ projectName WRITE setProjectName NOTIFY projectNameChanged FINAL)
    Q_PROPERTY(bool projectNameValid READ projectNameValid NOTIFY projectNameValidChanged FINAL)
public:
    /**
     * Erstellt einen ProjectWatcher und verbindet die Dateisystemüberwachung.
     *
     * @param parent Übergeordnetes QObject.
     */
    explicit ProjectWatcher(QObject *parent = nullptr);

    /**
     * Gibt zurück, ob der ausgewählte Projektpfad existiert.
     *
     * @return true, wenn der Projektpfad gültig ist, andernfalls false.
     */
    bool projectPathValid() const;

    /**
     * Gibt zurück, ob der Projektname im ausgewählten Verzeichnis verwendet werden kann.
     *
     * @return true, wenn noch kein gleichnamiges Projektverzeichnis existiert, andernfalls false.
     */
    bool projectNameValid() const;

    /**
     * Gibt den aktuell überwachten Projektpfad zurück.
     *
     * @return Der aktuelle Projektpfad.
     */
    QString projectPath() const;

    /**
     * Legt den zu überwachenden Projektpfad fest.
     *
     * Der Pfad wird nur übernommen, wenn das Verzeichnis bereits existiert.
     *
     * @param projectPath Neuer Projektpfad.
     */
    void setProjectPath(const QString &projectPath);

    /**
     * Gibt den aktuell geprüften Projektnamen zurück.
     *
     * @return Der aktuelle Projektname.
     */
    QString projectName() const;

    /**
     * Legt den zu prüfenden Projektnamen fest.
     *
     * @param projectName Neuer Projektname.
     */
    void setProjectName(const QString &projectName);



signals:
    /**
     * Wird ausgelöst, wenn sich die Gültigkeit des Projektpfads geändert hat.
     */
    void projectPathValidChanged();

    /**
     * Wird ausgelöst, wenn sich die Gültigkeit des Projektnamens geändert hat.
     */
    void projectNameValidChanged();

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
     * Prüft erneut, ob der aktuell gesetzte Projektpfad existiert.
     */
    void updateProjectPathExists();

    /**
     * Prüft erneut, ob im Projektpfad bereits ein Verzeichnis mit dem Projektnamen existiert.
     */
    void updateProjectNameExists();

    /**
     * Aktualisiert die Überwachung des übergeordneten Verzeichnisses des Projektpfads.
     */
    void updateProjectPathWatcher();

    /**
     * Aktualisiert die Überwachung des ausgewählten Projektverzeichnisses.
     */
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