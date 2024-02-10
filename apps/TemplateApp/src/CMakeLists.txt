################################################################################
# CMake functions
################################################################################
include(project/ConfigureTarget)
include(project/CompilerWarnings)
################################################################################
# Dependencies
################################################################################
include(libs/FetchIMGUI)
################################################################################
# Create the library target
################################################################################
add_library(${TARGET_NAME}_object OBJECT
    "public/${TARGET_NAME}/Game.hpp"
    "private/Game.cpp"
)
# link with exciton
target_link_libraries(${TARGET_NAME}_object PUBLIC exe::exe)
# link with additional libs
target_link_libraries(${TARGET_NAME}_object PUBLIC imgui)
#Expose the interface
target_include_directories(${TARGET_NAME}_object PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/public")

#TODO: pull this into exciton pipeline
if (${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    target_link_options(${TARGET_NAME}_object PUBLIC "-sUSE_SDL=2" "-sUSE_FREETYPE=1")
else()
    if (UNIX AND NOT APPLE)
        target_link_libraries(${TARGET_NAME}_object PUBLIC "m" "atomic" "pthread")
    endif ()
endif()
################################################################################
# Configure
################################################################################
configure_target(${TARGET_NAME}_object)
set_target_warnings(${TARGET_NAME}_object "${WARNINGS_AS_ERRORS}")
set_target_properties(${TARGET_NAME}_object PROPERTIES FOLDER apps/${TARGET_NAME})
