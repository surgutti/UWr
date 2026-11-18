#include <iostream> 
#include <chrono> 
#include <random> 
#include <array>
#include <iomanip>

using namespace std; 

mt19937 rng(234234); 

template <int N> 
using Matrix = array<array<double, N>, N>; 

template <int N> 
Matrix<N> multiply(const Matrix<N>& A, const Matrix<N>& B) { 
  Matrix<N> C;
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      C[i][j] = 0.0;
      for (int k = 0; k < N; k++) {
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }
  return C;
} 

template <int N> 
Matrix<N> random_matrix() {
  Matrix<N> M;
  uniform_real_distribution<double> dist(0.5, 2.0);
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      M[i][j] = dist(rng);
    }
  }
  return M; 
} 

template <int N>
void test_matrix(int iterations) {
  auto M = random_matrix<N>();
  
  double dummy_sum = 0.0; 

  auto start = chrono::high_resolution_clock::now(); 

  for (int iter = 0; iter < iterations; iter++) { 
    auto M2 = multiply<N>(M, M); 
    dummy_sum += M2[0][0];
  } 
  
  auto finish = chrono::high_resolution_clock::now(); 

  chrono::duration<int, ratio<1, 1000>> elapsed_ms = 
    chrono::duration_cast<chrono::duration<int, ratio<1, 1000>>>(finish - start);
  // auto elapsed_ms = chrono::duration_cast<chrono::milliseconds>(finish - start); 
  
  chrono::duration<double, ratio<60>> elapsed_min = finish - start; 

  int ms_per_iter = elapsed_ms.count() / iterations;
  double min_per_iter = elapsed_min.count() / iterations;

  cout << "=== Macierz " << N << "x" << N << " ===" << endl;
  cout << "elapsed_ms:  " << ms_per_iter << " ms" << endl; 
  cout << "elapsed_min: " << fixed << setprecision(3) << min_per_iter << " min" << endl; 
  cout << "test: " << dummy_sum << "\n\n";
}

int main() { 
  constexpr int ITER = 30;

  test_matrix<50>(ITER);
  test_matrix<100>(ITER);
  test_matrix<200>(ITER);

  return 0; 
}
