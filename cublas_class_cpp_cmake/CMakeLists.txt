cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(combine LANGUAGES CXX CUDA)

add_library(lib_cuda class.cu)

add_executable(${PROJECT_NAME} main.cpp)

set_target_properties(${PROJECT_NAME} PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(lib_cuda -lcublas)
target_link_libraries(${PROJECT_NAME} lib_cuda)
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 14)
