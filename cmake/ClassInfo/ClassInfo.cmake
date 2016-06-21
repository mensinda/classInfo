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
  private( FUNC removeAndFormat )
  private( FUNC removeFunctionImpl )
  private( FUNC removeHelpers )

  public( FUNC parseFile )
endclass()

function( ClassInfo__parseFile FILE )
  set( RE "!!END!!" )
  set( CM "!!COMMA!!" )
  set( AN "!!ANOTATION!!" )
  set( AB "!!ABSTRACT!!" )

  file( READ "${FILE}" RAW )

  log( LEVEL1 "${FILE} START" )

  this( CALL removeAndFormat RAW )
  getReturn( WORKER )

  this( CALL removeFunctionImpl WORKER )
  getReturn( WORKER )

  this( CALL removeHelpers WORKER )
  getReturn( WORKER )

  foreach( I IN LISTS WORKER )
    message( "${I}" )
  endforeach()

  log( LEVEL1 "${FILE} END" )
  message( "" )
endfunction()
