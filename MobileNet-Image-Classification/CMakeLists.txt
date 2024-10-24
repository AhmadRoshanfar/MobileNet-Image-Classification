cmake_minimum_required(VERSION 3.16)

project(MobileNet-Image-Classification VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
find_package( OpenCV REQUIRED )
include_directories( ${OpenCV_INCLUDE_DIRS} )

qt_standard_project_setup()

qt_add_executable(appMobileNet-Image-Classification
    main.cpp
)

qt_add_qml_module(appMobileNet-Image-Classification
    URI Qt-ImageClassification
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCES resources.qrc
    SOURCES aimodel.h aimodel.cpp
)

ADD_LIBRARY(tensorflowlite SHARED IMPORTED)
set_property(TARGET tensorflowlite PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_SOURCE_DIR}/libs/libtensorflowlite.so)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appMobileNet-Image-Classification PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appQt-ImageClassification
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appMobileNet-Image-Classification
    PRIVATE Qt6::Quick
    tensorflowlite
    ${OpenCV_LIBS}
)

# target_link_libraries(appQt-ImageClassification tensorflowlite)

include(GNUInstallDirs)
install(TARGETS appMobileNet-Image-Classification
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
