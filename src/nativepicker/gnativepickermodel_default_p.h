#ifndef NATIVEPICKERMODEL_DEFAULT_P_H
#define NATIVEPICKERMODEL_DEFAULT_P_H

#include "gnativepickermodel_p.h"
#include "gnativepickermodel.h"

class NativePickerModelDefaultPrivate : public NativePickerModelPrivate
{
    Q_OBJECT
public:
    NativePickerModelDefaultPrivate(NativePickerModel *q);

    void init();
    void openPicker(const QVariantList &dataList, bool hasComponent = false);
    void openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type);
    void closePicker();
    bool isOpen() const;
};

#endif // MAILMODEL_DEFAULT_P_H
