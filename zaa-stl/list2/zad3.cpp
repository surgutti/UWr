#include <iostream>
#include <string>
#include <memory>
#include <vector>
#include <map>

using namespace std;

enum class Sex {
  Male, Female
};

class llama {
public:
  llama(const string& n, Sex s,
        shared_ptr<llama> f = nullptr,
        shared_ptr<llama> m = nullptr) :
    name(move(n)), sex(s), father(move(f)), mother(move(m)) {
    cout << "Constructor(" << name << ")" << endl;
  }

  ~llama() {
    cerr << "Destructor: " << name << endl;
  }

  void add_kid(weak_ptr<llama> kid) {
    kids.push_back(kid);
  }

  string get_name() const { return name; }

private:
  string name;
  Sex sex;
  shared_ptr<llama> father, mother;
  vector<weak_ptr<llama>> kids;
};

class herd {
public:
  map<string, shared_ptr<llama>> llamas;

  shared_ptr<llama> get(const string& name) const {
    return llamas.find(name)->second;
  }

  void add(shared_ptr<llama> ptr) {
    llamas.emplace(ptr->get_name(), ptr);
  }

  void buy(const string& name, Sex sex) {
    add(make_shared<llama>(name, sex));
  }

  void birth(const string& name, Sex sex,
             const string& father_name,
             const string& mother_name) {
    auto father = father_name.empty() ? nullptr : get(father_name);
    auto mother = get(mother_name);

    auto child = make_shared<llama>(
      name, sex, father, mother
    );

    add(child);
    mother->add_kid(child);
    if (father) {
      father->add_kid(child);
    }
  }

  weak_ptr<llama> observe(const string& name) const {
    return get(name);
  }

  void sell(const string& name) {
    llamas.erase(name);
  }

  void show() const {
    cout << "Herd: ";
    for (const auto& [name, p] : llamas) {
      cout << name << ' ';
    }
    cout << endl;
  }
};

int main() {

  herd h;

  h.buy("A", Sex::Male);
  h.buy("B", Sex::Female);
  h.buy("C", Sex::Female);

  h.birth("AB", Sex::Female, "A", "B");
  h.birth("_B", Sex::Male, "", "B");

  h.show();

  auto C = h.observe("C");
  h.sell("C");

  cout << boolalpha;
  cout << "C: " << C.expired() << endl;

  auto B = h.observe("B");
  h.sell("B");

  cout << "B: " << B.expired() << endl;

  h.sell("AB");
  h.sell("_B");

  cout << "B: " << B.expired() << endl;

}
