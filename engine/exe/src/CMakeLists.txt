include(ConfigureTarget)
include(CompilerWarnings)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../../cmake")

# TODO: create application that loads apps
# TODO: glob
add_library(exe
    "public/exe/Library.hpp"
    "public/exe/Library.cpp"
)
add_library(exe::exe ALIAS exe)
target_include_directories(exe PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/public")

if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    target_link_options(exe PUBLIC "-sUSE_SDL=2" "-sUSE_FREETYPE=1")
else()
    include(FetchSDL2)
    find_package(OpenGL)

    # glad is available from a previous call to add_subdirectory("dependencies")
    target_link_libraries(exe PUBLIC SDL2-static OpenGL::GL glad)

    if (UNIX AND NOT APPLE)
        target_link_libraries(exe PUBLIC "m" "atomic" "pthread")
    endif ()
endif()

configure_target(exe)
set_target_warnings(exe "${exciton_WARNINGS_AS_ERRORS}")

if( ${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    set( CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>" )
    set_property( DIRECTORY PROPERTY VS_STARTUP_PROJECT exe )
    #set_property( TARGET exe PROPERTY WIN32_EXECUTABLE true )
endif()