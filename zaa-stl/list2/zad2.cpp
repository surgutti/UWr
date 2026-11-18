#include <iostream>
#include <fstream>
#include <memory>

using namespace std;

class line_writer {
public:
  line_writer(const string& filename) {
    cout << "Constructor(" << filename << ")" << endl;
    ofs.open(filename);
    if (!ofs) {
      throw runtime_error("Cannot open file");
    }
  }

  void write(const string& line) {
    ofs << line << endl;
  }

  ~line_writer() {
    cout << "Destructor()" << endl;
    ofs.close();
  }
private:
  ofstream ofs;
};

int main() {

  auto p1 = make_shared<line_writer>("plik.txt");

  {
    auto p2 = p1;
    auto p3 = p2;

    p1->write("test1");
    {
    p2->write("test2");
    }
    p3->write("test3");
  }

  p1->write("test4");

  return 0;
}
