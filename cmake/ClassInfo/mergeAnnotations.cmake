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

function( ClassInfo__mergeAnnotations INPUT ANN_LIST )
  set( WORKER  "${${INPUT}}" )
  set( OUT_LIST "" )

  foreach( I IN LISTS WORKER )
    if( "${I}" MATCHES "${AN} [0-9]*" )
      string( REGEX REPLACE "${AN}" "" LIST_INDEX "${I}" )
      string( STRIP "${LIST_INDEX}" LIST_INDEX )
      list( GET ${ANN_LIST} ${LIST_INDEX} OUT )
      list( APPEND OUT_LIST "${AN} ${OUT}" )
    else()
      list( APPEND OUT_LIST "${I}" )
    endif()
  endforeach()

  returnVal( "${OUT_LIST}" )
endfunction()


