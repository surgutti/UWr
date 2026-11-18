#include <iostream>
#include <memory>
#include <random>

using namespace std;

class Counter {
private:
  uint64_t value;

public: 
  Counter() : value(1) { } 

  void increase(uint64_t x) {
    value += x;
  }

  uint64_t get_value() const {
    return value;
  }

  virtual ~Counter() {
    cerr << "Destructor: " << value << endl;
  }
};

using CounterArrPtr = unique_ptr<Counter[]>;

mt19937 rng(2137);
CounterArrPtr jazda(CounterArrPtr arr, int n, int i, int m) {
  if (i > m) {
    return arr;
  }

  for (int j = 0; j < n / 10; j++) {
    uniform_int_distribution<int> dist(0, n - 1);
    int index = dist(rng);
    arr[index].increase(i);
  }

  return jazda(move(arr), n, i + 1, m);
}

int main() {

  int n = 10, m = 3;

  auto arr = make_unique<Counter[]>(n);
  arr = jazda(move(arr), n, 0, m);

  for (int i = 0; i < n; i++) {
    cout << "Counter> " << i << ": " << arr[i].get_value() << '\n';
  }

  return 0;
}
