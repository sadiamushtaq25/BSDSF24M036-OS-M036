CC = gcc
CFLAGS = -Wall -Iinclude
PICFLAGS = -fPIC

STATIC_TARGET = bin/client_static
DYNAMIC_TARGET = bin/client_dynamic

STATIC_LIB = lib/libmyutils.a
DYNAMIC_LIB = lib/libmyutils.so
 
MAIN_OBJ = obj/main.o
LIB_OBJS = obj/mystrfunctions.o obj/myfilefunctions.o
PIC_LIB_OBJS = obj/mystrfunctions_pic.o obj/myfilefunctions_pic.o

all: $(STATIC_TARGET) $(DYNAMIC_TARGET)

# -------------------------
# Static Build
# -------------------------

$(STATIC_TARGET): $(MAIN_OBJ) $(STATIC_LIB)
		$(CC) $(MAIN_OBJ) $(STATIC_LIB) -o $(STATIC_TARGET)

$(STATIC_LIB): $(LIB_OBJS)
	ar rcs $(STATIC_LIB) $(LIB_OBJS)

# -------------------------
# Dynamic Build
# -------------------------

$(DYNAMIC_TARGET): $(MAIN_OBJ) $(DYNAMIC_LIB)
	$(CC) $(MAIN_OBJ) -Llib -lmyutils -o $(DYNAMIC_TARGET)

$(DYNAMIC_LIB): $(PIC_LIB_OBJS)
	$(CC) -shared -o $(DYNAMIC_LIB) $(PIC_LIB_OBJS)

# -------------------------
# Object Files
# -------------------------

obj/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o

obj/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions.o

# Position-Independent Object Files
obj/mystrfunctions_pic.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) $(PICFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions_pic.o

obj/myfilefunctions_pic.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) $(PICFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions_pic.o

# -------------------------
# Clean
# -------------------------

clean:
	rm -f obj/*.o lib/libmyutils.a lib/libmyutils.so bin/client_static bin/client_dynamic
