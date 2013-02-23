CFLAGS:=-g -m32 --std=c99 -Wall -Werror -pedantic
CC:=gcc

test: test_protocol
	./test_protocol

all: protocol.o test_protocol

test_protocol: test_protocol.c protocol.o
	$(CC) $(CFLAGS) $^ -o $@
