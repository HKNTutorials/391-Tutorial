CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
ASSEMBLY_CSRC=csrc/string_modification.c
ASSEMBLY_SRC=string_modification.s
EXECS=$(SRC:.c=) string_modification square_ints

all: $(EXECS) $(ASSEMBLY_SRC) assembly

.PHONY: assembly
assembly: $(ASSEMBLY_SRC:.s=)

# compile but do not assemble *.c files in csrc
%.s: csrc/%.c
	$(CC) -m32 -Wall -Werror -pedantic -O0 -S $<

# compile regular *.c files into executables
%: %.c
	$(CC) $(CFLAGS) $< -o $@

# compile *.s files into executables
%: %.s
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(EXECS)
# these are generated assembly files
	rm -f *.s
	rm -rf $(addsuffix .dSYM,$(EXECS))
