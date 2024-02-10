# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-src"
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-build"
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix"
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix/tmp"
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix/src/imgui-populate-stamp"
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix/src"
  "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix/src/imgui-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix/src/imgui-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/runner/work/emscripten-github/emscripten-github/apps/TemplateApp/build/_deps/imgui-subbuild/imgui-populate-prefix/src/imgui-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
