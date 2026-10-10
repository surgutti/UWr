#include <iostream>
#include <cstdint>

enum class Imie : std::uint16_t {
  Jan,
  Kuba,
  Anna,
  Ewa
};

void powiadom(std::string komunikat, Imie imie) {
  switch (imie) {
    case Imie::Jan:
      std::cout << "Jan: " << komunikat << std::endl;
      break;
    case Imie::Kuba:
      std::cout << "Kuba: " << komunikat << std::endl;
      break;
    case Imie::Anna:
      std::cout << "Anna: " << komunikat << std::endl;
      break;
    case Imie::Ewa:
      std::cout << "Ewa: " << komunikat << std::endl;
      break;
    default:
      std::cout << "Nieznany: " << komunikat << std::endl; 
  }
}

int main() {

  powiadom("Witaj", Imie::Jan);
  powiadom("Hello", Imie::Ewa);

  return 0;
}
