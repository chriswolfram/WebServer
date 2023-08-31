cmake_minimum_required(VERSION 3.24)

set(CMAKE_CXX_STANDARD 20)

# add_definitions(-DUWS_NO_ZLIB)

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
# set(ZLIB_USE_STATIC_LIBS "ON")
# find_package(ZLIB REQUIRED)
add_library(uWebSocketsCXX INTERFACE)
target_include_directories(uWebSocketsCXX INTERFACE ${uwebsockets_content_SOURCE_DIR}/src/ libuv)
target_link_libraries(uWebSocketsCXX INTERFACE uSockets zlib libuv)
# add_dependencies(uWebSocketsCXX zlib_project)
# target_link_libraries(uWebSocketsCXX INTERFACE uSockets ${ZLIB_LIBRARIES})
# target_link_libraries(uWebSocketsCXX INTERFACE uSockets)

# if(TARGET zlib)
#   message("ZLIB exists!")
# else()
#   message("ZLIB DOESN'T EXIST!")
# endif()

# if(TARGET uSockets)
#   message("uSockets exists!")
# else()
#   message("uSockets DOESN'T EXIST!")
# endif()

# if(TARGET uWebSocketsCXX)
#   message("uWebSocketsCXX exists!")
# else()
#   message("uWebSocketsCXX DOESN'T EXIST!")
# endif()

# find_path(SYSTEM_INCLUDE_DIR uv.h)
# include_directories(${SYSTEM_INCLUDE_DIR})

get_target_property(INCLUDES2 uWebSocketsCXX INTERFACE_INCLUDE_DIRECTORIES)
message(INCLUDES2=${INCLUDES2})

# Add the CAPI library
add_library(uwebsockets SHARED ${uwebsockets_content_SOURCE_DIR}/capi/libuwebsockets.cpp)
target_include_directories(uwebsockets PUBLIC ${uwebsockets_content_SOURCE_DIR}/capi/ libuv)
target_link_libraries(uwebsockets uWebSocketsCXX)

get_target_property(INCLUDES3 uwebsockets INTERFACE_INCLUDE_DIRECTORIES)
message(INCLUDES3=${INCLUDES3})