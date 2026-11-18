#include <iostream>
#include <functional>

template <typename F, typename G>
class sequence {
public:
  sequence(F f, G g) : f(f), g(g) { }

  template <typename T>
  auto operator()(T x) {
    f(x);
    return g(x);
  }
private:
  F f;
  G g; 
};

void wypisz(std::string s) {
  std::cout << "s: " << s << std::endl;
}

void policz(std::string s) {
  std::cout << "size: " << (int) s.size() << std::endl;
}

char wynik(std::string s) {
  return s[0];
}

int main() {

  char res = sequence(sequence(wypisz, policz), wynik)("test");

  std::cout << "res: " << res << std::endl;

}
