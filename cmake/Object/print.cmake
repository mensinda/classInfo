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

function( Object__print )
  this( GET CHILDREAN )
  getReturn( CHILDREAN )
  this( GET NAME )
  getReturn( NAME )
  this( GET SCOPE )
  getReturn( SCOPE )
  this( GET TYPE )
  getReturn( TYPE )

  log( LEVEL1 "${SCOPE} ${NAME} (${TYPE})" )

  foreach( I IN LISTS CHILDREAN )
    _( "${I}" CALL print )
  endforeach()
endfunction()

