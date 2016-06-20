/*
 * Copyright (C) 2016 Daniel Mensinger
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once
#include <stdint.h>

namespace test1 {

namespace base {

class ClassA {
 private:
   int
   a; // Legal C++ code. And we have to support it
   int b = 5;

 protected:
   int c = 0;

 public:
   ClassA() : a( 10 ) {
   }
   ClassA( int _b ) : ClassA() {
      b = _b;
   }

   //@! Test
   void             f1();
   virtual uint32_t f2() = 0;
   void             f3();

   inline void defineInline();
};

void ClassA::defineInline() {
   // Do Fancy stuff
   if( true ) {
      // asd
   } else {
      // bbb
   }
}

}
}
