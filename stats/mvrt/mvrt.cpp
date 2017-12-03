#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
mat mvrt(int n, vec mu, mat S) 
{
  
  mat x(mu.size(), n);
  mat g = chol(S).t();

  for (int i=0; i < n; i++)
  {
    vec rand = as<vec>(rt(mu.size(),n-1));
    x.col(i) = mu + g * rand;
  }
  
  return x.t();
}


/*** R
message("Use 'mvrt-debug.r' to debug.")
 
# n <- 30
# mu <- c(5,4)
# R <- matrix(c(1,.9,.9,1),2,2)
# V_sqrt <- sqrt(diag(c(2.5,2)))
# S <- V_sqrt %*% R %*% V_sqrt
# 
# cor(mvrt(n,mu,S))
# 
# # Compare with MASS
# cor(MASS::mvrnorm(n,mu,S))
# 
# # and mvtnorm
# cor(mvtnorm::rmvt(n,S) + mu)
*/
