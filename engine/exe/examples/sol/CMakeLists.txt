add_executable(game main.cpp)

include(FetchSol2)

target_link_libraries(game PRIVATE
  sol2
  lua
)

set_property(TARGET game PROPERTY CXX_STANDARD 17)