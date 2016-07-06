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

class( ClassInfo )
  private( FUNC moveAnnotations )
  private( FUNC removeAndFormat )
  private( FUNC removeFunctionImpl )
  private( FUNC removeHelpers )
  private( FUNC mergeAnnotations )

  public( FUNC ClassInfo )

  private( FUNC process )
  public( FUNC parseFile )
  public( FUNC print )
endclass()

macro( ClassInfo__ClassInfo )
  if( NOT COMMAND "root" )
    new( Object root ROOT ROOT "ROOT" )
  endif()
endmacro()

function( ClassInfo__process FILE )
  string( ASCII 27 ESC )
  set( RE "${ESC}!!END!!" )
  set( CM "${ESC}!!COMMA!!" )
  set( AN "${ESC}!!ANOTATION!!" )
  set( AB "${ESC}!!ABSTRACT!!" )
  set( DL "${ESC}!!DELETED!!" )

  file( READ "${FILE}" RAW )

  this( CALL moveAnnotations RAW )
  getReturn( ANNOTATIONS )

  this( CALL removeAndFormat RAW ANNOTATIONS )
  getReturn( WORKER )

  this( CALL removeFunctionImpl WORKER )
  getReturn( WORKER )

  this( CALL removeHelpers WORKER )
  getReturn( WORKER )

  this( CALL mergeAnnotations WORKER ANNOTATIONS )
  getReturn( WORKER )

  if( ClassInfo_PRINT_FORMATED )
    log( LEVEL2 "Parsed ${FILE}" )
    foreach( I IN LISTS WORKER )
      log( LEVEL3 "${I}" )
    endforeach()
  endif()

  returnVal( "${WORKER}" )
endfunction()

macro( ClassInfo__parseFile FILE )
  this( CALL process "${FILE}" )
  getReturn( ClassInfo_DATA )

  root( CALL parse ClassInfo_DATA 0 ClassInfo_VOID )
endmacro()

macro( ClassInfo__print )
  root( CALL print )
endmacro()
