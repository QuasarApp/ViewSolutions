#
# Copyright (C) 2018-2025 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

cmake_minimum_required(VERSION 3.19)

project(ViewSolutions LANGUAGES CXX)
if(TARGET ${PROJECT_NAME})
  message("The ${PROJECT_NAME} arledy included in main Project")
  return()
endif()

option(QT_QML_GENERATE_QMLLS_INI "Generate QML Language Server Support file" ON)

if (ANDROID OR IOS)
    option(VIEWSOLUTIONS_EXAMPLES "Build examples" OFF)
else()
    option(VIEWSOLUTIONS_EXAMPLES "Build examples" ON)
endif()


include(CMake/QuasarApp.cmake)

updateGitVarsWithHash("c8f0b3222d1811e3467a2fa46645c720e31b2860")
set(VIEWSOLUTIONS_VERSION 1.0.${GIT_COMMIT_COUNT_FROM}.${GIT_COMMIT_HASH})

find_package(QT NAMES Qt6 COMPONENTS Core Quick QuickControls2 REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 REQUIRED)

qt_standard_project_setup()
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

add_subdirectory(ViewSolutions)

if (VIEWSOLUTIONS_EXAMPLES )
    add_subdirectory(Examples)
endif()


initAll()
configure_file_in(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/doxygen.conf)
addDoc(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/doxygen.conf)
