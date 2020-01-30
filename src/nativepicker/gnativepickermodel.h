#ifndef NATIVEPICKERMODEL_H
#define NATIVEPICKERMODEL_H

#include <QObject>
#include <GroupsIncMvc/gmvcmodel.h>
#include "gnativepicker_global.h"
#include <QLoggingCategory>
#include <QDateTime>

Q_DECLARE_LOGGING_CATEGORY(LNativePickerModel)

class NativePickerModelPrivate;

class Q_NATIVEPICKER_EXPORT NativePickerModel : public MvcModel
{
    Q_OBJECT
    Q_ENUMS(DatePickerType)
public:
    enum DatePickerType {
        TypeDate,
        TypeTime,
        TypeDateTime
    };

    explicit NativePickerModel(MvcFacade *parent = 0);
    ~NativePickerModel();

    Q_INVOKABLE void openPicker(const QVariantList &dataList, bool hasComponent = false);
    Q_INVOKABLE void openDatePicker(const QDateTime &dateTime = QDateTime(), DatePickerType type = TypeDateTime);
    Q_INVOKABLE void closePicker();
    Q_INVOKABLE bool isOpen() const;

    static const char *NAME;

    void init();
    const char *name();
    void apply(const QVariantMap &config);

Q_SIGNALS:
    void selected(int index, int component, const QString &node);

    void dateSelected(const QDateTime &value);
    void timeSelected(int hour, int minute, int second);
    void dateTimeSelected(const QDateTime &value);


private:
    Q_DECLARE_PRIVATE(NativePickerModel)
    NativePickerModelPrivate *d_ptr;

};

#endif // NATIVEPICKERMODEL_H
