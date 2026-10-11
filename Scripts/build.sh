#!/usr/bin/env bash

set -eou pipefail

CONFIG="Debug"
COMPILER="clang"
CLEAN=false

usage() {
    echo "Usage: $0 [debug|release] [clang|gcc|default] [--clean]"
    echo
    echo "Options:"
    echo "  debug|release     Build configuration (default: debug)"
    echo "  clang|gcc|default Compiler preset (default: clang)"
    echo "  --clean           Remove the selected build directory before building"
    echo "  --help            Show this help message"
}

# Parse arguments (compatible with Bash 3.2).
for arg in "$@"; do
    # Normalize all arguments to lowercase.
    normalized_arg="$(printf '%s' "$arg" | tr '[:upper:]' '[:lower:]')"

    case "$normalized_arg" in
        debug|release)
            CONFIG="$normalized_arg"
            ;;
        clang|gcc|default)
            COMPILER="$normalized_arg"
            ;;
        --clean)
            CLEAN=true
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            echo "Error: Unknown argument '$normalized_arg'"
            echo
            usage
            exit 2
            ;;
    esac
done

# Locate the project root relative to this script.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

PRESET="${COMPILER}-${CONFIG}"
BUILD_DIR="$PROJECT_ROOT/build/$PRESET"

echo "Project:    $PROJECT_ROOT"
echo "Compiler:   $COMPILER"
echo "Build type: $CONFIG"
echo "Preset:     $PRESET"

# Clean only the selected preset's build directory.
if [[ "$CLEAN" == true ]]; then
    echo "Cleaning:   $BUILD_DIR"

    if [[ -d "$BUILD_DIR" ]]; then
        rm -rf -- "$BUILD_DIR"
    fi
fi

echo
cd "$PROJECT_ROOT"

# Configure
cmake --preset "$PRESET"

# Build
cmake --build --preset "$PRESET"

echo
echo "Build completed successfully."

#Make it executable once:
chmod +x Scripts/build.sh

# ------- Usage
# A couple of details:
#   Arguments can appear in any order.
#   The last configuration argument wins if you specify both Debug and Release.
#   The last compiler argument wins if you specify multiple compilers.
#   --clean removes only the selected preset's build directory.
