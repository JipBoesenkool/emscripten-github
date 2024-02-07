# exe
Exciton SDL game engine
https://pikuma.com/courses/cpp-2d-game-engine-development

# How-to
```sh
git submodule update --init --recursive
mkdir build
cd build
cmake ..
cmake --build .
./src/game
```

# TODO
- Emscripten support
- dependencies confirmed
- encapsulate GLM so we can opt to use our own little math library
- move resources into the apps folder
- make apps hotloadable
- move SDL stuff out of game into window.h and renderer.h
- tick based loop for logic