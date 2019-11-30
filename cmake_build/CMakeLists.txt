cmake_minimum_required(VERSION 3.5)
project(cuda_cmake LANGUAGE CXX CUDA)

add_executable(${PROJECT_NAME} main.cu)

set_target_properties(${PROJECT_NAME} PROPERTIES  CXX_STANDARD 14 )


