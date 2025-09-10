QT       += core gui network widgets concurrent

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++20
QMAKE_CXXFLAGS += -std=c++20

# Include paths for thirdparty, SV_FLATBUFFERS, and images
INCLUDEPATH += $$PWD/assets
INCLUDEPATH += $$PWD/include
INCLUDEPATH += $$PWD/logs
INCLUDEPATH += $$PWD/pokedata

# Add files to DISTFILES for deployment
DISTFILES += $$files($$PWD/assets/*, true)
DISTFILES += $$files($$PWD/include/*, true)
DISTFILES += $$files($$PWD/logs/*, true)
DISTFILES += $$files($$PWD/pokedata/*, true)

# Enable compatibility for building across platforms
win32 {
    CONFIG += windows
    CONFIG -= debug_and_release debug_and_release_target
    QMAKE_HOST.arch:equals(x86_64) {
        DEFINES += ARCH_64
        message("Building for 64-bit Windows")
    } else {
        DEFINES += ARCH_32
        message("Building for 32-bit Windows")
    }

    RC_FILE = app_icon.rc

    # Paths for source and destination directories

    POKEDATA_SRC = $$PWD/pokedata
    IMAGES_SRC = $$PWD/assets
    INCLUDE_SRC = $$PWD/include
    LOGS_SRC = $$PWD/logs

    # Destination directory adjusted for release/debug
    CONFIG(debug, debug|release) {
        BUILD_DIR = $$OUT_PWD
    } else {
        BUILD_DIR = $$OUT_PWD
    }

    POKEDATA_DEST = $$BUILD_DIR/pokedata
    IMAGES_DEST = $$BUILD_DIR/assets
    INCLUDE_DEST = $$BUILD_DIR/include
    LOGS_DEST = $$BUILD_DIR/logs


    SOURCE_DIR_WIN = $$replace(POKEDATA_SRC, /, \\)
    DEST_DIR_WIN = $$replace(POKEDATA_DEST, /, \\)
    SOURCE_IMAGE_WIN = $$replace(IMAGES_SRC, /, \\)
    DEST_IMAGE_WIN = $$replace(IMAGES_DEST, /, \\)
    SOURCE_INCLUDE_WIN = $$replace(INCLUDE_SRC, /, \\)
    DEST_INCLUDE_WIN = $$replace(INCLUDE_DEST, /, \\)
    DEST_LOGS_WIN = $$replace(LOGS_DEST, /, \\)
    SOURCE_LOGS_WIN = $$replace(LOGS_SRC, /, \\)

    copy_third.commands = \
        $$QMAKE_COPY_DIR \"$$SOURCE_DIR_WIN\" \"$$DEST_DIR_WIN\" && \
        $$QMAKE_COPY_DIR \"$$SOURCE_IMAGE_WIN\" \"$$DEST_IMAGE_WIN\" && \
        $$QMAKE_COPY_DIR \"$$SOURCE_INCLUDE_WIN\" \"$$DEST_INCLUDE_WIN\" && \
        $$QMAKE_COPY_DIR \"$$SOURCE_LOGS_WIN\" \"$$DEST_LOGS_WIN\"


    QMAKE_EXTRA_TARGETS += copy_third
    PRE_TARGETDEPS += copy_third
    CONFIG(debug, debug|release) {
        BUILD_DIR = $$OUT_PWD
    } else {
        DEPLOY_PATH = $$OUT_PWD
        DEPLOY_SCRIPT = $$PWD/scripts/deploy_windows.bat
        post_build.commands = $$DEPLOY_SCRIPT $$OUT_PWD/VGCCalculator.exe $$DEPLOY_PATH
        QMAKE_EXTRA_TARGETS += post_build
        QMAKE_POST_LINK += $(MAKE) -f Makefile post_build
    }
}

# Subfolders visibility in the project sidebar
VPATH += $$unique($$dirname($$files(src/*, true)))
VPATH += $$unique($$dirname($$files(headers/*, true)))

# Recursively include all .cpp and .h files from src and headers directories
SOURCES += $$files(src/*.cpp, true) \

HEADERS += $$files(headers/*.h, true) \

FORMS +=

# Deployment paths
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Handle platform-specific libraries and dependencies
macx {
    LIBS += -framework Cocoa
}

win32 {
    LIBS += -luser32 -lgdi32 -lcomdlg32
}

unix:!macx {
    LIBS += -lpthread
}

# Additional build configurations
DEFINES += QT_DEPRECATED_WARNINGS

message($$system($$QMAKE_CXX --version))
