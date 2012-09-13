CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
ASSEMBLY_CSRC=csrc/square_ints.c csrc/fibonacci.c
ASSEMBLY_SRC=square_ints.S fibonacci.S
EXECS=$(SRC:.c=) $(ASSEMBLY_SRC:.S=)

all: $(EXECS)

assembly: $(ASSEMBLY_SRC)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

%: %.S
	$(CC) $(CFLAGS) $< -o $@

%.S: csrc/%.c
	$(CC) -m32 -Wall -Werror -pedantic -Os -S $< -o $@

clean:
	rm $(EXECS)
