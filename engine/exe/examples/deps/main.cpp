#include <iostream>
#include <cstdlib>

//Dependencies
#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h>
#include <SDL_image.h>
#include <SDL_ttf.h>
#include <SDL_mixer.h>
#include <glm/glm.hpp>
#include "imgui.h"

#include <sol/sol.hpp>

int InitSDL()
{
	SDL_SetMainReady();
	const int errorCode = SDL_Init(SDL_INIT_EVERYTHING);
	if (errorCode != 0)
	{
		const char* errorMessage = SDL_GetError();
		std::cout << errorMessage;
	}
	return errorCode;
}

int main(int argc, char* args[])
{
	InitSDL();

	glm::vec2 vVelocity;

	sol::state lua;
	lua.open_libraries(sol::lib::base, sol::lib::package);
	sol::protected_function_result result = lua.script("print('Hello from Lua')");
	if (!result.valid()) {
		sol::error err = result;
		std::cout << err.what();
	}

	system("pause");

	std::cout << "Basic loop\n";
	return 0;
}