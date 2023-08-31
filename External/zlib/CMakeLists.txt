cmake_minimum_required(VERSION 3.24)

include(ExternalProject)

# Fetch zlib from git
ExternalProject_Add(zlib_project
	GIT_REPOSITORY https://github.com/madler/zlib
	GIT_TAG v1.3
	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES} -DCMAKE_C_FLAGS="-fPIC"
)

ExternalProject_Get_Property(zlib_project INSTALL_DIR)
set(ZLIB_INSTALL_DIR ${INSTALL_DIR})

add_library(zlib STATIC IMPORTED GLOBAL)
add_dependencies(zlib zlib_project)
set_property(TARGET zlib PROPERTY IMPORTED_LOCATION ${ZLIB_INSTALL_DIR}/lib/libz.a)
target_include_directories(zlib INTERFACE ${ZLIB_INSTALL_DIR}/include)
