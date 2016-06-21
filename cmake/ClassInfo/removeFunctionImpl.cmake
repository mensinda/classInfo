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

function( ClassInfo__removeFunctionImpl INPUT )
  set( WORKER "${${INPUT}}" )

  set( NEW_LIST    "" )
  set( PARAM_OPEN  0 )
  set( BR_OPEN     0 )
  set( BEGIN_FUNC  OFF )
  set( REMOVE_FUNC OFF )

  set( TEMP_LIST "" )

  foreach( I IN LISTS WORKER )
    if( "${I}" MATCHES ".*::[a-zA-Z0-9_]+$" )
      if( NOT "${I}" MATCHES ".*(${AN}|${RE}|${CM}).*" )
        list( APPEND TEMP_LIST "${I}" )
        set( REMOVE_FUNC ON )
        continue()
      endif()
    endif()

    if( "${I}" STREQUAL "(" AND NOT BEGIN_FUNC )
      set( BEGIN_FUNC ON )
      set( PARAM_OPEN 1 )
      if( NOT REMOVE_FUNC )
        list( APPEND NEW_LIST "${I}" )
      endif()
      continue()
    endif()

    # No function body
    if( BEGIN_FUNC AND "${I}" STREQUAL "${RE}" AND "${PARAM_OPEN}" STREQUAL "0" AND "${BR_OPEN}" STREQUAL "0" )
      set( PARAM_OPEN  0 )
      set( BR_OPEN     0 )
      set( BEGIN_FUNC  OFF )
      set( REMOVE_FUNC OFF )
      if( NOT REMOVE_FUNC )
        list( APPEND NEW_LIST "${I}" )
      endif()
      continue()
    endif()

    # Open function scope
    if( BEGIN_FUNC AND "${I}" STREQUAL "{" AND "${PARAM_OPEN}" STREQUAL "0" )
      math( EXPR BR_OPEN "${BR_OPEN} + 1" )
      continue()
    endif()

    # Close a functin scope
    if( BEGIN_FUNC AND "${I}" STREQUAL "}" AND "${PARAM_OPEN}" STREQUAL "0" )
      math( EXPR BR_OPEN "${BR_OPEN} - 1" )
      if( "${BR_OPEN}" STREQUAL "0" )
        set( PARAM_OPEN  0 )
        set( BR_OPEN     0 )
        set( BEGIN_FUNC  OFF )
        set( REMOVE_FUNC OFF )
        list( APPEND NEW_LIST "${RE}" )
      endif()
      continue()
    endif()

    # Start parameters
    if( BEGIN_FUNC AND "${I}" STREQUAL "(" AND "${BR_OPEN}" STREQUAL "0" )
      math( EXPR PARAM_OPEN "${PARAM_OPEN} + 1" )
      if( NOT REMOVE_FUNC )
        list( APPEND NEW_LIST "${I}" )
      endif()
      continue()
    endif()

    # Finish parameters
    if( BEGIN_FUNC AND "${I}" STREQUAL ")" AND "${BR_OPEN}" STREQUAL "0" )
      math( EXPR PARAM_OPEN "${PARAM_OPEN} - 1" )
      if( NOT REMOVE_FUNC )
        list( APPEND NEW_LIST "${I}" )
      endif()
      continue()
    endif()

    # Add false removed stuff
    if( NOT BEGIN_FUNC AND NOT "${I}" STREQUAL "(" )
      foreach( J IN LISTS TEMP_LIST )
        list( APPEND NEW_LIST "${J}" )
      endforeach()
      set( TEMP_LIST   "" )
      set( REMOVE_FUNC OFF )
    else()
      set( TEMP_LIST "" )
    endif()

    # Parameters
    if( BEGIN_FUNC AND NOT REMOVE_FUNC AND "${BR_OPEN}" STREQUAL "0" )
      list( APPEND NEW_LIST "${I}" )
      continue()
    endif()

    # Everything else
    if( NOT BEGIN_FUNC )
      list( APPEND NEW_LIST "${I}" )
      continue()
    endif()
  endforeach()

  returnVal( "${NEW_LIST}" )
endfunction()

