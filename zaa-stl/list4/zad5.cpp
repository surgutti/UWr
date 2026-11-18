#include <iostream>
#include <vector>
#include <utility>
#include <functional>
#include <algorithm>

int main() {

  std::function<int(int, int)> C = [&C](int n, int k) -> int {
    if (n < 0 || k < 0) {
      throw std::invalid_argument("Wartosc n lub k są < 0");
    }
    if (k > n) {
      return 0;
    }
    if (k == 0 || k == n) {
      return 1;
    }
    return C(n - 1, k - 1) + C(n - 1, k);
  };

  std::vector<std::pair<int, int>> tests = {
    {5, 2}, {6, 3}, {4, 0}, {5, 5}, {2, -1}
  };

  std::vector<int> vals;

  try {
    std::transform(
      tests.begin(), tests.end(),
      std::back_inserter(vals),
      [&C](std::pair<int, int> p) {
        return C(p.first, p.second);
      }
    );
  } catch (const std::exception& e) {
    std::cout << "Error: " << e.what() << std::endl;
  }

  std::cout << "vals: ";
  for (int res : vals) {
    std::cout << res << " ";
  }
  std::cout << std::endl;

  return 0;
}
