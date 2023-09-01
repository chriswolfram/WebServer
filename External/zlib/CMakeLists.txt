cmake_minimum_required(VERSION 3.24)

# include(ExternalProject)

# # Fetch zlib from git
# ExternalProject_Add(zlib_project
# 	GIT_REPOSITORY https://github.com/madler/zlib
# 	GIT_TAG v1.3
# 	CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DCMAKE_OSX_ARCHITECTURES=${CMAKE_OSX_ARCHITECTURES} -DCMAKE_C_FLAGS="-fPIC"
# 	BUILD_COMMAND ""
# 	INSTALL_COMMAND ""
# )

# ExternalProject_Get_Property(zlib_project INSTALL_DIR)
# set(ZLIB_INSTALL_DIR ${INSTALL_DIR})

# # set(ZLIB_USE_STATIC_LIBS "ON")
# set(ZLIB_ROOT ${ZLIB_INSTALL_DIR})

# find_package(ZLIB REQUIRED)

# message(ZLIB_INSTALL_DIR=${ZLIB_INSTALL_DIR})
# message(ZLIB_LIBRARIES=${ZLIB_LIBRARIES})

# add_library(zlib STATIC IMPORTED GLOBAL)
# add_dependencies(zlib zlib_project)
# set_property(TARGET zlib PROPERTY IMPORTED_LOCATION ${ZLIB_INSTALL_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}z${CMAKE_STATIC_LIBRARY_SUFFIX})
# target_include_directories(zlib INTERFACE ${ZLIB_INSTALL_DIR}/include)

include(FetchContent)

FetchContent_Declare(
  zlib
  GIT_REPOSITORY https://github.com/madler/zlib
  GIT_TAG v1.3
  # OVERRIDE_FIND_PACKAGE
)
FetchContent_MakeAvailable(zlib)

message(test=${zlib_BINARY_DIR})

# set(ZLIB_ROOT zlib_content_BINARY_DIR)

# find_package(ZLIB REQUIRED)

message(zlib_spot=${ZLIB_VERSION})
message(zlib_foundQ=${ZLIB_FOUND})

if(TARGET ZLIB::ZLIB)
  message("ZLIB::ZLIB exists!")
else()
  message("ZLIB::ZLIB DOESN'T EXIST!")
endif()

if(TARGET zlibstatic)
  message("zlibstatic exists!")
else()
  message("zlibstatic DOESN'T EXIST!")
endif()

add_library(ZLIB::ZLIB ALIAS zlibstatic)

# get_cmake_property(_variableNames VARIABLES)
# list (SORT _variableNames)
# foreach (_variableName ${_variableNames})
#     message(STATUS "${_variableName}=${${_variableName}}")
# endforeach()