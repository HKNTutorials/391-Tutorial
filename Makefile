CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
ASSEMBLY_CSRC=csrc/square_ints.c csrc/fibonacci.c csrc/arewethereyet.c csrc/string_modification.c
ASSEMBLY_SRC=square_ints.s fibonacci.s arewethereyet.s string_modification.s
EXECS=$(SRC:.c=) $(ASSEMBLY_SRC:.s=)

all: $(EXECS)

assembly: $(ASSEMBLY_SRC)

string_modification.s: csrc/string_modification.c
	$(CC) -m32 -Wall -Werror -pedantic -O0 -S $<

%.s: csrc/%.c
	$(CC) -m32 -Wall -Werror -pedantic -Os -S $<

%: %.c
	$(CC) $(CFLAGS) $< -o $@

%: %.s
	$(CC) $(CFLAGS) -Os $< -o $@

clean:
	rm -f $(EXECS)
