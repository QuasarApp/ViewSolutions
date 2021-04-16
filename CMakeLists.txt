#
# Copyright (C) 2018-2021 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

cmake_minimum_required(VERSION 3.5)

project(ViewSolutions LANGUAGES CXX)
if(TARGET ${PROJECT_NAME})
  message("The ${PROJECT_NAME} arledy included in main Project")
  return()
endif()


if ( NOT DEFINED VIEWSOLUTIONS_EXAMPLES )
    set(VIEWSOLUTIONS_EXAMPLES ON)

    if (DEFINED TARGET_PLATFORM_TOOLCHAIN)
        if (${TARGET_PLATFORM_TOOLCHAIN} STREQUAL "wasm32")
            set(VIEWSOLUTIONS_EXAMPLES OFF)
        endif()
    endif()

    if (ANDROID)
        set(VIEWSOLUTIONS_EXAMPLES OFF)
    endif()
endif()

include(CMake/QuasarAppCITargets.cmake)
include(CMake/ccache.cmake)
include(CMake/QtUtils.cmake)
include(CMake/ProjectOut.cmake)
include(CMake/crossplatform/crossplatform.cmake)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick QuickControls2 REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 REQUIRED)

add_subdirectory(ViewSolutions)

if (VIEWSOLUTIONS_EXAMPLES )
    message("DISABLE_EXAMPLES = ${DISABLE_EXAMPLES}")
    add_subdirectory(Examples)
endif()


initAll()

addDoc(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/doxygen.conf)
