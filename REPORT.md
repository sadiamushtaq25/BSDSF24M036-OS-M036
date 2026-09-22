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
