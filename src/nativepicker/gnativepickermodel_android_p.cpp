#include "gnativepickermodel_android_p.h"

NativePickerModelPrivate *NativePickerModelPrivate::create(NativePickerModel *q)
{
    return new NativePickerModelAndroidPrivate(q);
}

NativePickerModelAndroidPrivate::NativePickerModelAndroidPrivate(NativePickerModel *q) :
    NativePickerModelPrivate(q)
{
}

void NativePickerModelAndroidPrivate::openPicker(const QVariantList &dataList, bool hasComponent)
{
    Q_UNUSED(dataList);
    Q_UNUSED(hasComponent);
}

void NativePickerModelAndroidPrivate::openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type)
{
    Q_UNUSED(dateTime);
    Q_UNUSED(type);
}

void NativePickerModelAndroidPrivate::closePicker()
{
}

void NativePickerModelAndroidPrivate::isOpen() const
{
    return false;
}
