cmake_minimum_required(VERSION 3.24)

set(CMAKE_C_STANDARD 11)

include(FetchContent)

# Fetch uSockets from git
FetchContent_Declare(
  uSockets_content
  GIT_REPOSITORY https://github.com/uNetworking/uSockets
  GIT_TAG v0.8.6
  GIT_SHALLOW ON
  GIT_SUBMODULES ""
)
FetchContent_MakeAvailable(uSockets_content)

# Add the library
file(GLOB_RECURSE SOURCES ${usockets_content_SOURCE_DIR}/src/*.c)
add_library(uSockets STATIC ${SOURCES})
target_include_directories(uSockets PUBLIC ${usockets_content_SOURCE_DIR}/src)
target_compile_definitions(uSockets PRIVATE LIBUS_NO_SSL)
set_property(TARGET uSockets PROPERTY POSITION_INDEPENDENT_CODE ON)
