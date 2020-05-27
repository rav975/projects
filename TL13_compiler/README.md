# TL13 Compiler

TL13 to C Compiler
- Tl13 is a simplified subset of Pascal
- compiles TL13 code into C code 
- uses Flex and Bison
- uses uthash for symbol table
- use build.sh to build the compiler
- use run.sh to run the compiler. Replace sample1.in with desired input file
- run.sh pipes console output to a .c file 
- does not fully type check expressions
- some informal semantics not checked 

Future Improvements
- type check expressions and informal semantics
- write output directly to c file
