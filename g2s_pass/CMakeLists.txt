cmake_minimum_required(VERSION 3.4.3)
#include(CMakeLists.custom)
#set(CMAKE_CXX_STANDARD 11)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
find_package(LLVM REQUIRED CONFIG)                        # This will find the shared LLVM build.
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")        # You don't need to change ${LLVM_CMAKE_DIR} since it is already defined.
include(AddLLVM)
add_definitions(${LLVM_DEFINITIONS})                      # You don't need to change ${LLVM_DEFINITIONS} since it is already defined.
include_directories(${LLVM_INCLUDE_DIRS})                 # You don't need to change ${LLVM_INCLUDE_DIRS} since it is already defined.
add_llvm_library(LLVMPJT MODULE            # Name of the shared library that you will generate
	global2shared.cpp                          # Your pass
	PLUGIN_TOOL
	opt
)
