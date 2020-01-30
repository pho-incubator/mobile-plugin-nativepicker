#include <QtTest/QtTest>
#include <GroupsIncNativePicker/private/gnativepicker_p.h>

class tst_GNativePicker : public QObject
{
    Q_OBJECT
public:
    tst_GNativePicker() {}

private slots:
    void initTestCase();

};

void tst_GNativePicker::initTestCase()
{
}

QTEST_MAIN(tst_GNativePicker)

#include "tst_gnativepicker.moc"
