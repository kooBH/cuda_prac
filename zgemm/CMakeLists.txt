cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(complex_type LANGUAGES CUDA)

add_executable(${PROJECT_NAME} main.cu)
set_target_properties(${PROJECT_NAME} PROPERTIES  CXX_STANDARD 14 )
target_link_libraries(${PROJECT_NAME} -lcublas -lcurand)
