#include <iostream>
#include <string>

template <typename F, typename G>
class compose {
public:
  compose(F f, G g) : f(f), g(g) {}

  template <typename T>
  auto operator()(T x) const {
    return f(g(x));
  }
private:
  F f;
  G g;
};

int f(std::string y) { return (int) y.size(); }
std::string g(int x) { return std::to_string(x); }

int main() {
  
  auto h = [](int x) { return 2 * x; };

  std::cout << compose(f, g)(123) << std::endl;
  std::cout << compose(f, g)(51) << std::endl;
  std::cout << compose(f, g)(2137) << std::endl;

  auto cc = compose(h, compose(f, g));

  std::cout << cc(123) << std::endl;

  return 0;
}
