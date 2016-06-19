include( ../classInfo.cmake )

set( SRC ClassA.cpp ClassB.cpp main.cpp )
set( INC ClassA.hpp ClassB.hpp )

add_executable(classinfo ${SRC})

install(TARGETS classinfo RUNTIME DESTINATION bin)
