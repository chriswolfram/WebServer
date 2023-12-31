cmake_minimum_required(VERSION 3.24...3.27)

project(WebServer VERSION 1.0.0)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

# Load dependencies
add_subdirectory(External)

# Installation rules
set(PACLET_DIR ${CMAKE_BINARY_DIR}/WebServer)

# Install static source files
install(
	DIRECTORY
		WebServer/Documentation
		WebServer/Kernel
	DESTINATION ${PACLET_DIR}
)
install(
	FILES
		WebServer/PacletInfo.wl
		WebServer/ResourceDefinition.nb
		WebServer/LICENSE
	DESTINATION ${PACLET_DIR}
)

# Install libuwebsockets
install(TARGETS uwebsockets DESTINATION ${PACLET_DIR}/LibraryResources/${SYSTEM_ID})
