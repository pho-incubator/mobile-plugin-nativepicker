#include <QtQml/qqmlextensionplugin.h>
#include <QtQml/qqml.h>
#include <GroupsIncNativePicker/gnativepickermodel.h>
#include <GroupsIncMvc/gmvcfacade.h>

QT_BEGIN_NAMESPACE

GMVC_DEFINE_MODEL(NativePickerModel)

class GNativePickerModule : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface/1.0")
public:
    void registerTypes(const char *uri)
    {
        Q_ASSERT(QLatin1String(uri) == QLatin1String("GroupsIncNativePicker"));

        // @uri GroupsIncNativePicker
        qmlRegisterSingletonType<NativePickerModel>(uri, 1, 0, "NativePickerModel", GMVC_MODEL(NativePickerModel));
    }

    void initializeEngine(QQmlEngine *engine, const char *uri)
    {
        Q_UNUSED(uri);
        Q_UNUSED(engine);
    }
};

QT_END_NAMESPACE

#include "nativepicker.moc"



