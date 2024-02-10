################################################################################
# CMake functions
################################################################################
include(project/ConfigureTarget)
include(project/CompilerWarnings)
################################################################################
# Dependencies
################################################################################
# TODO: order matters when including imgui
#include(libs/FetchIMGUI)

################################################################################
# Create the library target
################################################################################
add_library(exe
    "public/exe/Library.hpp"
    "private/Library.cpp"
)
add_library(exe::exe ALIAS exe)
target_include_directories(exe PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/public")
################################################################################
# Link Dependencies
################################################################################
#TODO: pull platform stuff into exciton pipeline
if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    target_link_options(exe PUBLIC "-sUSE_SDL=2" "-sUSE_FREETYPE=1")
else()
    add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../../libs" "${CMAKE_CURRENT_BINARY_DIR}/libs")

    include(libs/FetchSDL2)
    find_package(OpenGL)

    target_link_libraries(exe PUBLIC SDL2-static OpenGL::GL glad)
    if (UNIX AND NOT APPLE)
        target_link_libraries(exe PUBLIC "m" "atomic" "pthread")
    endif ()

    if( ${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set( CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>" )
        set_property( DIRECTORY PROPERTY VS_STARTUP_PROJECT exe )
        #set_property( TARGET exe PROPERTY WIN32_EXECUTABLE true )
    endif()
endif()
#configure
configure_target(exe)
set_target_warnings(exe "${WARNINGS_AS_ERRORS}")
set_target_properties(exe PROPERTIES FOLDER exe/)
