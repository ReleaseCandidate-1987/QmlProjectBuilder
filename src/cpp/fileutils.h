#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>
#include <QQmlEngine>

/**
 * Stellt Hilfsfunktionen für Verzeichnisse, Dateipfade und Projektvorlagen bereit.
 *
 * Die Klasse wird in QML als Singleton verwendet und stellt dort ausgewählte
 * Funktionen über Q_INVOKABLE zur Verfügung.
 */
class FileUtils : public QObject
{
    Q_OBJECT
public:
    /**
     * Stellt die Singleton-Instanz für die Registrierung in QML bereit.
     *
     * @param engine Verwendete QML-Engine.
     * @param scriptEnginge Verwendete JavaScript-Engine.
     * @return Die von QML verwendete FileUtils-Instanz.
     */
    static FileUtils *singletonProvider(QQmlEngine *engine, QJSEngine *scriptEnginge);

    /**
     * Prüft, ob das angegebene Verzeichnis existiert.
     *
     * @param path Pfad des zu prüfenden Verzeichnisses.
     * @return true, wenn das Verzeichnis existiert, andernfalls false.
     */
    Q_INVOKABLE static bool dirExists(const QString &path);

    /**
     * Prüft, ob der angegebene Pfad ein Projektverzeichnis beschreibt.
     *
     * @param path Pfad des zu prüfenden Verzeichnisses.
     * @return true, wenn der Pfad ein Projektverzeichnis ist, andernfalls false.
     */
    Q_INVOKABLE static bool isProjectDir(const QString &path);

    /**
     * Wandelt eine lokale Datei-URL in einen Dateipfad um.
     *
     * @param url Zu konvertierende Datei-URL.
     * @return Der entsprechende lokale Dateipfad.
     */
    Q_INVOKABLE static QString toLocalFile(const QUrl &url);

    /**
     * Wandelt eine als Text übergebene Datei-URL in einen lokalen Dateipfad um.
     *
     * @param path Zu konvertierende Datei-URL.
     * @return Der entsprechende lokale Dateipfad.
     */
    Q_INVOKABLE static QString toLocalFile(const QString &path);

    /**
     * Wandelt einen lokalen Dateipfad in eine Datei-URL um.
     *
     * @param path Zu konvertierender Dateipfad.
     * @return Die entsprechende Datei-URL als Text.
     */
    Q_INVOKABLE static QString fromLocalFile(const QString &path);

    /**
     * Liest den vollständigen Inhalt einer Datei.
     *
     * @param path Pfad der zu lesenden Datei.
     * @return Der gelesene Dateiinhalt.
     */
    static QString read(const QString &path);

    /**
     * Schreibt den angegebenen Inhalt in eine Datei.
     *
     * @param path Pfad der Zieldatei.
     * @param content Zu schreibender Inhalt.
     * @return true, wenn die Datei erfolgreich geschrieben wurde, andernfalls false.
     */
    static bool write(const QString &path, const QString &content);

    /**
     * Ersetzt mehrere Platzhalter innerhalb eines Textes durch die übergebenen Werte.
     *
     * @param content Inhalt, in dem die Platzhalter ersetzt werden.
     * @param args Paare aus Platzhaltern und den dazugehörigen Ersatzwerten.
     */
    template<typename... Args>
    static void replaceContent(QString &content, Args&& ...args) {
        ( content.replace( args.first, QVariant::fromValue(args.second).toString() ), ... );
    }

private:
    /**
     * Erstellt die intern verwendete Singleton-Instanz.
     *
     * @param parent Übergeordnetes QObject.
     */
    explicit FileUtils(QObject *parent = nullptr);
    Q_DISABLE_COPY_MOVE(FileUtils)
signals:
};

#endif // FILEUTILS_H