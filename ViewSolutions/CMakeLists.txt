#
# Copyright (C) 2018-2025 QuasarApp.
# Distributed under the lgplv3 software license, see the accompanying
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#

cmake_minimum_required(VERSION 3.19)
set(CURRENT_PROJECT "${PROJECT_NAME}")

add_definitions(-DVIEW_SOLUTIONS_LIBRARY)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


file(GLOB SOURCE_CPP
    "src/*.cpp"
    "src/*.h"

)

file(GLOB_RECURSE MODULE_QML_FILES
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "ViewSolutions/*.qml"
)

qt_add_library(${CURRENT_PROJECT} ${SOURCE_CPP})


qt_add_qml_module(${CURRENT_PROJECT}
    URI ViewSolutions
    VERSION 1.0
    QML_FILES  ${MODULE_QML_FILES}
    # RESOURCES ${SOURCE_ASSETS}
    SOURCES  ${SOURCE_CPP}
    NO_PLUGIN
)

target_link_libraries(${CURRENT_PROJECT} PUBLIC Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2)
target_include_directories(${CURRENT_PROJECT} PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/src")


if (NOT QML_IMPORT_PATH MATCHES "${CMAKE_CURRENT_BINARY_DIR}/..")
    set(QML_IMPORT_PATH ${QML_IMPORT_PATH} "${CMAKE_CURRENT_BINARY_DIR}/.." CACHE STRING "update global variable to access to qml from qt creator." FORCE)
endif()
