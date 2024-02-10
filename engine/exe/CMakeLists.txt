cmake_minimum_required(VERSION 3.21)
project(exciton)
set(TARGET_NAME Exciton)
############
# Project CI
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")

include(CheckIsRoot)
check_project_is_root(${CMAKE_PROJECT_NAME}_IS_ROOT)
check_target_is_root(${TARGET_NAME}_IS_ROOT ${TARGET_NAME}_IS_ROOT_AND_NOT_EMS)

option(${CMAKE_PROJECT_NAME}_CI "We are running on CI. May change certain defaults." OFF)
if (${CMAKE_PROJECT_NAME}_CI)
    message(STATUS "${CMAKE_PROJECT_NAME} running on CI")
endif()

if (NOT CPM_SOURCE_CACHE)
    set(CPM_SOURCE_CACHE "${CMAKE_CURRENT_SOURCE_DIR}/../../.cpmcache")
endif()

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../../libs" "${CMAKE_CURRENT_BINARY_DIR}/libs")

if (${CMAKE_PROJECT_NAME}_IS_ROOT)
    message(STATUS "${CMAKE_PROJECT_NAME} is root")
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

if (${CMAKE_PROJECT_NAME}_DOWNLOAD_CPM)
    message(STATUS "${CMAKE_PROJECT_NAME} CPM Download Enabled")
    include(DownloadCPM)
endif()

############
# Settings
option(${CMAKE_PROJECT_NAME}_EXAMPLES "Build the ${CMAKE_PROJECT_NAME} tests" ${${CMAKE_PROJECT_NAME}_IS_ROOT_AND_NOT_EMS})
option(${CMAKE_PROJECT_NAME}_DOWNLOAD_CPM "Download CPM. Disable if you're providing your own version of CPM" ON)
option(${CMAKE_PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat warnings as errors" ${${CMAKE_PROJECT_NAME}_CI})

###################
# Build the project
add_subdirectory("src")

###################
# Builds tests
if (${CMAKE_PROJECT_NAME}_EXAMPLES)
    message(STATUS "${TARGET_NAME} Examples Enabled")
    #add_subdirectory(examples)
endif()

###################
#TODO: copy over resources
