#include <iostream>
#include <string>
#include <set>

// typedef std::set<std::string> SS;
using SS = std::set<std::string>;

int main() {
  
  SS zbior {"", "123", "abc", "abc123"};

  for (auto napis : zbior) {
    std::cout << napis << std::endl;
  }

  return 0;
}
