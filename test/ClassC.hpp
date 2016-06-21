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
#include <iostream>
#include <stdint.h>
#include <vector>

namespace // We can parse this but I hope nobody does something like this
test1 {

template <class C>
class ClassC {
 private:
   C test4;

 public:
   ClassC() = delete;
   ClassC( C _b ) : test4(
   _b

   ) {}

   template <class D>
   std::vector<std::string> f3( uint32_t const *StufF );

   static void f4();
   void doStuff( int &b ) const {
      // Inline Function
      std::cout << "b: " << b << std::endl;
   }

   static // C++ code parsing is so mauch fun
   const
   uint32_t *superLongFunc
   ( const uint32_t *arg1,
                            const uint32_t
                            *arg2 = nullptr,
                            const uint32_t *arg3 = nullptr );
};
}

template <
class C>
template <class D>
std::vector<std::string> test1::ClassC<C>::f3( uint32_t const *StufF ) {
   std::cout << sizeof( D ) << " " << sizeof( C ) << std::endl;
}
