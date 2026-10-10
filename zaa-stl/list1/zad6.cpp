#include <iostream>
#include <string>

int main() {

  std::string data;
  std::cin >> data;

  // 05.10.2026 -> 5 października 2026

  std::string day = data.substr(0, 2);
  int month = std::stoi(data.substr(3, 2));
  std::string year = data.substr(6, 4);
  
  std::cout << day;

  switch (month) {
    case 1:
      std::cout << " styczenia ";
      break;
    case 2:
      std::cout << " lutego ";
      break;
    case 3:
      std::cout << " marca ";
      break;
    case 4:
      std::cout << " kwietnia ";
      break;
    case 5:
      std::cout << " maja ";
      break;
    case 6:
      std::cout << " czerwca ";
      break;
    case 7:
      std::cout << " lipca ";
      break;
    case 8:
      std::cout << " sierpnia ";
      break;
    case 9:
      std::cout << " wrzesnia ";
      break;
    case 10:
      std::cout << " pazdziernika ";
      break;
    case 11:
      std::cout << " listopada ";
      break;
    case 12:
      std::cout << " grudnia ";
      break;
  }

  std::cout << year << std::endl;
  

  return 0;
}
