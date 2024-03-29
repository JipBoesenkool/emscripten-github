################################################################################
# Function: check_target_is_root
# Description: Check if the target is the main project, or a sub project (add_subdirectory)
################################################################################
function(check_target_is_root is_root is_root_and_not_em)
    if (NOT DEFINED ${is_root})
        set(${is_root} OFF PARENT_SCOPE)
        set(${is_root_and_not_em} OFF PARENT_SCOPE)
        if ("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_CURRENT_SOURCE_DIR}")
            set(${is_root} ON PARENT_SCOPE)
            if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
                set(${is_root_and_not_em} ON PARENT_SCOPE)
            endif()
        endif()
    endif()
endfunction()