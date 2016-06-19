#pragma once
#include "ClassA.hpp"
#include <stdint.h>

namespace test1 {

class ClassB : public base::ClassA {
 public:
   ClassB() = delete;
   ClassB( int _b );

   virtual uint32_t f2() override;
   void             f3();
   static void      f4();
};
}
