#ifndef NATIVEPICKERMODEL_ANDROID_P_H
#define NATIVEPICKERMODEL_ANDROID_P_H

#include "gnativepickermodel_p.h"
#include "gnativepickermodel.h"

class NativePickerModelAndroidPrivate : public NativePickerModelPrivate
{
    Q_OBJECT
public:
    NativePickerModelAndroidPrivate(NativePickerModel *q);

    void init();
    void openPicker(const QVariantList &dataList, bool hasComponent = false);
    void openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type);
    void closePicker();
    bool isOpen() const;
};

#endif // NATIVEPICKERMODEL_ANDROID_P_H
