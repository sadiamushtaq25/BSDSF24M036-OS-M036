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
# -------------------------
# Install
# -------------------------

# -------------------------
# Install
# -------------------------

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
LIBDIR = $(PREFIX)/lib
MANDIR = $(PREFIX)/share/man/man3

install: all
	install -d $(BINDIR)
	install -d $(LIBDIR)
	install -d $(MANDIR)
	install -m 755 $(DYNAMIC_TARGET) $(BINDIR)/client_dynamic
	install -m 755 $(STATIC_TARGET) $(BINDIR)/client_static
	install -m 755 $(DYNAMIC_LIB) $(LIBDIR)/libmyutils.so
	install -m 644 man/man3/*.3 $(MANDIR)/
