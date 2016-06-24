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

macro( Object__parse LIST_VAR INDEX OUT_INDEX )
  this( CALL getNext ${LIST_VAR} ${INDEX} )
  getReturn( Object_WORKER )

  while( NOT "${Object_WORKER}" STREQUAL "" )
    if( "${Object_WORKER}" STREQUAL "ERROR" )
      log( ooCMake_ERROR "ClassInfo: Failed to parse file" )
      break()
    endif()

    list( GET Object_WORKER 0 Object_NEW_INDEX )
    list( GET Object_WORKER 1 Object_TYPE )
    list( GET Object_WORKER 2 Object_NAME )

    this( CALL enterScope "${Object_TYPE}" "${Object_NAME}" ${LIST_VAR} ${Object_NEW_INDEX} Object_NEW_INDEX Object_OBJ_NAME )
    log( LEVEL2 "${Object_NAME}" )

    this( CALL getNext ${LIST_VAR} ${Object_NEW_INDEX} )
    getReturn( Object_WORKER )
  endwhile()

  set( ${OUT_INDEX} ${Object_NEW_INDEX} )
endmacro()
