################################################################################
# Project
################################################################################
cmake_minimum_required(VERSION 3.21)
project(MyApp)
set(TARGET_NAME MyApp)
################################################################################
# CMake functions
################################################################################
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")

include(CheckIsRoot)
include(Options)
################################################################################
# Exciton pipeline
################################################################################
check_target_is_root(${TARGET_NAME}_IS_ROOT ${TARGET_NAME}_IS_ROOT_AND_NOT_EMS)

################################################################################
# CMake Options
################################################################################
# option(BUILD_SHARED_LIBS "Build using shared libraries. If on the game will be hot reloaded." ON)
################################################################################
# Options
################################################################################
option(${TARGET_NAME}_INSTALL "Enable cmake install for the target" ${${TARGET_NAME}_IS_ROOT})
option(CMAKE_VERBOSE "Print options and variables." ON)
option(GITHUB_CI "We are running on CI. May change certain defaults." OFF)
option(DOWNLOAD_CPM "Download CPM. Disable if you're providing your own version of CPM" ON)
option(WARNINGS_AS_ERRORS "Treat warnings as errors" ${GITHUB_CI})

process_options(${TARGET_NAME})
################################################################################
# Dependencies
################################################################################
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../../libs" "${CMAKE_CURRENT_BINARY_DIR}/libs")
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../../engine/exe" "${CMAKE_CURRENT_BINARY_DIR}/engine/exe")

################################################################################
# Project
################################################################################
add_subdirectory("src")

if (${CMAKE_PROJECT_NAME}_INSTALL)
    message(STATUS "${CMAKE_PROJECT_NAME} Install Enabled")
    install(
        DIRECTORY "$<TARGET_FILE_DIR:${CMAKE_PROJECT_NAME}>"
        DESTINATION "."
    )
endif()

###################
#TODO: copy over resources
