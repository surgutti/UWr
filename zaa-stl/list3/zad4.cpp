#include <iostream>
#include <type_traits>

using namespace std;

// from - wartosc/referencja albo wskaznik (is pointer
// to preez referencje niekoniecznie tego sameto typu, is_convertible<>

template <typename From, typename To>
void przenies_impl(From *from, To &to, true_type) {
  static_assert (is_convertible<From, To>());
  to = *from;
}

template <typename From, typename To>
void przenies_impl(const From &from, To &to, false_type) {
  static_assert (is_convertible<From, To>());
  to = from;
}

template <typename From, typename To>
void przenies(From from, To &to) {
  przenies_impl(from, to, is_pointer<From>());
}

int main() {

  {
    int x = 10;
    int y = 20;

    przenies(x, y);

    cout << "x: " << x << " y: " << y << endl;
  }
  {
    int x = 10;
    int y = 20;

    przenies(&x, y);

    cout << "x: " << x << " y: " << y << endl;
  }
  {
    double x = 2.5;
    int y = 5;

    przenies(&x, y);

    cout << "x: " << x << " y: " << y << endl;
  }

  return 0;
}
