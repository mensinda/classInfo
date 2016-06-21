# Copyright (C) 2016 Daniel Mensinger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.5)

if( COMMAND classInfo_init )
  return()
endif()

macro( classInfo_log )
  debugMsg( classInfo_VERBOSE ${ARGN} )
endmacro()

set( classInfo_INTERNAL_IS_LOADED OFF CACHE INTERNAL "Internal" )

mark_as_advanced( classInfo_INTERNAL_IS_INIT classInfo_INTERNAL_IS_LOADED )

option( classInfo_VERBOSE "Enables verbose logging" ON )
set( classInfo_INTERNAL_SOURCE_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}" )

macro( classInfo_RESET_CACHE )
  message( STATUS "HELLO" )
endmacro()

macro( classInfo_init )
  if( classInfo_INTERNAL_IS_LOADED )
    return()
  endif()

  if( NOT EXISTS "${classInfo_INTERNAL_SOURCE_DIRECTORY}/cmake/" )
    message( FATAL_ERROR "Unable to locate classInfo source files (${classInfo_INTERNAL_SOURCE_DIRECTORY}/cmake/ does not exist)" )
  endif()

  if( NOT EXISTS "${classInfo_INTERNAL_SOURCE_DIRECTORY}/ooCMake/ooCMake.cmake" )
    message( FATAL_ERROR "Unable to locate ooCMake source files (${classInfo_INTERNAL_SOURCE_DIRECTORY}/ooCMake/ooCMake.cmake)" )
  endif()

  include( "${classInfo_INTERNAL_SOURCE_DIRECTORY}/ooCMake/ooCMake.cmake" )
  ooCM_init()

  set( classInfo_INTERNAL_IS_LOADED ON CACHE INTERNAL "Internal" )

  file( GLOB_RECURSE classInfo_INTERNAL_FILE_LIST
    LIST_DIRECTORIES OFF
    "${classInfo_INTERNAL_SOURCE_DIRECTORY}/cmake/*.cmake")

  classInfo_log( LEVEL1 "Initializing classInfo" )
  classInfo_log( LEVEL2 "Loading files" )

  foreach( classInfo_INTERNAL_I IN LISTS classInfo_INTERNAL_FILE_LIST )
    classInfo_log( LEVEL3 "${classInfo_INTERNAL_I}" )
    include( "${classInfo_INTERNAL_I}" )
  endforeach()

  classInfo_log( LEVEL2 "DONE" )

endmacro()

