include(ConfigureTarget)
include(CompilerWarnings)
include(FetchIMGUI)
#add lua?
set(WARNINGS_AS_ERRORS "${CMAKE_PROJECT_NAME}_WARNINGS_AS_ERRORS")
add_library(${CMAKE_PROJECT_NAME}_object OBJECT
    "public/${CMAKE_PROJECT_NAME}/Game.hpp"
    "private/Game.cpp"
)

target_link_libraries(${CMAKE_PROJECT_NAME}_object PUBLIC exe::exe imgui)
target_include_directories(${CMAKE_PROJECT_NAME}_object PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/public")

if (${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    target_link_options(${CMAKE_PROJECT_NAME}_object PUBLIC "-sUSE_SDL=2" "-sUSE_FREETYPE=1")
else()
    if (UNIX AND NOT APPLE)
        target_link_libraries(${CMAKE_PROJECT_NAME}_object PUBLIC "m" "atomic" "pthread")
    endif ()
endif()

configure_target(${CMAKE_PROJECT_NAME}_object)
set_target_warnings(${CMAKE_PROJECT_NAME}_object "${WARNINGS_AS_ERRORS}")

add_executable(${CMAKE_PROJECT_NAME} "main.cpp")
add_executable(${CMAKE_PROJECT_NAME}::${CMAKE_PROJECT_NAME} ALIAS ${CMAKE_PROJECT_NAME})
target_link_libraries(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_PROJECT_NAME}_object)

if (${CMAKE_SYSTEM_NAME} MATCHES "Emscripten")
    set_target_properties(
        ${CMAKE_PROJECT_NAME}
        PROPERTIES 
            SUFFIX ".html" #change to ".wasm" if you only want the wasm output
    )
endif()

configure_target(${CMAKE_PROJECT_NAME})
set_target_warnings(${CMAKE_PROJECT_NAME} "${WARNINGS_AS_ERRORS}")