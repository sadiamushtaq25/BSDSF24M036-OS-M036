CC = gcc
CFLAGS = -Wall -Iinclude

TARGET = bin/client_static
LIB = lib/libmyutils.a

MAIN_OBJ = obj/main.o
LIB_OBJS = obj/mystrfunctions.o obj/myfilefunctions.o

all: $(TARGET)

$(TARGET): $(MAIN_OBJ) $(LIB)
	$(CC) $(MAIN_OBJ) -Llib -lmyutils -o $(TARGET)

$(LIB): $(LIB_OBJS)
	ar rcs $(LIB) $(LIB_OBJS)

obj/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o

obj/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions.o

clean:
	rm -f obj/*.o lib/libmyutils.a bin/client_static
