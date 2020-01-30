#include "gnativepickermodel_default_p.h"

NativePickerModelPrivate *NativePickerModelPrivate::create(NativePickerModel *q)
{
    return new NativePickerModelDefaultPrivate(q);
}

NativePickerModelDefaultPrivate::NativePickerModelDefaultPrivate(NativePickerModel *q) :
    NativePickerModelPrivate(q)
{
}

void NativePickerModelDefaultPrivate::init()
{
}

void NativePickerModelDefaultPrivate::openPicker(const QVariantList &dataList, bool hasComponent)
{
    Q_UNUSED(dataList);
    Q_UNUSED(hasComponent);
}

void NativePickerModelDefaultPrivate::openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type)
{
    Q_UNUSED(dateTime);
    Q_UNUSED(type);
}

void NativePickerModelDefaultPrivate::closePicker()
{
}

bool NativePickerModelDefaultPrivate::isOpen() const
{
    return false;
}
