#include <iostream>
#include <vector>
#include <compare>
#include <iterator>

using Iter = std::vector<int>::const_iterator;

std::pair<Iter, Iter> przedzial_wartosci(const std::vector<int>& ciag, int wartosc) {
  Iter lower_it = ciag.cbegin();
  auto count = std::distance(lower_it, ciag.cend());
  
  while (count > 0) {
    auto step = count / 2;
    Iter mid = lower_it + step;
    
    if ((*mid <=> wartosc) < 0) {
      lower_it = mid + 1;
      count -= step + 1;
    } else {
      count = step;
    }
  }

  Iter upper_it = lower_it;
  count = std::distance(upper_it, ciag.cend());
  
  while (count > 0) {
    auto step = count / 2;
    Iter mid = upper_it + step;
    
    if ((*mid <=> wartosc) <= 0) {
      upper_it = mid + 1;
      count -= step + 1;
    } else {
      count = step;
    }
  }

  return std::make_pair(lower_it, upper_it);
}

int main() {
  std::vector<int> ciag = {1, 2, 3, 3, 4, 5, 5, 5, 6, 7, 7, 7, 7, 8, 9};

  auto [start_it, end_it] = przedzial_wartosci(ciag, 7);

  for (auto it = start_it; it != end_it; ++it) {
    std::cout << *it << " ";
  }
  std::cout << "\n";

  return 0;
}
