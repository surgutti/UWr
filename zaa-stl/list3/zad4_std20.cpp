#include <iostream>
#include <concepts>
#include <type_traits>

using namespace std;

template <typename From, typename To>
requires 
  (is_pointer_v<From> && convertible_to<remove_pointer_t<From>, To>) ||
  ((!is_pointer_v<From>) && convertible_to<From, To>)
void przenies(const From& from, To& to) {
  if constexpr (is_pointer_v<From>) {
    to = *from;
  } else {
    to = from;
  }
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
