# Scripts Directory

This folder/directory is for custom scripts (e.g., formatting, build tools).

## Available Scripts

| Script    | Platform              | Description                                           |
|-----------|-----------------------|-------------------------------------------------------|
|build.ps1  | Windows	            | Configures and builds the project using PowerShell.   |
|build.sh   | Windows, Linux, macOS | Configures and builds the project using Bash.         |

## Usage

Run commands from the project root, or invoke the scripts directly from the Scripts directory.

### PowerShell

If script execution is disabled, run this command in your PowerShell terminal:
`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
This allows scripts to run in the current PowerShell process without permanently changing your execution policy. Closing the terminal ends the change.

Debug build (default: MSVC)
`.\Scripts\build.ps1`

Release build
`.\Scripts\build.ps1 -Config Release`

Clean build
`.\Scripts\build.ps1 -Clean`

Use Clang
`.\Scripts\build.ps1 -Compiler Clang`

### Bash

Debug build (default: Clang)
`./Scripts/build.sh`

Release build
`./Scripts/build.sh Release`

Clean build
`./Scripts/build.sh --Clean`

Use GCC
`./Scripts/build.sh Debug GCC`


Both scripts use the presets defined in the root CMakePresets.json. Ensure the selected compiler and build tools are installed and available in your environment.
On Windows, build.sh requires a Bash environment such as Git Bash or MSYS2. For native MSVC builds, ensure the Visual Studio build environment is initialized.
