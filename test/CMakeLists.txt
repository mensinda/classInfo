include( ../classInfo.cmake )
classInfo_init()

set( SRC ClassA.cpp ClassB.cpp main.cpp )
set( INC ClassA.hpp ClassB.hpp ClassC.hpp )

new( ClassInfo generator )

foreach( I IN LISTS INC )
  generator( CALL parseFile "${I}" )
endforeach()

add_executable(classinfo ${SRC})
set_property(TARGET classinfo PROPERTY CXX_STANDARD 14)
install(TARGETS classinfo RUNTIME DESTINATION bin)
