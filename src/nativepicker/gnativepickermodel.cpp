#include "gnativepickermodel.h"
#include "gnativepickermodel_p.h"

const char *NativePickerModel::NAME = "NativePickerModel";

Q_LOGGING_CATEGORY(LNativePickerModel, "GroupsInc.NativePicker")

NativePickerModel::NativePickerModel(MvcFacade *parent)
    : MvcModel(parent)
    , d_ptr(NativePickerModelPrivate::create(this))
{
}

NativePickerModel::~NativePickerModel()
{
    delete d_ptr;
}

void NativePickerModel::openPicker(const QVariantList &dataList, bool hasComponent)
{
    Q_D(NativePickerModel);
    d->openPicker(dataList, hasComponent);
}

void NativePickerModel::openDatePicker(const QDateTime &dateTime, DatePickerType type)
{
    Q_D(NativePickerModel);
    d->openDatePicker(dateTime, type);
}

void NativePickerModel::closePicker()
{
    Q_D(NativePickerModel);
    d->closePicker();
}

bool NativePickerModel::isOpen() const
{
    Q_D(const NativePickerModel);
    return d->isOpen();
}

void NativePickerModel::init()
{
    Q_D(NativePickerModel);
    d->init();
}

const char *NativePickerModel::name()
{
    return NAME;
}

void NativePickerModel::apply(const QVariantMap &config)
{
    Q_UNUSED(config);
}

