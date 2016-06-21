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

function( ClassInfo__removeHelpers INPUT )
  set( WORKER "${${INPUT}}" )

  foreach( I IN LISTS WORKER )
    if( "${I}" STREQUAL "${CM}" )
      continue()
    endif()
    list( APPEND NEW_LIST "${I}" )
  endforeach()

  returnVal( "${NEW_LIST}" )
endfunction()


