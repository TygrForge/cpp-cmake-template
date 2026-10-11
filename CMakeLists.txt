cmake_minimum_required(VERSION 3.21)

project(MyProjectCpp
    VERSION 1.0.0
    LANGUAGES CXX
)

# ------- Project Settings
option(MYPROJECT_BUILD_APPS "Build application executables" ON)
option(MYPROJECT_ENABLE_LTO "Enable link-time optimization in Release" OFF)
option(MYPROJECT_ENABLE_NATIVE_OPTIMIZATIONS
    "Optimize for the current CPU (not portable binaries)" OFF
)

# ------- Language Settings
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Default single-configuration generators (Ninja, Makefiles) to Release.
# Multi-configuration generators (Visual Studio, Xcode) select their own
# configuration, so don't override it here.
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING
        "Build type" FORCE
    )
endif()

# ------- Output (build) Directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Keep Debug and Release outputs separate for multi-config generators.
foreach(CONFIG DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG}
        "${CMAKE_BINARY_DIR}/lib/$<CONFIG>")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG}
        "${CMAKE_BINARY_DIR}/lib/$<CONFIG>")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG}
        "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
endforeach()

# ------- Dependencies and Build Behavior
# Prefer static libraries for this project and dependencies that honor
# BUILD_SHARED_LIBS. Explicitly declare Core as STATIC in Core/CMakeLists.txt.
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Prefer static libraries" FORCE)

# Needed when a static library may be linked into a shared library.
# Set to OFF if you don't need that capability.
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# ------- Optional Optimizations
if(MYPROJECT_ENABLE_LTO)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT IPO_SUPPORTED OUTPUT IPO_ERROR)

    if(IPO_SUPPORTED)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE ON)
    else()
        message(WARNING "LTO is unavailable: ${IPO_ERROR}")
    endif()
endif()

if(MYPROJECT_ENABLE_NATIVE_OPTIMIZATIONS)
    if(MSVC)
        add_compile_options(/arch:AVX2)
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
        add_compile_options(-march=native)
    else()
        message(WARNING
            "Native CPU optimizations are not configured for this compiler.")
    endif()
endif()

# ------- Project Modules
add_subdirectory(Core)

if(MYPROJECT_BUILD_APPS)
    add_subdirectory(App)
endif()

# Add other independent applications here as needed:
# add_subdirectory(Editor)
# add_subdirectory(Benchmark)

# ------- Defines
set(EXTERNAL_DIR ${CMAKE_SOURCE_DIR}/External)
set(RUNTIME_DIR ${CMAKE_SOURCE_DIR}/Runtime)

# ------- Optional: External Libraries (Replace or remove as needed)
# Example: Add your own external libraries below
# set(PACKAGE_DIR "${EXTERNAL_DIR}/SomeLibrary")
# find_package(SomeLibrary REQUIRED)
