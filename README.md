# MyProjectCpp

A cross-platform C++ project built with CMake, using a Core & App architecture.
Core contains reusable functionality, while App contains the executable entry point and application-specific code.

## Features

- C++17
- Cross-platform support: Windows, Linux, and macOS
- CMake-based build system with Debug and Release presets
- Static Core library
- Support for MSVC, Clang, and GCC
- VSCodium development support
- clangd for IntelliSense and diagnostics
- ClangFormat for consistent code formatting
- Optional third-party dependencies and custom scripts
- PowerShell and Bash build scripts


## Project Structure
```
MyProjectCpp/
├── Core/                   # Reusable static library
│   ├── Include/
│   │   └── Core/           # Public headers
│   ├── Source/             # Implementation files
│   └── CMakeLists.txt
├── App/                    # Application executable
│   ├── Source/
│   │   └── main.cpp
│   └── CMakeLists.txt
├── External/               # Optional third-party dependencies (e.g. libraries and modules)
├── Scripts/                # Optional development scripts (e.g. build and development)
├── .vscode/                # Editor and debugger configuration
├── .clang-format           # Code formatting rules
├── .gitattributes          # Git line-ending rules
├── .gitignore
├── CMakeLists.txt          # Root build configuration
├── CMakePresets.json       # Build presets
└── README.md
```
Additional applications can be added as independent directories and linked against Core.


## Requirements

Install the following tools:

- CMake 3.21 or newer — project configuration and build management.
- A C++ compiler — MSVC, Clang, or GCC.
- Ninja — recommended for Ninja-based presets. Required by the supplied Clang and GCC presets.
- Git — source control.
- VSCodium or VSCode — recommended editor.
- LLVM tools — optional but recommended for clangd and ClangFormat.

On Windows, MSVC requires the Visual Studio Build Tools or Visual Studio installation, including a compatible Windows SDK.

The Bash build script requires Bash, available by default on Linux and macOS.

On Windows, use an environment such as Git Bash or MSYS2.

For native MSVC builds, ensure the Visual Studio compiler environment is initialized.


## Building

Build scripts are provided for convenience. Both scripts use presets defined in the CMakePresets.json.

### Windows - PowerShell

If PowerShell blocks locally created scripts, you can allow scripts for the current terminal session:
- `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`.
   - This applies only to the current PowerShell process and does not permanently change your execution policy. Closing the terminal ends the change.

Run the commands below from the project root.
- Debug build (default: MSVC): `.\Scripts\build.ps1`
- Release build: `.\Scripts\build.ps1 -Config Release`
- Clean Debug build: `.\Scripts\build.ps1 -Clean`
- Clang Debug build: `.\Scripts\build.ps1 -Compiler Clang`
- GCC Release build: `.\Scripts\build.ps1 -Compiler GCC -Config Release`

### Bash - Windows, Linux, and macOS

On Windows, run these commands in Git Bash or another compatible Bash environment.
- Debug build (default: Clang): `./Scripts/build.sh`
- Release build: `./Scripts/build.sh Release`
- Clean Debug build: `./Scripts/build.sh --Clean`
- GCC Debug build: `./Scripts/build.sh Debug GCC`
- Clang Release build: `./Scripts/build.sh Release Clang`

The `--clean` option removes the selected preset's build directory before configuring and building again.

### Using CMake Directly

You can also configure and build without the helper scripts.

Configure
- `cmake --preset clang-debug`

Build
- `cmake --build --preset clang-debug`

For Release:
- `cmake --preset clang-release`
- `cmake --build --preset clang-release`

For native Windows MSVC builds:
- `cmake --preset msvc-debug`
- `cmake --build --preset msvc-debug`

The MSVC presets use the Visual Studio generator. The supplied Clang and GCC presets use Ninja.

Each preset uses its own build directory under `build/`, keeping configurations separate.

### Run the application

After building the project, locate the generated executable in the selected preset's build directory under `build/`.

Typical locations include:
- MSVC: build/msvc-debug/bin/Debug/MyProjectApp.exe
- Clang: build/clang-debug/bin/MyProjectApp
- GCC: build/gcc-debug/bin/MyProjectApp

Actual output paths depend on your CMake output-directory settings and generator.

Run the executable from a terminal if you want to see its console output.

These examples assume your current target name and output-directory settings match those paths.


## Development

### VSCodium / VSCode

Open the project root in VSCodium.

Recommended tooling:
- CMake Tools — configure, build, and select CMake targets.
- clangd — IntelliSense, code navigation, and diagnostics.
- ClangFormat — automatic code formatting.
- LLDB, GDB, or Mago-MI — debugging, depending on your compiler and installed extensions.

Avoid enabling multiple competing IntelliSense engines simultaneously. If using clangd, ensure it can access a compatible compilation database and locate the compiler's headers.

For MSVC builds, debugging support depends on the installed debugger and its compatibility with MSVC's executable and debug-information formats.

#### **Recommended Extension Pack (VSCodium)**:
For a convenient development setup, consider installing the **C++ Extension Pack for VSCodium**. It includes several useful tools for this project, including:
- clangd — IntelliSense, code completion, and navigation.
- CMake and CMake Tools — CMake configuration and build integration.
- ClangFormat — code formatting.
- Native Debug — GDB, LLDB, and Mago-MI debugging support.

The pack also includes additional C++ development tools. Individual extensions can be installed separately if preferred.

**NOTE**: You still need to install the required compilers and build tools separately. Debugger compatibility depends on your compiler and platform.

### Code Formatting

Formatting rules are defined in .clang-format.

Format a file manually: `clang-format -i path/to/file.cpp`

Configure VSCodium to use ClangFormat as the default formatter for C++ files and enable format-on-save if desired.

### CMake Presets

List configure presets: `cmake --list-presets`

List build presets: `cmake --list-presets=build`

Available presets include:
```
| Compiler          | Debug         | Release         |
|-----------------------------------------------------|
| Default Generator | default-debug | default-release |
| MSVC              | msvc-debug    | msvc-release    |
| Clang             | clang-debug   | clang-release   |
| GCC               | gcc-debug     | gcc-release     |
```


## Architecture

### Core

Core is a reusable static library containing business logic, algorithms, data structures, and other functionality independent of a particular application.
- Public headers belong in Core/include/Core/.
- Implementation files belong in Core/src/.
- Applications link against Core instead of duplicating its implementation.

### App

App contains the executable entry point and application-specific code.
Additional applications can be created in separate directories and linked against the same Core library.


## Dependencies

Place optional third-party libraries and modules in `External/`.

Depending on the library, integrate it using `add_subdirectory()`, `find_package()`, or another appropriate CMake mechanism.

Keep third-party dependencies separate from Core's own public headers and implementation.


## Build Configuration

Compiler settings, target definitions, output directories, and build options are managed through the root CMakeLists.txt and CMakePresets.json.

When adding a new build option, define it in CMake and document it here if it is relevant to project users.

Native CPU optimizations should only be enabled when the resulting binaries are intended for compatible processors.


## License
TODO: Add your chosen license. Consider including a separate LICENSE file in the project root.
