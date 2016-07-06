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

function( ClassInfo__removeAndFormat INPUT )
  set( S  "[ \n\t]*" )
  set( ACC "(private|public|protected)" )
  set( NO_BREAK "(typedef|struct|class|union)" )
  string( REGEX REPLACE "\r"                        ""          WORKER "${${INPUT}}" ) # Remove Windows line breaks
  string( REGEX REPLACE "//@!"                      "\n${AN}"   WORKER "${WORKER}"   ) # Replace //@! with magic string
  string( REGEX REPLACE "\\)${S}=${S}0${S};"        ") ${AB};"  WORKER "${WORKER}"   ) # Replace = 0
  string( REGEX REPLACE "\\)${S}=${S}delete${S};"   ") ${DL};"  WORKER "${WORKER}"   ) # Replace = delete
  string( REGEX REPLACE "/\\*.*\\*/"                ""          WORKER "${WORKER}"   ) # Remove C-Style comments
  string( REGEX REPLACE "//[^\n]*\n"                "\n"        WORKER "${WORKER}"   ) # C++ comments
  string( REGEX REPLACE "${S}#[^\n]*\n"             ""          WORKER "${WORKER}"   ) # Remove Preprocessor
  string( REGEX REPLACE "\\)${S}:[^{]+"             ")"         WORKER "${WORKER}"   ) # Remove initialization lists
  string( REGEX REPLACE "\\\\\""                    ""          WORKER "${WORKER}"   ) # Remove Escaped line endings
  string( REGEX REPLACE "\"[^\"]*\""                ""          WORKER "${WORKER}"   ) # Remove Strings
  string( REGEX REPLACE "${S}=[^;,)]*"              ""          WORKER "${WORKER}"   ) # Remove default values
  string( REGEX REPLACE "typedef[^;{]+;"            ""          WORKER "${WORKER}"   ) # Remove typedefs
  string( REGEX REPLACE "({|}|\\(|\\))"             "\n\\1\n"   WORKER "${WORKER}"   ) # Move brackets to newlines
  string( REGEX REPLACE "${ACC}${S}:"               "\n\\1:\n"  WORKER "${WORKER}"   ) # Move access moifiers
  string( REGEX REPLACE "\n[ \t]*"                  "\n"        WORKER "${WORKER}"   ) # Remove starting white space
  string( REGEX REPLACE "[ \t]*\n"                  "\n"        WORKER "${WORKER}"   ) # Remove trailing white space
  string( REGEX REPLACE "(template)${S}<[^>]*>"     "\\1"       WORKER "${WORKER}"   ) # Fix templates
  string( REGEX REPLACE "${NO_BREAK}${S}"           "\\1 "      WORKER "${WORKER}"   ) # Fix class, struct, etc.
  string( REGEX REPLACE "inline${S}(namespace)"     "\\1"       WORKER "${WORKER}"   ) # Remove inline from namespace
  string( REGEX REPLACE "(namespace)\n*"            "\\1 "      WORKER "${WORKER}"   ) # Fix namespace
  string( REGEX REPLACE ";"                         "\n${RE}\n" WORKER "${WORKER}"   ) # Replace ; with something special
  string( REGEX REPLACE ","                         "\n${CM}\n" WORKER "${WORKER}"   ) # Replace , with something special
  string( REGEX REPLACE "\n${S}\n"                  "\n"        WORKER "${WORKER}"   ) # Remove Empty Lines
  string( REGEX REPLACE "^\n${S}"                   ""          WORKER "${WORKER}"   ) # Remove Empty Lines -- start
  string( REGEX REPLACE "${S}\n$"                   ""          WORKER "${WORKER}"   ) # Remove Empty Lines -- end
  string( REGEX REPLACE "\n[ \t]*"                  "\n"        WORKER "${WORKER}"   ) # Remove starting white space
  string( REGEX REPLACE "[ \t]*\n"                  "\n"        WORKER "${WORKER}"   ) # Remove trailing white space

  string( REGEX REPLACE "\n" ";" RAW_LIST "${WORKER}" ) # Convert string to list

  set( TEMP "" )
  set( FOUND_TEMPLATE OFF )

  # fix templates
  foreach( I IN LISTS RAW_LIST )
    if( "${I}" MATCHES "^template.*" OR FOUND_TEMPLATE )
      if( NOT "${I}" STREQUAL "{" AND NOT "${I}" STREQUAL "${RE}" )
        string( APPEND TEMP "${I} " )
        set( FOUND_CLASS ON )
        continue()
      else()
        list( APPEND LIST0 "${TEMP}" )
        list( APPEND LIST0 "${I}" )
        set( FOUND_TEMPLATE OFF )
        set( TEMP           "" )
        continue()
      endif()
    endif()

    list( APPEND LIST0 "${TEMP}${I}" )
    set( TEMP "" )
  endforeach()

  set( TEMP "" )
  set( FOUND_CLASS OFF )

  # fix class
  foreach( I IN LISTS LIST0 )
    if( "${I}" MATCHES "^(typedef${S})?(class|struct).*" OR FOUND_CLASS )
      if( NOT "${I}" STREQUAL "{" )
        string( APPEND TEMP "${I} " )
        set( FOUND_CLASS ON )
        continue()
      else()
        list( APPEND LIST1 "${TEMP}" )
        list( APPEND LIST1 "${I}" )
        set( FOUND_CLASS OFF )
        set( TEMP        "" )
        continue()
      endif()
    endif()

    list( APPEND LIST1 "${I}" )
  endforeach()

  set( TEMP "" )

  # move type and args on the same line
  foreach( I IN LISTS LIST1 )
    if( "${I}" MATCHES "${ACC}:" )
      if( NOT "${TEMP}" STREQUAL "" )
        list( APPEND LIST2 "${TEMP}" )
      endif()
      list( APPEND LIST2 "${I}" )
      set( TEMP "" )
      continue()
    endif()

    if( NOT "${I}" MATCHES "(${RE}|${CM}|${AN}.*|{|}|\\(|\\))" )
      string( APPEND TEMP "${I} " )
    else()
      if( NOT "${TEMP}" STREQUAL "" )
        list( APPEND LIST2 "${TEMP}" )
      endif()
      list( APPEND LIST2 "${I}" )
      set( TEMP "" )
    endif()
  endforeach()

  foreach( I IN LISTS LIST2 )
    set( TEMP "${I}" )
    if( "${TEMP}" MATCHES ".*template.*" )
      string( REGEX REPLACE "template" "" TEMP "${TEMP}" )
      set( TEMP "template ${TEMP}" )
    endif()
    string( REGEX REPLACE "[ \t]+" " " TEMP "${TEMP}" )
    string( STRIP "${TEMP}" TEMP )
    list( APPEND LIST3 "${TEMP}" )
  endforeach()

  returnVal( "${LIST3}" )
endfunction()
