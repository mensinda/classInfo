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
#include "ClassA.hpp"
#include <stdint.h>
#include <iostream>

namespace test1 {

class [[deprecated]]
ClassB
:
public base::ClassA {
 public:
   ClassB() = delete;
   ClassB( int _b );

   //@! RegexTest( "Replacing? this [^1] with regex is $o much funn...*" )
   virtual uint32_t f2() override;
   void             f3();
   static void
   [[deprecated]]
   f4();
   void doStuff( int b ) {
      // Inline Function
      std::cout << "b: " << b << std::endl;
   }
};
}
