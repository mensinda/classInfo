#pragma once
#include <stdint.h>

namespace test1 {

namespace base {

class ClassA {
 private:
   int a;
   int b = 5;

 protected:
   int c = 0;

 public:
   ClassA() : a( 10 ) {
   }
   ClassA( int _b ) : ClassA() {
      b = _b;
   }

   void             f1();
   virtual uint32_t f2() = 0;
   void             f3();
};
}
}
