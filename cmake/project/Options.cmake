################################################################################
# Project Options
################################################################################
function(init_options target_name)
    include(project/CheckIsRoot)
    check_target_is_root(${TARGET_NAME}_IS_ROOT ${TARGET_NAME}_IS_ROOT_AND_NOT_EMS)
    set(${TARGET_NAME}_IS_ROOT ${${TARGET_NAME}_IS_ROOT} PARENT_SCOPE)
    set(${TARGET_NAME}_IS_ROOT_AND_NOT_EMS ${${TARGET_NAME}_IS_ROOT_AND_NOT_EMS} PARENT_SCOPE)
    # make sure we don't init options twice
    if( ${${target_name}_IS_ROOT} )
        ################################################################################
        # Pipeline options 
        option(${TARGET_NAME}_INSTALL "Enable cmake install for the target" ${${TARGET_NAME}_IS_ROOT})
        option(CMAKE_VERBOSE "Print options and variables." ON)
        option(GITHUB_CI "We are running on CI. May change certain defaults." OFF)
        option(DOWNLOAD_CPM "Download CPM. Disable if you're providing your own version of CPM" ON)
        option(WARNINGS_AS_ERRORS "Treat warnings as errors" ${GITHUB_CI})
        ################################################################################
        # Exciton Options 
        #exciton engine
        option(EXE_MAIN_APP "Have exciton handle the entry point" OFF)

        option(EXE_BUILD_EXAMPLES "Build the exciton examples" OFF)
        option(EXE_BUILD_UNIT_TESTS "Build the exciton unit tests" OFF)
        option(EXE_BUILD_PERFORMANCE_TESTS "Build the exciton performance tests" OFF)
    endif()
endfunction()
################################################################################
# Print Options
################################################################################
function(print_options target_name)
    ##### Info output #####
    message(STATUS "")
    message(STATUS "Exciton was configured with the following options:")
    message(STATUS "")
    message(STATUS "Platform: ${CMAKE_SYSTEM}")
    #message(STATUS "64-bit:   ${ARCH_64}")
    #message(STATUS "Compiler: ${CMAKE_C_COMPILER}")
    #message(STATUS "Revision: ${SDL_REVISION}")
    #message(STATUS "Vendor:   ${SDL_VENDOR_INFO}")
    message(STATUS "")
    message(STATUS "Pipeline:")
    message(STATUS "Install:           ${${TARGET_NAME}_INSTALL}")
    message(STATUS "Exe entry point:   ${EXE_MAIN_APP}")
    message(STATUS "")
    message(STATUS "Build Examples:    ${EXE_BUILD_EXAMPLES}")
    message(STATUS "Build Unit Tests:  ${EXE_BUILD_UNIT_TESTS}")
    message(STATUS "Build Perf Tests:  ${EXE_BUILD_PERFORMANCE_TESTS}")
    message(STATUS "")
endfunction()
################################################################################
# Process Options
################################################################################
function(process_options target_name cmake_root_dir)
    if( ${${target_name}_IS_ROOT} AND ${CMAKE_VERBOSE})
        print_options( ${target_name} )
    endif()

    if (NOT CPM_SOURCE_CACHE)
        set(CPM_SOURCE_CACHE "${cmake_root_dir}/.cpmcache")
    endif()

    if ( ${${target_name}_IS_ROOT} )
        set_property(GLOBAL PROPERTY USE_FOLDERS ON)
    endif()

    if (DOWNLOAD_CPM)
        include(DownloadCPM)
    endif()
endfunction()


