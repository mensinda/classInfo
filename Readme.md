# classInfo

classInfo is a CMake library to generated C++ code to store metadata about a C++ project.

This includes:

 - namespaces
 - classes / structs / unions
 - functions / member functions / constructors / etc.
 - annotations (magic comments starting with `//@!`)


The generated source code can then be used to get information about classes during runtime

# Status

 - [ ] CMake parser - in progress
 - [ ] CMake code generator
   - [ ] JSON
   - [ ] C++
 - [ ] C++ library to access generated code

# CMake variables

Do not modify any variable starting with ooCMake_INTERNAL or classInfo_INTERNAL.

 - classInfo_ANNOTATION_START can be used to change the default annotation comment syntax (replace `//@!`)
