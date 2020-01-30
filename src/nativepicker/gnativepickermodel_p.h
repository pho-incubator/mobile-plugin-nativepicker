#ifndef NATIVEPICKERMODEL_P_H
#define NATIVEPICKERMODEL_P_H

#include <QObject>
#include "gnativepickermodel.h"

class NativePickerModelPrivate : public QObject
{
    Q_OBJECT
public:
    NativePickerModelPrivate(NativePickerModel *q)
        : QObject(0)
        , q_ptr(q) {}

    static NativePickerModelPrivate *create(NativePickerModel *q);

    virtual void init() = 0;
    virtual void openPicker(const QVariantList &dataList, bool hasComponent = false) = 0;
    virtual void openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type) = 0;
    virtual void closePicker() = 0;
    virtual bool isOpen() const = 0;

public:
    Q_DECLARE_PUBLIC(NativePickerModel)
    NativePickerModel *q_ptr;
};

#endif // NATIVEPICKERMODEL_P_H
