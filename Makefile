CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
ASSEMBLY_CSRC=csrc/string_modification.c
ASSEMBLY_SRC=string_modification.s
EXECS=$(SRC:.c=)

all: $(EXECS) $(ASSEMBLY_SRC) assembly

assembly: $(ASSEMBLY_SRC:.s=)

# special case rule to prevent mangling of this code
string_modification.s: csrc/string_modification.c
	$(CC) -m32 -Wall -Werror -pedantic -O0 -S $<

# compile but do not assemble *.c files in csrc
%.s: csrc/%.c
	$(CC) -m32 -Wall -Werror -pedantic -Os -S $<

# compile regular *.c files into executables
%: %.c
	$(CC) $(CFLAGS) $< -o $@

# compile *.s files into executables
%: %.s
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(EXECS)
