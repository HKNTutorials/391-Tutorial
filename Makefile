CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
ASSEMBLY_CSRC=csrc/square_ints.c csrc/fibonacci.c
ASSEMBLY_SRC=square_ints.s fibonacci.s
EXECS=$(SRC:.c=) $(ASSEMBLY_SRC:.s=)

all: $(EXECS)

assembly: $(ASSEMBLY_SRC)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

%: %.s
	$(CC) $(CFLAGS) $< -o $@

%.s: csrc/%.c
	$(CC) -m32 -Wall -Werror -pedantic -Os -S $< -o $@

clean:
	rm $(EXECS)
