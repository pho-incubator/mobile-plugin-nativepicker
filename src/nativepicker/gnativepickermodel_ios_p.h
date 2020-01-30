#ifndef NATIVEPICKERMODEL_IOS_P_H
#define NATIVEPICKERMODEL_IOS_P_H

#include "gnativepickermodel_p.h"

class NativePickerModelIosPrivate : public NativePickerModelPrivate
{
    Q_OBJECT
public:
    explicit NativePickerModelIosPrivate(NativePickerModel *q);
    virtual ~NativePickerModelIosPrivate();

    void init();
    void openPicker(const QVariantList &dataList, bool hasComponent = false);
    void openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type);
    void closePicker();
    bool isOpen() const;

private:
    void *m_delegate;
};

#endif // NATIVEPICKERMODEL_IOS_P_H
