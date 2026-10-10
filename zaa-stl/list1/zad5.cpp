#include <iostream>
#include <cmath>

int main() {

  double a, b, c;
  std::cin >> a >> b >> c;

  if (double d2 = b * b - 4 * a * c; d2 > 0) {
    double d = std::sqrt(d2);
    double x1 = (-b - d) / (2 * a);
    double x2 = (-b + d) / (2 * a);

    std::cout << "2 rozwiazania:" << std::endl;
    std::cout << "x1: " << x1 << std::endl;
    std::cout << "x2: " << x2 << std::endl;
  } else if (d2 == 0) {
    double x0 = -b / (2 * a);
    std::cout << "1 rozwiazanie:" << std::endl;
    std::cout << "x0: " << x0 << std::endl;
  } else {
    std::cout << "0 rozwiazan" << std::endl;
  }

  return 0;
}
