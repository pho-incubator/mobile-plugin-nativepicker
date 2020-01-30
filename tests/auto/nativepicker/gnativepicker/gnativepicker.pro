CONFIG += testcase parallel_test
TARGET = tst_gnativepicker
osx:CONFIG -= app_bundle

QT += nativepicker nativepicker-private testlib
SOURCES += \
    tst_gnativepicker.cpp
