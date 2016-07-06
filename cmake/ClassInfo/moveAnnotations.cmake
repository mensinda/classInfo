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

function( ClassInfo__moveAnnotations INPUT )
  set( WORKER  "${${INPUT}}" )
  set( NEW_RAW "${${INPUT}}" )
  set( SPECIAL_CHARS "(\\[|\\]|\\(|\\)|\\^|\\$|\\*|\\.|\\+|\\?|\\|)" )
  set( OUT_LIST "" )

  string( REGEX REPLACE ";" "${RE}" WORKER "${WORKER}" )
  string( REGEX MATCH "${classInfo_ANNOTATION_START}[^\n]+\n" RES "${WORKER}" )

  while( NOT "${RES}" STREQUAL "" )
    list( LENGTH OUT_LIST LIST_LENGTH )
    string( REGEX REPLACE "\n" "" RES "${RES}" )
    string( STRIP "${RES}" RES )
    string( REGEX REPLACE "${SPECIAL_CHARS}"  "\\\\\\1"                     RES_REGEX "${RES}"       ) # mask regex chars in string
    string( REGEX REPLACE "${RES_REGEX}(.*)$" "\\1"                         WORKER    "${WORKER}"    ) # Remove RES from worker
    string( REGEX REPLACE "${RE}"             ";"                           RES_REGEX "${RES_REGEX}" ) # undo replacing ;
    string( REGEX REPLACE "${RES_REGEX}(.*)$" "\n${AN} ${LIST_LENGTH}\n\\1" NEW_RAW   "${NEW_RAW}"   ) # Replace annotation with reference
    string( REGEX REPLACE "${classInfo_ANNOTATION_START}" ""                RES       "${RES}"       )
    string( STRIP "${RES}" RES )
    list( APPEND OUT_LIST "${RES}" )
    log( LEVEL1 "${RES}" )
    string( REGEX MATCH "${classInfo_ANNOTATION_START}[^\n]+\n" RES "${WORKER}" )
  endwhile()

  set( ${INPUT} "${NEW_RAW}" PARENT_SCOPE )

  returnVal( "${OUT_LIST}" )
endfunction()

