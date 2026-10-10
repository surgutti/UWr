#include <iostream>
#include <cstdint>
#include <cassert>
#include <typeinfo>

auto nth_lucas(std::uint64_t n) {
  if (n == 0) {
    return (std::uint64_t) 2;
  }
  if (n == 1) {
    return (std::uint64_t) 1;
  }

  return nth_lucas(n - 1) + nth_lucas(n - 2);
}

int main() {
 
  std::cout << nth_lucas(0) << std::endl;
  std::cout << nth_lucas(1) << std::endl;
  std::cout << nth_lucas(2) << std::endl;
  std::cout << nth_lucas(3) << std::endl;
  std::cout << nth_lucas(4) << std::endl;
  std::cout << nth_lucas(5) << std::endl;
  std::cout << nth_lucas(10) << std::endl;

  assert(typeid(nth_lucas(5)) == typeid(std::uint64_t));

  return 0;
}
