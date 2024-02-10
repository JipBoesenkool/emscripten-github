################################################################################
# Project
################################################################################
cmake_minimum_required(VERSION 3.21)
project(exciton)
set(TARGET_NAME exciton)
set(CMAKE_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
################################################################################
# CMake functions
################################################################################
list(APPEND CMAKE_MODULE_PATH ${CMAKE_ROOT_DIR})

include(project/Options)
include(project/ConfigureTarget)
################################################################################
# Exciton pipeline
################################################################################
init_options(${TARGET_NAME} ${CMAKE_ROOT_DIR})
# Override options
if( ${${TARGET_NAME}_IS_ROOT} )
    message(STATUS "${TARGET_NAME} is root, overriding options")
    option(EXE_MAIN_APP "" ON)
endif()
#process the options
process_options(${TARGET_NAME} ${CMAKE_ROOT_DIR})
################################################################################
# Project
################################################################################
# build the object library
add_subdirectory("src")

if( ${EXE_MAIN_APP} )
    # TODO: create application that loads apps
    message(STATUS "Exciton as executable")
endif()

################################################################################
# Build examples & tests
################################################################################
if ( ${EXE_BUILD_EXAMPLES} )
    message(STATUS "Exciton examples Enabled")
    #add_subdirectory(examples)
endif()
###################
#TODO: copy over resources

