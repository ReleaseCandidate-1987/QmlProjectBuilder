QT += quick quickcontrols2

SOURCES += \
        main.cpp \
        src/cpp/controlloader.cpp \
        src/cpp/controlmodel.cpp \
        src/cpp/fileutils.cpp \
        src/cpp/projectbuilder.cpp \
        src/cpp/projectwatcher.cpp

CONFIG += c++20

RESOURCES += QmlProjectBuilder.qrc
RC_ICONS = assets/icons/icon.ico
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += "."

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH += "."

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/cpp/controlloader.h \
    src/cpp/controlmodel.h \
    src/cpp/fileutils.h \
    src/cpp/projectbuilder.h \
    src/cpp/projectwatcher.h


