## Feature-2: Multi-file Project using Make Utility

### 1. Explain the linking rule `$(TARGET): $(OBJECTS)`. How is it different from a Makefile rule that links against a library?

The rule `$(TARGET): $(OBJECTS)` means that the final executable depends on all the required object files. The object files are linked together to create the target executable. If any object file is changed, Make can rebuild the final executable.

For example:

```makefile
$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET)
```

When linking against a library, the Makefile also includes the library as a dependency and uses a library option such as `-lmath` or `-lm` during linking. In that case, the linker gets the required functions from the specified library instead of directly listing all their object files.

### 2. What is a Git tag? Why is it useful? What is the difference between a simple (lightweight) tag and an annotated tag?

A Git tag is a name that points to a specific commit. Tags are useful for marking important versions or milestones of a project. For example, this project uses the tag `v0.1.1-multifile` to identify the multi-file build version.

A lightweight tag is a simple reference to a commit and contains very little additional information. An annotated tag is stored as a separate Git object and contains information such as the tag message, tagger, and date. Annotated tags are useful for official releases because they provide more information about the version.

### 3. What is the purpose of a GitHub Release? What is the significance of attaching binaries such as `client`?

A GitHub Release provides a convenient way to publish a specific version of a project based on a Git tag. It can include release notes and downloadable files.

Attaching a binary such as `client` allows users to download the already-compiled executable without compiling the source code themselves. This makes the project easier to distribute and test.
## Feature-3: Creating and Using Static Library

### 1. Compare the Makefile from Part 2 and Part 3. What are the key differences in variables/rules that enable the static library?

In Part 2, the Makefile directly linked all object files to create the executable `bin/client`.

In Part 3, the Makefile creates a static library `lib/libmyutils.a` from `mystrfunctions.o` and `myfilefunctions.o`. The executable `bin/client_static` links `main.o` with this library using `-Llib -lmyutils`.

The important changes are the `LIB` and `LIB_OBJS` variables and the rule that creates `lib/libmyutils.a` using `ar`. The final executable depends on the static library instead of directly linking all utility object files.

### 2. What is the purpose of `ar`? Why is `ranlib` often run immediately after it?

The `ar` utility is used to create and manage archive files. In this project, it combines `mystrfunctions.o` and `myfilefunctions.o` into the static library `libmyutils.a`.

`ranlib` creates or updates the symbol index of a static library. This index helps the linker quickly find the required symbols inside the archive. In this project, `ar rcs` already creates the symbol index, so a separate `ranlib` command is not required.

### 3. When you run `nm` on `client_static`, are symbols like `mystrlen` present? What does this tell you about static linking?

Yes, symbols such as `mystrlen`, `mystrcpy`, `mystrncpy`, `mystrcat`, `wordCount`, and `mygrep` are present in `client_static`.

This shows that the required functions from the static library were copied into the final executable during linking. Therefore, the executable contains the required code from `libmyutils.a` and does not need to load that library at runtime.
