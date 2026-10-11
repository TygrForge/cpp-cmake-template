#include "Core/Core.hpp"

#include <iostream>
#include <ostream>

int main() {
    Core::DoSometing();
    std::cout << "App is running!" << std::endl;
    std::cout << Core::Add(75, 25);

    // Wait for Enter before exiting.
    std::cout << "\n\nPress Enter to stop/exit..." << std::endl;
    std::cin.get();
    return 0;
}
