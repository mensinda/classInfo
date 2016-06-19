cmake_minimum_required(VERSION 3.5)

if( NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/cmake/" )
  message( FATAL_ERROR "Unable to locate classInfo source files (${CMAKE_CURRENT_LIST_DIR}/cmake/ does not exist" )
endif()

message( STATUS ${CMAKE_CURRENT_LIST_DIR} )
