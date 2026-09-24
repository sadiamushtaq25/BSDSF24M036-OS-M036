## Feature-2: Multi-file Project using Make Utility

### 1. Explain the linking rule `$(TARGET): $(OBJECTS)`. How is it different from a Makefile rule that links against a library?

The rule `$(TARGET): $(OBJECTS)` means that the final executable depends on all the required object files. The object files are linked together to create the target executable. If any object file is changed, Make can rebuild the final executable.

For example:

    $(TARGET): $(OBJECTS)
        $(CC) $(OBJECTS) -o $(TARGET)

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

In Part 3, the Makefile creates a static library `lib/libmyutils.a` from `mystrfunctions.o` and `myfilefunctions.o`. The executable `bin/client_static` links `main.o` with this library.

The important changes are the `LIB` and `LIB_OBJS` variables and the rule that creates `lib/libmyutils.a` using `ar`. The final executable depends on the static library instead of directly linking all utility object files.

### 2. What is the purpose of `ar`? Why is `ranlib` often run immediately after it?

The `ar` utility is used to create and manage archive files. In this project, it combines `mystrfunctions.o` and `myfilefunctions.o` into the static library `libmyutils.a`.

`ranlib` creates or updates the symbol index of a static library. This index helps the linker quickly find the required symbols inside the archive. In this project, `ar rcs` already creates the symbol index, so a separate `ranlib` command is not required.

### 3. When you run `nm` on `client_static`, are symbols like `mystrlen` present? What does this tell you about static linking?

Yes, symbols such as `mystrlen`, `mystrcpy`, `mystrncpy`, `mystrcat`, `wordCount`, and `mygrep` are present in `client_static`.

This shows that the required functions from the static library were copied into the final executable during linking. Therefore, the executable contains the required code from `libmyutils.a` and does not need to load that library at runtime.

## Feature-4: Creating and Using Dynamic Library

### 1. What is Position-Independent Code (-fPIC) and why is it a fundamental requirement for creating shared libraries?

Position-Independent Code (PIC) is machine code that can execute correctly regardless of the memory address where it is loaded.

The `-fPIC` option tells GCC to generate position-independent code. This is important for shared libraries because the operating system may load the same shared library at different memory addresses in different processes.

In this project, the utility source files were compiled with `-fPIC` and then combined into `lib/libmyutils.so` using the `-shared` option.

### 2. Explain the difference in file size between the static and dynamic clients. Why does this difference exist?

The static client contains the required utility-library code inside the executable because the required object code is copied from `libmyutils.a` during static linking.

The dynamic client does not contain the complete implementation of the utility library. Instead, it contains information that allows the dynamic loader to use `libmyutils.so` at runtime.

Therefore, static and dynamic executables can have different sizes because static linking places library code into the executable, while dynamic linking keeps the shared library as a separate file.

### 3. What is the `LD_LIBRARY_PATH` environment variable? Why was it necessary to set it?

`LD_LIBRARY_PATH` is an environment variable used by the dynamic loader to specify additional directories where shared libraries should be searched for.

The project's `lib/` directory was not automatically searched for `libmyutils.so`. Therefore, the variable was temporarily set using:

    export LD_LIBRARY_PATH=$PWD/lib

After setting it, the dynamic loader could find `libmyutils.so`, and `bin/client_dynamic` executed successfully.

The command:

    ldd bin/client_dynamic

was also used to inspect the shared-library dependencies and verify that `libmyutils.so` was resolved from the project's library directory.

## Feature-5: Creating and Accessing Man Pages

### 1. What man pages were created?

A `man/man3/` directory was created in the project.

Six man pages were created for the utility functions:

- `mystrlen.3`
- `mystrcpy.3`
- `mystrncpy.3`
- `mystrcat.3`
- `wordCount.3`
- `mygrep.3`

The man pages use standard groff/man syntax including `.TH`, `.SH NAME`, `.SH SYNOPSIS`, `.SH DESCRIPTION`, `.SH RETURN VALUE`, and `.SH SEE ALSO`.

### 2. What does the `install` target in the Makefile do?

The `install` target provides a simple way to install the built programs, shared library, and man pages into standard system directories.

It installs:

    client_dynamic  -> /usr/local/bin/
    client_static   -> /usr/local/bin/
    libmyutils.so   -> /usr/local/lib/
    man pages       -> /usr/local/share/man/man3/

The installation is performed using:

    sudo make install

### 3. How was the installation tested?

The installed files were checked using:

    ls -lh /usr/local/bin/client_dynamic
    ls -lh /usr/local/bin/client_static
    ls -lh /usr/local/lib/libmyutils.so
    ls -lh /usr/local/share/man/man3/

All six man pages were successfully installed.

The installed documentation can be accessed using:

    man mystrlen

This confirmed that the man page installation was working.

## Final Git Workflow and Releases

The project was developed using separate Git branches for the major features:

- `multifile-build`
- `static-build`
- `dynamic-build`
- `man-pages`

The completed feature branches were merged into `main`.

The project versions were marked using Git tags:

- `v0.1.1-multifile`
- `v0.2.1-static`
- `v0.3.1-dynamic`
- `v0.4.1-final`

The corresponding versions were published as GitHub Releases.

The final `v0.4.1-final` release contains the completed project with man pages and installation support.

The final `main` branch was pushed to GitHub and the working tree was clean after the final changes.
