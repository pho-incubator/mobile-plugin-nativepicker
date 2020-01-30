#include "gnativepickermodel_ios_p.h"

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include <qpa/qplatformnativeinterface.h>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQuickWindow>
#include <GroupsIncMvc/gmvcfacade.h>
#include "gnativepickermodel.h"

static inline NSString *toNSString(const QString &qString)
{
    QByteArray b = qString.toUtf8();
    return [NSString stringWithUTF8String:b.data()];
}

@interface PickerControllerDelegate : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NativePickerModelIosPrivate *m_pickerController;
    UIView *m_view;
    NSArray *m_dataList;
    BOOL m_component;
    CGRect m_viewRect;
    UIPickerView *m_picker;
    UIDatePicker *m_datePicker;
    UIDatePickerMode m_datePickerMode;
    CGFloat m_sectorWidth;
}

@end

@implementation PickerControllerDelegate

- (id)initWithPickerController:(NativePickerModelIosPrivate *)pickerController andView:(UIView *)view
{
    self = [super init];
    if (self) {
        m_pickerController = pickerController;
        m_view = view;
        m_dataList = nil;
        m_component = NO;
        m_viewRect = [[UIScreen mainScreen] bounds];
        m_picker = nil;
        m_datePicker = nil;
        m_sectorWidth = 0;
    }

    return self;
}

- (void)openPicker:(NSArray *)dataList component:(BOOL)component withColor:(UIColor *) color
{
    if (dataList == nil) {
        NSLog(@"DataList is null. Cannot continue to showPicker.");
        return;
    }

    [self closePicker];

    m_dataList = dataList;
    m_component = component;

    m_picker = [[UIPickerView alloc] init];
    m_picker.delegate = self;
    m_picker.dataSource = self;
    m_picker.showsSelectionIndicator = YES;

    CGSize pickerSize = [m_picker sizeThatFits:CGSizeZero];
    CGRect pickerRect = CGRectMake(0.,
                                       m_viewRect.origin.y + m_viewRect.size.height - pickerSize.height,
                                       m_viewRect.size.width,
                                       pickerSize.height);
    if (component)
        m_sectorWidth = (pickerRect.size.width - 20) / dataList.count;
    else
        m_sectorWidth = (pickerRect.size.width - 20);

    m_picker.frame = pickerRect;
    if (color != nil)
        m_picker.backgroundColor = color;

    [m_view addSubview:m_picker];
}

- (void)openDatePicker:(NSDate *)date mode:(UIDatePickerMode) mode withColor:(UIColor *)color
{
    [self closePicker];

    m_datePicker = [[UIDatePicker alloc] init];
    [m_datePicker addTarget:self
                            action:@selector(datePickerDateChanged:)
                            forControlEvents:UIControlEventValueChanged];

    if (date != nil)
        m_datePicker.date = date;

    m_datePickerMode = mode;
    m_datePicker.datePickerMode = mode;

    CGSize pickerSize = [m_datePicker sizeThatFits:CGSizeZero];
    CGRect pickerRect = CGRectMake(0.,
                                       m_viewRect.origin.y + m_viewRect.size.height - pickerSize.height,
                                       m_viewRect.size.width,
                                       pickerSize.height);

    m_datePicker.frame = pickerRect;
    if (color != nil)
        m_datePicker.backgroundColor = color;

    [m_view addSubview:m_datePicker];
}

- (void) closePicker
{
    if (m_datePicker != nil) {
        [m_datePicker removeFromSuperview];
        if (m_datePicker.date) {
            // [m_datePicker.date release];
        }

        [m_datePicker release];
        m_datePicker = nil;
    }

    if (m_picker != nil) {
        [m_picker removeFromSuperview];
        [m_picker release];

        m_picker = nil;
    }

    if (m_dataList != nil) {
        if (m_component) {
            int i = 0;
            int len = m_dataList.count;
            for (; i < len; i++)
                [(NSArray *)m_dataList[i] release];
        }

        [m_dataList release];
        m_dataList = nil;
    }
}

- (BOOL)isOpen
{
    return (m_picker != nil || m_datePicker != nil) ? YES : NO;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    Q_UNUSED(pickerView);
    return m_component ? ((NSArray *) m_dataList[component]).count : m_dataList.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    Q_UNUSED(pickerView);
    return m_component ? m_dataList.count : 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Q_UNUSED(pickerView);
    return m_component ? ((NSArray *) m_dataList[component])[row] : m_dataList[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    Q_UNUSED(pickerView);
    Q_UNUSED(component);
    return m_sectorWidth;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    emit m_pickerController->q_ptr->selected(row, component,
                                             QString::fromNSString([self pickerView:pickerView titleForRow:row forComponent:component]));
}

- (void) datePickerDateChanged:(UIDatePicker *)datePicker
{
    if (!datePicker)
        return;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                         | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:datePicker.date];

    switch (m_datePickerMode) {
        case UIDatePickerModeDate: {
            QDateTime dateTime;
            dateTime.setDate(QDate(components.year, components.month, components.day));
            emit m_pickerController->q_ptr->dateSelected(dateTime);
            break;
        }
        case UIDatePickerModeTime: {
            emit m_pickerController->q_ptr->timeSelected(components.hour, components.minute, components.second);
            break;
        }
        case UIDatePickerModeDateAndTime: {
            QDateTime dateTime;
            dateTime.setDate(QDate(components.year, components.month, components.day));
            dateTime.setTime(QTime(components.hour, components.minute, components.second));
            emit m_pickerController->q_ptr->dateTimeSelected(dateTime);
            break;
        }
        default:
            qCWarning(LNativePickerModel) << "Unhandled date picker mode.";
    }
}

@end

NativePickerModelPrivate *NativePickerModelPrivate::create(NativePickerModel *q)
{
    return new NativePickerModelIosPrivate(q);
}

NativePickerModelIosPrivate::NativePickerModelIosPrivate(NativePickerModel *q)
    : NativePickerModelPrivate(q)
    , m_delegate(0)
{
}

NativePickerModelIosPrivate::~NativePickerModelIosPrivate()
{
    if (m_delegate) {
        PickerControllerDelegate *delegate = id(m_delegate);
        [delegate release];
        m_delegate = 0;
    }
}

void NativePickerModelIosPrivate::init()
{
    if (!m_delegate) {
        Q_Q(NativePickerModel);
        MvcFacade *facade = qobject_cast<MvcFacade *>(q->parent());
        QObject *top = qobject_cast<QQmlApplicationEngine *>(facade->engine())->rootObjects().at(0);
        QQuickWindow *window = qobject_cast<QQuickWindow *>(top);
        UIView *view = static_cast<UIView *>(QGuiApplication::platformNativeInterface()->nativeResourceForWindow("uiview", window));

        m_delegate = [[PickerControllerDelegate alloc] initWithPickerController:this andView:view];
    }
}

void NativePickerModelIosPrivate::openPicker(const QVariantList &dataList, bool hasComponent)
{
    if (isOpen())
        return;

    PickerControllerDelegate *delegate = id(m_delegate);
    NSMutableArray *list = [[NSMutableArray alloc] init];

    int i = 0;
    int len = dataList.size();
    int k;
    int klen;
    QVariantList lowLevel;
    for (; i < len; i++) {
        if (hasComponent) {
            NSMutableArray *low = [[NSMutableArray alloc] init];
            [list addObject:low];

            if (dataList.at(i).type() != QVariant::List) {
                qCWarning(LNativePickerModel) << "Invalid data. Should be QVariantList.";
                continue;
            }

            lowLevel = dataList.at(i).toList();
            klen = lowLevel.size();
            for (k = 0; k < klen; k++) {
                if (lowLevel.at(k).type() != QVariant::String) {
                    qCWarning(LNativePickerModel) << "Invalid data. Should be QString." << lowLevel.at(k);
                    continue;
                }

                [low addObject:toNSString(lowLevel.at(k).toString())];
            }
        } else {
            if (dataList.at(i).type() != QVariant::String) {
                qCWarning(LNativePickerModel) << "Invalid data. Should be QString.";
                continue;
            }

            [list addObject:toNSString(dataList.at(i).toString())];
        }
    }

    [delegate openPicker:list component:hasComponent ? YES : NO withColor:[UIColor whiteColor]];
}

void NativePickerModelIosPrivate::openDatePicker(const QDateTime &dateTime, NativePickerModel::DatePickerType type)
{
    if (isOpen())
        return;

    PickerControllerDelegate *delegate = id(m_delegate);

    NSDate *date = nil;
    UIDatePickerMode mode;

    if (!dateTime.isNull())
        date = [NSDate dateWithTimeIntervalSince1970:static_cast<NSTimeInterval>(dateTime.toMSecsSinceEpoch()) / 1000];

    switch (type) {
        case NativePickerModel::TypeDate:
            mode = UIDatePickerModeDate;
            break;
        case NativePickerModel::TypeTime:
            mode = UIDatePickerModeTime;
            break;
        case NativePickerModel::TypeDateTime:
            mode = UIDatePickerModeDateAndTime;
            break;
    }

    [delegate openDatePicker:date mode:mode withColor:[UIColor whiteColor]];
}

void NativePickerModelIosPrivate::closePicker()
{
    if (!m_delegate)
        return;

    PickerControllerDelegate *delegate = id(m_delegate);
    [delegate closePicker];
}

bool NativePickerModelIosPrivate::isOpen() const
{
    PickerControllerDelegate *delegate = id(m_delegate);
    return [delegate isOpen] ? true : false;
}
