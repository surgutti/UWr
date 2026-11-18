#include <iostream>
#include <limits>

using namespace std;

int main() {

  using NL = numeric_limits<long double>;

  cout << boolalpha;

  cout << "min > 0: " << NL::min() << endl;
  cout << "max: " << NL::max() << endl;
  cout << "has_inf: " << NL::has_infinity << endl;
  cout << "eps: " << NL::epsilon() << endl;

  return 0;
}
