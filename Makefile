CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
EXECS=$(SRC:.c=)
ASSEMBLY_CSRC=csrc/square_ints.c
ASSEMBLY_SRC=square_ints.S

all: $(EXECS)

assembly: $(ASSEMBLY_SRC)

%: %.c
	$(CC) $(CFLAGS) $< -o $@

%: %.S
	$(CC) $(CFLAGS) -s -S $< -o $@

%.S: csrc/%.c
	$(CC) $(CFLAGS) -S $< -o $@

clean:
	rm $(EXECS)
