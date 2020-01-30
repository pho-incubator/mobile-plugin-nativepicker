CXX_MODULE = nativepicker
TARGET  = declarative_nativepicker
TARGETPATH = GroupsIncNativePicker
IMPORT_VERSION = 1.0

QT += qml quick mvc nativepicker nativepicker-private
SOURCES += \
    $$PWD/nativepicker.cpp

load(qml_plugin)

OTHER_FILES += qmldir
