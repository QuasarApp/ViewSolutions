//#
//# Copyright (C) 2018-2021 Yankovich Andrei (EndrII).
//# Distributed under the lgplv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#

#ifndef VIEWSOLUTIONS_GLOBAL_H
#define VIEWSOLUTIONS_GLOBAL_H

#include <QtCore/qglobal.h>

/**
 * @brief VIEWSOLUTION_EXPORT marks a symbol as part of the public
 * ViewSolutions API.
 *
 * When the ViewSolutions shared library is built (VIEW_SOLUTIONS_LIBRARY
 * is defined) the macro expands to Q_DECL_EXPORT, otherwise to
 * Q_DECL_IMPORT for consuming applications.
 *
 * Example:
 * ```cpp
 * class VIEWSOLUTION_EXPORT ColorPicker
 * {
 * public:
 *     explicit ColorPicker();
 * };
 * ```
 */
#if defined(VIEW_SOLUTIONS_LIBRARY)
#  define VIEWSOLUTION_EXPORT Q_DECL_EXPORT
#else
#  define VIEWSOLUTION_EXPORT Q_DECL_IMPORT
#endif


#endif // VIEWSOLUTIONS_GLOBAL_H
