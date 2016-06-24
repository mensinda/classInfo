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

function( Object__getNext LIST_VAR INDEX )
  set( I ${INDEX} )
  classInfo_getNextInList( ${LIST_VAR} I WORKER )

  if( "${WORKER}" MATCHES "namespace[ \t]+[a-zA-Z0-9]+" )
    string( REGEX REPLACE "namespace[ \t]+([a-zA-Z_0-9:]+)" "\\1" NAME "${WORKER}" )
    classInfo_getNextInList( ${LIST_VAR} I WORKER )
    if( NOT "${WORKER}" STREQUAL "{" )
      returnVal( "ERROR" )
    endif()
    returnVal( "${I};NS;${NAME}" )
  endif()

  log( LEVEL3 "UNKNOWN: ${WORKER}" )
  returnVal( "" )
endfunction()
