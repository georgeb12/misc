#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
mat mvrt(int n, vec mu, mat S) {
  
  mat x(mu.size(), n);
  mat g = chol(S);

  for (int i=0; i < n; i++)
  {
    vec rand = as<vec>(rt(mu.size(),n-1));
    x.col(i) = mu + g * rand;
  }
  
  return x.t();
}


/*** R
n <- 30
mu <- c(5,4)
R <- matrix(c(1,.9,.9,1),2,2)
V_sqrt <- sqrt(diag(c(2.5,2)))
S <- V_sqrt %*% R %*% V_sqrt

cor(mvrt(n,mu,S)) # Don't like how it's not really close to R

# Compare with MASS
cor(MASS::mvrnorm(n,mu,S))
*/
