add_executable(App
    Source/main.cpp
)

# Link Core library
target_link_libraries(App
    PRIVATE Core
)

# Compile options for App
# GCC Only
#target_compile_options(App PRIVATE
#    -Wall -Wextra -Wpedantic
#)
