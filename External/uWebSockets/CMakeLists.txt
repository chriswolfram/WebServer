cmake_minimum_required(VERSION 3.24)

set(CMAKE_CXX_STANDARD 20)

add_definitions(-DUWS_NO_ZLIB)

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

# Add the CXX (header-only) library
# find_package(ZLIB REQUIRED)
add_library(uWebSocketsCXX INTERFACE)
target_include_directories(uWebSocketsCXX INTERFACE ${uwebsockets_content_SOURCE_DIR}/src/)
# target_link_libraries(uWebSocketsCXX INTERFACE uSockets ${ZLIB_LIBRARIES})
target_link_libraries(uWebSocketsCXX INTERFACE uSockets)

# Add the CAPI library
add_library(uwebsockets SHARED ${uwebsockets_content_SOURCE_DIR}/capi/libuwebsockets.cpp)
target_include_directories(uwebsockets PUBLIC ${uwebsockets_content_SOURCE_DIR}/capi/)
target_link_libraries(uwebsockets uWebSocketsCXX)
