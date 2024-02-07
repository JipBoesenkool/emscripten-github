#game files
set( GAME_ENTRY
	main.cpp
)

set( GAME_SOURCE
	${PROJECT_SOURCE_DIR}/src/game/Game.cpp
)

add_executable(game ${GAME_ENTRY} ${GAME_SOURCE} )
target_link_libraries(game PRIVATE
	SDL2-static
	SDL2_image
	SDL2_ttf
	SDL2_mixer
	lua::lua
	sol2::sol2
	IMGUI
)

#copy resources
add_dependencies(game copy_resources)

# is this needed?
set_property(TARGET game PROPERTY CXX_STANDARD 17)