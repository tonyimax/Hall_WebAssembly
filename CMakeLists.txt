cmake_minimum_required(VERSION 3.16)

project(Hall VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_AUTORCC ON) #加载qrc
qt_add_executable(appHall
    main.cpp hall_ui.qrc #链接资源文件
)

qt_add_qml_module(appHall
    URI Hall
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES hall_ui.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appHall PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appHall
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appHall
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appHall
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
