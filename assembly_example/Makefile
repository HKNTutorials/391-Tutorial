ALL: inline

assembly.o: assembly.s
	as --32 assembly.s -g -o assembly.o

inline.o : inline.c
	gcc -m32 -c inline.c -g -o inline.o

inline: inline.o assembly.o
	gcc -m32 inline.o assembly.o -g -o inline
