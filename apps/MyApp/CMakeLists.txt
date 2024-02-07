cmake_minimum_required(VERSION 3.21)
project(MyApp)

############
# Project CI
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")

include(CheckIsRoot)
check_project_is_root(${CMAKE_PROJECT_NAME}_IS_ROOT)

add_subdirectory("../../engine/exe" "${CMAKE_CURRENT_BINARY_DIR}/engine/exe")

option(${CMAKE_PROJECT_NAME}_CI "We are running on CI. May change certain defaults." OFF)
if (${CMAKE_PROJECT_NAME}_CI)
    message(STATUS "${CMAKE_PROJECT_NAME} running on CI")
endif()

if (${CMAKE_PROJECT_NAME}_IS_ROOT)
    if(${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
        set(${CMAKE_PROJECT_NAME}_IS_ROOT_AND_NOT_EMS OFF)
    else()
        set(${CMAKE_PROJECT_NAME}_IS_ROOT_AND_NOT_EMS ON)
    endif()
else()
    set(${CMAKE_PROJECT_NAME}_IS_ROOT_AND_NOT_EMS OFF)
endif()

if (NOT CPM_SOURCE_CACHE)
    set(CPM_SOURCE_CACHE "${CMAKE_CURRENT_SOURCE_DIR}/../../.cpmcache")
endif()

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../../deps" "${CMAKE_CURRENT_BINARY_DIR}/deps")

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
option(${CMAKE_PROJECT_NAME}_INSTALL "Enable cmake install for the myapp" ${${CMAKE_PROJECT_NAME}_IS_ROOT})
option(${CMAKE_PROJECT_NAME}_DOWNLOAD_CPM "Download CPM. Disable if you're providing your own version of CPM" ON)
option(${CMAKE_PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat warnings as errors" ${${CMAKE_PROJECT_NAME}_CI})

###################
# Build the project
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
