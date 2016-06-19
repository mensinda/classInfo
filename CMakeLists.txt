cmake_minimum_required(VERSION 2.6)
project(classinfo)

add_executable(classinfo main.cpp)

install(TARGETS classinfo RUNTIME DESTINATION bin)
