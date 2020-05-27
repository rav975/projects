flex mylexer.l
bison -d myparser.y
gcc *.c -lfl -o mycompiler.out

