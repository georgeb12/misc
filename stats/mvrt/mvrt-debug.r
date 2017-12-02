# Install packages used for debugging -------------------------------------

pkgs <- c("Rcpp", "RcppArmadillo", "MASS", "microbenchmark", "mvtnorm")

install.missing.pkgs <- function(pkgs) {
  missing.pkgs <- !pkgs %in% installed.packages()[,1]
  
  if (length(missing.pkgs)) {
    cat("Installing: ", pkgs[missing.pkgs], sep = "\n")
    install.packages(pkgs[missing.pkgs])
  }
}

install.missing.pkgs(pkgs)

# Setting up global variables ---------------------------------------------

mu = c(5,4)
R = matrix(c(1,.9,.9,1),2,2)
V_sqrt = matrix(c(sqrt(2.5),0,0,sqrt(2)),2,2)
S = V_sqrt %*% R %*% V_sqrt
g = chol(S)
n = 30


# Defining function for mvrtR ---------------------------------------------

mvrtR <- function(n, mu, S) {
  
  g <- chol(S)
  
  bivMat = matrix(0,2,n)
  for (i in 1:n) bivMat[,i] = mu + g %*% rt(2,n-1)
  t(bivMat)
  
}

# Load in cpp mvrt function -----------------------------------------------

Rcpp::sourceCpp("mvrt/mvrt.cpp")

# Comparing the distributions of various techniques -----------------------

get_cor_dist <- function(FUN, times, ..., seed = 999) {
  
  set.seed(seed)
  
  FUN <- match.fun(FUN)
  
  my_call <- as.call(list(FUN, ...))
  
  out <- numeric(times)
  
  for (i in seq_len(times)) {
    
    out[i] <- cor(eval(my_call))[2]
    
  }
  
  out
  
}

mvrtR_dist <-   get_cor_dist(mvrtR, 100, n, mu, S)
mvrt_dist <-    get_cor_dist(mvrt, 100, n, mu, S)  
MASS_dist <-    get_cor_dist(MASS::mvrnorm, 100, n, mu, S)
mvtnorm_dist <- get_cor_dist(mvtnorm::rmvt, 100, n, S)

summary(mvrtR_dist)
summary(mvrt_dist)
summary(MASS_dist)
summary(mvtnorm_dist)

# Benchmarking ------------------------------------------------------------

# I know colon operator will slow down the two functions
microbenchmark::microbenchmark(
  mvrtR(n, mu, S),
  mvrt(n, mu, S),
  MASS::mvrnorm(n, mu, S),
  mvtnorm::rmvt(n,S) + mu
)
  