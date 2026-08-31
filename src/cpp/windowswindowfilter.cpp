#include "windowswindowfilter.h"
#include <windows.h>

void WindowsWindowFilter::setWindow(QWindow *window)
{
    if ( !window )
        return;

    m_windowId = static_cast<quintptr>(window->winId());

    HWND hwnd = reinterpret_cast<HWND>(m_windowId);

    LONG_PTR style = GetWindowLongPtr(hwnd, GWL_STYLE);
    style |= WS_THICKFRAME | WS_MAXIMIZEBOX | WS_SYSMENU;
    SetWindowLongPtrW(hwnd, GWL_STYLE, style);

    SetWindowPos(hwnd, nullptr, 0,0,0,0, SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOACTIVATE | SWP_FRAMECHANGED );
}

bool WindowsWindowFilter::nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result)
{
    if ( eventType != "windows_generic_MSG")
        return false;

    MSG *msg = static_cast<MSG *>(message);

    if ( !msg || reinterpret_cast<quintptr>(msg->hwnd) != m_windowId )
        return false;

    if ( msg->message == WM_NCCALCSIZE && msg->wParam == TRUE ) {
        NCCALCSIZE_PARAMS *params = reinterpret_cast<NCCALCSIZE_PARAMS *>(msg->lParam);
        const LONG originalTop = params->rgrc[0].top;
        DefWindowProcW(msg->hwnd, msg->message, msg->wParam, msg->lParam);

        params->rgrc[0].top = originalTop;

        *result = 0;
        return true;
    }

    return false;
}
