cmake_minimum_required(VERSION 3.24)

include(ExternalProject)

# Fetch libuv from git
ExternalProject_Add(libuv_project
	GIT_REPOSITORY https://github.com/libuv/libuv
	GIT_TAG v1.46.0
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES} -DCMAKE_C_FLAGS="-fPIC" -DBUILD_TESTING=OFF
)

ExternalProject_Get_Property(libuv_project INSTALL_DIR)
set(LIBUV_INSTALL_DIR ${INSTALL_DIR})

add_library(libuv STATIC IMPORTED GLOBAL)
add_dependencies(libuv libuv_project)
set_property(TARGET libuv PROPERTY IMPORTED_LOCATION ${LIBUV_INSTALL_DIR}/lib/libuv.a)
target_include_directories(libuv INTERFACE ${LIBUV_INSTALL_DIR}/include)

message(DIRS1=${LIBUV_INSTALL_DIR}/include)
get_target_property(LIBUV_INCLUDES libuv INTERFACE_INCLUDE_DIRECTORIES)
message(DIRS3=${LIBUV_INCLUDES})