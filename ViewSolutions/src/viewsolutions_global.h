//#
//# Copyright (C) 2018-2020 Yankovich Andrei (EndrII).
//# Distributed under the lgplv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef VIEWSOLUTIONS_GLOBAL_H
#define VIEWSOLUTIONS_GLOBAL_H

#include <QtCore/qglobal.h>

#if defined(VIEW_SOLUTIONS_LIBRARY)
#  define LOGINVIEW_EXPORT Q_DECL_EXPORT
#else
#  define LOGINVIEW_EXPORT Q_DECL_IMPORT
#endif


#endif // VIEWSOLUTIONS_GLOBAL_H
