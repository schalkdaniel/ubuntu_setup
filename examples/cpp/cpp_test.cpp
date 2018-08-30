// Compile with:
// g++ cpp_test.cpp -I/usr/include/RcppArmadillo -o test
// ./test

#include <armadillo>

int main () {

  arma::mat X(4, 4, arma::fill::zeros);
  unsigned int rows = X.n_rows;
  unsigned int cols = X.n_cols;

  double sum = arma::accu(X);

  std::cout << "X has " << rows << " rows and " << cols << " cols. The sum over all is " << sum << std::endl;

  return 0;
}