function(process_options target_name)
    if (GITHUB_CI)
        message(STATUS "${target_name} running on CI")
    endif()

    if (NOT CPM_SOURCE_CACHE)
        set(CPM_SOURCE_CACHE "${CMAKE_CURRENT_SOURCE_DIR}/../.cpmcache")
    endif()

    if (${target_name}_IS_ROOT)
        message(STATUS "${target_name} is root")
        set_property(GLOBAL PROPERTY USE_FOLDERS ON)
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


