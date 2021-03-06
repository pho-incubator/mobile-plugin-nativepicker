#ifndef NATIVEPICKER_GLOBAL_H
#define NATIVEPICKER_GLOBAL_H

#include <QtCore/qglobal.h>

QT_BEGIN_NAMESPACE

#ifndef QT_STATIC
#  if defined(QT_BUILD_NATIVEPICKER_LIB)
#    define Q_NATIVEPICKER_EXPORT Q_DECL_EXPORT
#  else
#    define Q_NATIVEPICKER_EXPORT Q_DECL_IMPORT
#  endif
#else
#  define Q_NATIVEPICKER_EXPORT
#endif

QT_END_NAMESPACE

#endif
