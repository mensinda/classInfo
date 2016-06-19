#include "ClassB.hpp"
#include <iostream>

test1::ClassB::ClassB( int _b ) : base::ClassA( _b ) {
   c = 10;
}

uint32_t test1::ClassB::f2() {
   std::cout << "ClassB::f2" << std::endl;
   return 100;
}

void test1::ClassB::f3() {
   std::cout << "ClassB::f3" << std::endl;
}

void test1::ClassB::f4() {
   std::cout << "static ClassB::f4" << std::endl;
}
