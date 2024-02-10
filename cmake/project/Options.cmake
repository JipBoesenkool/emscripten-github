################################################################################
# Project Options
################################################################################
function(init_options target_name)
    include(project/CheckIsRoot)
    check_target_is_root(${TARGET_NAME}_IS_ROOT ${TARGET_NAME}_IS_ROOT_AND_NOT_EMS)
    set(${TARGET_NAME}_IS_ROOT ON PARENT_SCOPE)
    set(${TARGET_NAME}_IS_ROOT_AND_NOT_EMS ON PARENT_SCOPE)

    option(${TARGET_NAME}_INSTALL "Enable cmake install for the target" ${${TARGET_NAME}_IS_ROOT})
    option(CMAKE_VERBOSE "Print options and variables." ON)
    option(GITHUB_CI "We are running on CI. May change certain defaults." OFF)
    option(DOWNLOAD_CPM "Download CPM. Disable if you're providing your own version of CPM" ON)
    option(WARNINGS_AS_ERRORS "Treat warnings as errors" ${GITHUB_CI})
endfunction()
################################################################################
# Process 
################################################################################
function(process_options target_name cmake_root_dir)
    if (GITHUB_CI)
        message(STATUS "${target_name} running on CI")
    endif()

    if (NOT CPM_SOURCE_CACHE)
        set(CPM_SOURCE_CACHE "${cmake_root_dir}/.cpmcache")
    endif()

    if (${target_name}_IS_ROOT)
        message(STATUS "${target_name} is root")
        set_property(GLOBAL PROPERTY USE_FOLDERS ON)
    endif()

    if (DOWNLOAD_CPM)
        message(STATUS "${target_name} CPM Download Enabled")
        include(DownloadCPM)
    endif()
endfunction()


