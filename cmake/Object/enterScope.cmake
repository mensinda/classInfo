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

macro( Object__enterScope TYPE NAME LIST_VAR INDEX OUT_INDEX OUT_OBJ_NAME )
  this( GET NAME )
  getReturn( Object_NAME )
  this( GET TYPE )
  getReturn( Object_TYPE )
  this( GET SCOPE )
  getReturn( Object_SCOPE )
  this( GET CHILDREAN )
  getReturn( Object_CHILDREAN )

  if( "${Object_TYPE}" MATCHES "(NS|CLASS|STRUCT)" )
    set( Object_SCOPE "${Object_SCOPE}::${Object_NAME}" )
  endif()

  string( REGEX REPLACE ":" "_" Object_SCOPE_OBJ "${Object_SCOPE}" )

  if( NOT COMMAND "${Object_SCOPE_OBJ}__${NAME}" )
    new( Object "${Object_SCOPE_OBJ}__${NAME}" "${NAME}" "${TYPE}" "${Object_SCOPE}" )
    list( APPEND Object_CHILDREAN "${Object_SCOPE_OBJ}__${NAME}" )
    set( ${OUT_OBJ_NAME} "${Object_SCOPE_OBJ}__${NAME}" )
    this( SET CHILDREAN "${Object_CHILDREAN}" )
  endif()

  _( "${Object_SCOPE_OBJ}__${NAME}" CALL parse ${LIST_VAR} ${INDEX} ${OUT_INDEX} )
endmacro()
