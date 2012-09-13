CFLAGS=-g -m32 -Wall -Werror -pedantic
CC=gcc
SRC=$(wildcard *.c)
EXECS=$(SRC:.c=) 

all : $(EXECS)

% : %.c
	$(CC) $< $(FLAGS) -o $@

clean:
	rm $(EXECS)
