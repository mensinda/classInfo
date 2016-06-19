#include "ClassA.hpp"
#include <iostream>

void test1::base::ClassA::f1() {
   std::cout << "ClassA::f1 a=" << a << "; b=" << b << "; c=" << c << std::endl;
   std::cout << "ClassA::f1 f2=" << f2() << std::endl;
}

void test1::base::ClassA::f3() {
   std::cout << "ClassA::f3 a=" << a << "; b=" << b << "; c=" << c << std::endl;
}
