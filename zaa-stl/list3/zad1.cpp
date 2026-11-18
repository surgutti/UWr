#include <iostream>
#include <limits>

using namespace std;

int main() {
  cout << boolalpha;

  using NL = numeric_limits<long long int>;

  // -2**63
  cout << "min: " << NL::min() << endl;
  // 2**63 - 1 
  cout << "max: " << NL::max() << endl;
  // true
  cout << "is_signed: " << NL::is_signed << endl;
  // 63 (+1 na znak)  
  cout << "digits: " << NL::digits << endl;
  // 18
  cout << "digits10: " << NL::digits10 << endl;

  return 0;
}
