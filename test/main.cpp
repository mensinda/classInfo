#include "ClassB.hpp"
#include "ClassC.hpp"
#include <iostream>

int main( int argc, char **argv ) {
   test1::ClassB test1( 50 );
   test1::ClassC<int> test2( 10 );
   return 0;
}
