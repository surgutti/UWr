#include <iostream>
#include <string>
#include <functional>

template <typename T>
// using fun = std::function<T(T)>;
using fun = T(*)(T);

template <typename T>
void transf(T tab[], int n, fun<T> f) {
  for (int i = 0; i < n; i++) {
    tab[i] = f(tab[i]);
  }
}

int main() {
  {
    int tab[10], n = 10;
    for (int i = 0; i < n; i++) {
      tab[i] = i;
    }

    transf<int>(tab, n, [](int x) {
      return x * x;
    });

    for (int i = 0; i < n; i++) {
      std::cout << tab[i] << ' ';
    }
    std::cout << std::endl;
  }
  
  {
    std::string tab[5] = {"a", "b", "c", "d", "e"};
    int n = 5;

    transf<std::string>(tab, n, [](std::string s) {return s + "X"; });

    for (int i = 0; i < n; i++) {
      std::cout << tab[i] << ' ';
    }
    std::cout << std::endl;
  }

  return 0;
}
