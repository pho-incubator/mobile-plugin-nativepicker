# ANDROID_BUNDLED_JAR_DEPENDENCIES = \
#    jar/GroupsIncAndroidNativePicker-bundled.jar
# ANDROID_JAR_DEPENDENCIES = \
#    jar/GroupsIncAndroidNativePicker.jar

INCLUDEPATH += $$PWD

PUBLIC_HEADERS += \
    gnativepicker_global.h \
    gnativepickermodel.h

PRIVATE_HEADERS += \
    gnativepickermodel_p.h

SOURCES += \
    gnativepickermodel.cpp

android {
    QT += androidextras

    PRIVATE_HEADERS += \
        gnativepickermodel_android_p.h

    SOURCES += \
        gnativepickermodel_android_p.cpp

} else:ios {

    QT += gui-private

    PRIVATE_HEADERS += \
        gnativepickermodel_ios_p.h

    OBJECTIVE_SOURCES += \
        gnativepickermodel_ios_p.mm

    LIBS += -framework MessageUI

} else {
    
    PRIVATE_HEADERS += \
        gnativepickermodel_default_p.h

    SOURCES += \
        gnativepickermodel_default_p.cpp
}

HEADERS += $$PUBLIC_HEADERS $$PRIVATE_HEADERS
