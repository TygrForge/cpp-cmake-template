#include "Core/Core.hpp"

#include <iostream>

namespace Core
{
    void DoSometing() { std::cout << "Core is doing something!" << std::endl; }

    int Add(int a, int b) { return (a + b); }
} // namespace Core
