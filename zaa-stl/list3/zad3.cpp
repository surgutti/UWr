#include <iostream>
#include <ratio>

using namespace std;

template <int N>
struct H {
  using ile = ratio_add<
    typename H<N - 1>::ile,
    ratio<1, N>
  >;
};

template <>
struct H<1> {
  using ile = ratio<1, 1>;
};

int main() {

  using H20 = H<20>::ile;
  using H46 = H<46>::ile;
  // using H47 = H<47>::ile;

  cout << "H(20) = " << H20::num << " / " << H20::den << endl;
  cout << "H(46) = " << H46::num << " / " << H46::den << endl;
  // cout << "H(47) = " << H47::num << " / " << H47::den << endl;

  return 0;
}
