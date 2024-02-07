#include <iostream>
#include <cstdlib>

//Dependencies
//#include <glm/glm.hpp>
//#include <imgui.h>
//#include <sol/sol.hpp>

#include <2Dexe/game/Game.hpp>

int main(int argc, char* args[])
{
	Game game;
	if ( game.Initialize() )
	{
		game.Run();
	}
	game.Destroy();
	return 0;
}