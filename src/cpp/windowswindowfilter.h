#ifndef WINDOWSWINDOWFILTER_H
#define WINDOWSWINDOWFILTER_H

#include <QAbstractNativeEventFilter>
#include <QWindow>

/**
 * Verarbeitet native Windows-Ereignisse für das benutzerdefinierte Anwendungsfenster.
 *
 * Der Filter sorgt dafür, dass das Fenster trotz eigener Titelleiste weiterhin
 * über den nativen Fensterrahmen skaliert und maximiert werden kann.
 */
class WindowsWindowFilter : public QAbstractNativeEventFilter
{
public:
    /**
     * Legt das Fenster fest, dessen native Ereignisse verarbeitet werden sollen.
     *
     * Dabei werden die benötigten Windows-Fensterstile für Größenänderungen,
     * Maximierung und das Systemmenü aktiviert.
     *
     * @param window Zu überwachendes Anwendungsfenster.
     */
    void setWindow(QWindow *window);

    /**
     * Verarbeitet die nativen Windows-Nachrichten des festgelegten Fensters.
     *
     * @param eventType Typ des nativen Ereignisses.
     * @param message Zeiger auf die empfangene Windows-Nachricht.
     * @param result Speicherort für das Ergebnis der Ereignisverarbeitung.
     * @return true, wenn das Ereignis verarbeitet wurde, andernfalls false.
     */
    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result);


private:
    quintptr m_windowId = 0;
};

#endif // WINDOWSWINDOWFILTER_H