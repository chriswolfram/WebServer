cmake_minimum_required(VERSION 3.24)

set(CMAKE_CXX_STANDARD 20)

include(FetchContent)

# Fetch uWebSockets from git
FetchContent_Declare(
  uWebSockets_content
  GIT_REPOSITORY https://github.com/uNetworking/uWebSockets
  GIT_TAG v20.45.0
  GIT_SHALLOW ON
  GIT_SUBMODULES ""
)
FetchContent_MakeAvailable(uWebSockets_content)

# Find zlib
set(ZLIB_USE_STATIC_LIBS "ON")
find_package(ZLIB REQUIRED)

# Find libuv
find_package(LIBUV REQUIRED)

# Create the uWebSockets (CXX) target
add_library(uWebSocketsCXX INTERFACE)
target_include_directories(uWebSocketsCXX INTERFACE ${uwebsockets_content_SOURCE_DIR}/src/ ${LIBUV_INCLUDE_DIRS})
target_link_libraries(uWebSocketsCXX INTERFACE uSockets ZLIB::ZLIB ${LIBUV_LIBRARY})

# Create the libuwebsockets (CAPI) target
add_library(uwebsockets SHARED ${uwebsockets_content_SOURCE_DIR}/capi/libuwebsockets.cpp)
target_include_directories(uwebsockets PUBLIC ${uwebsockets_content_SOURCE_DIR}/capi/ ${LIBUV_INCLUDE_DIRS})
target_link_libraries(uwebsockets uWebSocketsCXX)
