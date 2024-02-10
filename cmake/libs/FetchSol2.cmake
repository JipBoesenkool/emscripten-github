include(project/SetSystemIncludes)
include(project/CompilerWarnings)

#lua
CPMAddPackage(
  NAME lua
  GIT_REPOSITORY https://github.com/lua/lua.git
  VERSION 5.3.5
  DOWNLOAD_ONLY YES
)

if(lua_ADDED)
  # lua has no CMakeLists, so we create our own target
  file(GLOB lua_sources ${lua_SOURCE_DIR}/*.c)
  list(REMOVE_ITEM lua_sources "${lua_SOURCE_DIR}/lua.c" "${lua_SOURCE_DIR}/luac.c")
  add_library(lua STATIC ${lua_sources})
  target_include_directories(lua SYSTEM PUBLIC $<BUILD_INTERFACE:${lua_SOURCE_DIR}>)

  set_target_warnings_disabled(lua)
  set_target_properties(lua PROPERTIES FOLDER libs)

  source_group(TREE ${lua_SOURCE_DIR} FILES ${lua_sources})
endif()

#sol2
CPMAddPackage(
  NAME sol2
  GIT_REPOSITORY https://github.com/ThePhD/sol2.git
  VERSION 3.3.0
  OPTIONS
    "SOL2_LUA_VERSION 5.3.5"
    "SOL2_BUILD_LUA FALSE"
)

set_target_properties(sol2 PROPERTIES FOLDER dependencies)
