################################################################################
# Project
################################################################################
cmake_minimum_required(VERSION 3.21)
project(template_example)
set(TARGET_NAME template_example)
set(CMAKE_ROOT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")
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
# Override options here

#process the options
process_options(${TARGET_NAME} ${CMAKE_ROOT_DIR})
################################################################################
# Create Example
################################################################################
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Add your sources here
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
add_executable(${TARGET_NAME} main.cpp)
################################################################################
# Dependencies
################################################################################
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Include example specific dependencies here
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#include(libs/FetchSol2)
#target_link_libraries(${TARGET_NAME} PRIVATE
#  sol2
#  lua
#)
################################################################################
# Configure
################################################################################
configure_target(${TARGET_NAME})
set_target_warnings(${TARGET_NAME} "${WARNINGS_AS_ERRORS}")

set_target_properties(${TARGET_NAME} PROPERTIES FOLDER examples)