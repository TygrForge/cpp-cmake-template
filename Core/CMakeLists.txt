add_library(Core STATIC
    Source/Core.cpp
)

# Public headers
target_include_directories(Core
    PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Include>
    $<INSTALL_INTERFACE:include>
)

# Compile options for Core
# GCC Only
#target_compile_options(Core PRIVATE
#    -Wall -Wextra -Wpedantic
#)
target_compile_features(Core PUBLIC cxx_std_17)

set_target_properties(Core
    PROPERTIES
    DEBUG_POSTFIX "-d"
)

# Link Core to App (handled in App/CMakeLists.txt)
