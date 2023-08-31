cmake_minimum_required(VERSION 3.24)

set(CMAKE_CXX_STANDARD 20)

include(FetchContent)

# Fetch uWebSockets from git
FetchContent_Declare(
  libuv_content
  GIT_REPOSITORY https://github.com/libuv/libuv
  GIT_TAG v1.46.0
  GIT_SHALLOW ON
  GIT_SUBMODULES ""
)
FetchContent_MakeAvailable(libuv_content)

# Add the library
add_subdirectory(${libuv_content_SOURCE_DIR})
