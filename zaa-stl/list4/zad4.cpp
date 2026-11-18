#include <iostream>
#include <string>
#include <set>
#include <list>
#include <vector>
#include <numeric>
#include <algorithm>

template <typename T>
class InRange {
public:
  InRange(T a, T b) : a(a), b(b) { }

  void operator()(const T& v) const {
    if (a < v && v < b) {
      std::cout << v << std::endl;
    }
  }
private:
  T a, b;
};

template <typename T>
class PrintKth {
public:
  PrintKth(int p, int k) : p(p), k(k), counter(0) { }

  void operator()(const T& v) const {
    if (counter >= p && (counter - p) % k == 0) {
      std::cout << v << std::endl;
    }
    counter++;
  }

private:
  int p, k;
  mutable int counter;
};

template <typename T>
class MinMax {
public:
  MinMax() : min_v(std::numeric_limits<T>::max()),
             max_v(std::numeric_limits<T>::lowest()) { }

  void operator()(const T& v) {
    if (v < min_v) {
      min_v = v;
    }
    if (v > max_v) {
      max_v = v;
    }
  }

  std::pair<T, T> result() const {
    return {min_v, max_v};
  }
  
private:
  T min_v, max_v;
};

int main() {

  std::cout << std::numeric_limits<std::string>::max() << "\n";
  return 0;

  std::vector<double> v {1.2, 5.5, 3.1, 9.8, 0.4, 7.7, 4.2, 8.1, 2.3};
  std::list<int> l {12, 3, 45, 7, 19, 2, 88, 34, 11, 5};
  std::set<std::string> s = {"test", "test1", "aba", "cbc", "test"};
  
  {
    std::cout << "InRange:" << std::endl;
    std::for_each(v.begin(), v.end(), InRange<double>(2.0, 8.0));
    std::cout << "PrintKth:" << std::endl;
    std::for_each(v.begin(), v.end(), PrintKth<double>(2, 3));
    auto [min_v, max_v] = std::for_each(v.begin(), v.end(), MinMax<double>()).result();
    std::cout << "min_v, max_v: " << min_v << ' ' << max_v << std::endl;
  }

  {
    std::cout << "InRange:" << std::endl;
    std::for_each(l.begin(), l.end(), InRange<int>(2, 8));
    std::cout << "PrintKth:" << std::endl;
    std::for_each(l.begin(), l.end(), PrintKth<int>(2, 3));
    auto [min_v, max_v] = std::for_each(l.begin(), l.end(), MinMax<int>()).result();
    std::cout << "min_v, max_v: " << min_v << ' ' << max_v << std::endl;
  }

  {
    std::cout << "InRange:" << std::endl;
    std::for_each(s.begin(), s.end(), InRange<std::string>("a", "d"));
    std::cout << "PrintKth:" << std::endl;
    std::for_each(s.begin(), s.end(), PrintKth<std::string>(2, 3));
    auto [min_v, max_v] = std::for_each(s.begin(), s.end(), MinMax<std::string>()).result();
    std::cout << "min_v, max_v: " << min_v << ' ' << max_v << std::endl;
  }

}
