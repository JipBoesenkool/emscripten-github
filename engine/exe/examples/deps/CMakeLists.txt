add_executable(game main.cpp)

target_link_libraries(game PRIVATE
	SDL2-static
	SDL2_image
	SDL2_ttf
	SDL2_mixer
	lua::lua
	sol2::sol2
	glm::glm
	IMGUI
)

set_property(TARGET game PROPERTY CXX_STANDARD 17)