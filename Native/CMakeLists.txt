cmake_minimum_required(VERSION 3.26)
project(native_lib)

set(CMAKE_CXX_STANDARD 20)

add_library(
    native-lib
    SHARED
    src/main.cpp
)

# add_executable(native src/main.cpp)