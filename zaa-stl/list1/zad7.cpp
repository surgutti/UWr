#include <iostream>
#include <vector>
#include <algorithm>

class osoba {
public:
  std::string imie;
  std::string nazwisko;
  std::string nazwisko_panienskie;
  int rok_urodzenia;
  int pesel;

  friend bool operator< (const osoba& a, const osoba& b) {
    return std::tie(a.nazwisko, a.imie, a.rok_urodzenia) <
           std::tie(b.nazwisko, b.imie, b.rok_urodzenia);
  }
};

int main() {

  std::vector<osoba> osoby {
    osoba {"Jan", "Kowalski", "Testowy", 2004, 21372137},
    osoba {"Waldemar", "Bak", "Czeresniowy", 1989, 43244324}
  };

  std::sort(osoby.begin(), osoby.end());

  for (const osoba& o : osoby) {
    std::cout << o.imie << ' ' << o.nazwisko << std::endl;
  }

  return 0;
}
