CFLAGS:=-g -m32 --std=c99 -Wall -Werror -pedantic
CC:=clang

test: test_protocol
	./test_protocol

test_protocol: test_protocol.c protocol.o
	$(CC) $(CFLAGS) $^ -o $@
