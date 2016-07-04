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
#include <string>

namespace test1 {

namespace base {

class ClassA {
 public:
   typedef
   struct
   ABC {
      std::string something;
   } ABCD;

   struct
   AB {
      std::string something;
   } AAA
   ;

   union U1 {
      int a[3];
      int x;
      int y;
      int z;
   };

   typedef
   std::string oi;


 private:   int
   a; // Legal C++ code. And we have to support it
   int b = 5;
   const std::string CONST_STR = "String with a '\";\"' char";
   std::string str1;

 protected:
   int c = 0;

 public:
   ClassA() : a( 10 ), str1( "String ; str" ) {
   }
   ClassA( int _b ) : ClassA() {
      b = _b;
   }

   //@! Test("String; a")
   void             f1();
   virtual uint32_t f2() = 0;
   void             f3();

   inline void defineInline();
};

void ClassA::defineInline() {
   // Do Fancy stuff
   ABCD struc;
   if( true ) {
      // asd
   } else {
      // bbb
   }
}

}
}
