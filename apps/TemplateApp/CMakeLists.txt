################################################################################
# Project
################################################################################
cmake_minimum_required(VERSION 3.21)
project(TemplateApp)
set(TARGET_NAME TemplateApp)
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
# begin option Override

# end option Override
process_options(${TARGET_NAME} ${CMAKE_ROOT_DIR})
################################################################################
# Dependencies
################################################################################
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../../exe" "${CMAKE_CURRENT_BINARY_DIR}/exe")
################################################################################
# Project
################################################################################
# build the object library
add_subdirectory("src")

add_executable(${TARGET_NAME} src/main.cpp)
add_executable(${TARGET_NAME}::${TARGET_NAME} ALIAS ${TARGET_NAME})
target_link_libraries(${TARGET_NAME} PUBLIC ${TARGET_NAME}_object)
#TODO: pull this into a platform func
if (${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    set_target_properties(
        ${TARGET_NAME}
        PROPERTIES 
            SUFFIX ".html" #change to ".wasm" if you only want the wasm output
    )
endif()
# configure
configure_target(${TARGET_NAME})
set_target_warnings(${TARGET_NAME} "${WARNINGS_AS_ERRORS}")
set_target_properties(${TARGET_NAME} PROPERTIES FOLDER apps/${TARGET_NAME})

#install
if (${TARGET_NAME}_INSTALL)
    message(STATUS "${TARGET_NAME} Install Enabled")
    install(
        DIRECTORY "$<TARGET_FILE_DIR:${TARGET_NAME}>"
        DESTINATION "."
    )
endif()

#TODO: copy over resources
