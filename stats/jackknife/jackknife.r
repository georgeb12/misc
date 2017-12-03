##############################################
#
#  STA 630-01 Advanced Biostatistics
#   with Dr. Bob Downer
#   Jackknife demo
#
#  STA630jackknife.R
#
#  Paul Egeler
#    24 Feb 2016
#
##############################################
options( 
  digits = 3, 
  prompt = "R: ", 
  stringsAsFactors = F,
  repos = structure(c(CRAN="http://cran.mtu.edu/"))
)

#Reproducibility
set.seed(999)

#############
##  Loading bootstrap package
#############
if (!require(bootstrap)) {
  install.packages("bootstrap", dependencies = TRUE)
  library("bootstrap")
}

#############
##  Look at the guts of the calculations
#############
jackknife

#############
##  Define some test vectors
#############

vector1 = rnorm(10,5,1) #Random normal
vector2 = rlnorm(10,1,1) # Random log-normal

#############
##  Call the jackknife() fx
#############

#Mean is an unbiased estimator of mu
jackknife(vector1,mean)
jackknife(vector2,mean)

#Variance is an unbiased estimator of sigma^2
jackknife(vector1,var)
jackknife(vector2,var)

#Standard deviation is not an unbiased estimator of sqrt(sigma^2)
#Since sqrt is a concave fx, we expect an underestimate
jackknife(vector1,sd)
jackknife(vector2,sd)

###############################################
# law -- Law school data from Efron and Tibshiran
###############################################
# The law school data.  A random sample of size n = 15
# from the universe of 82 USA law schools.
# Two measurements: LSAT (average score on a national law test) and
# GPA (average undergraduate grade-point average).
# law82 contains data for the whole universe of 82 law schools.
#
#   This example was done in SAS docs
#
###############################################

data(law)
law

#Again, we look at unbiased estimator of variance
# (using df as denominator)
var(law$LSAT)
(df.correction = jackknife(law$LSAT,var)$jack.bias)
var(law$LSAT) - df.correction


#But if variance is calculated with n rather than df,
#it becomes biased (See Bessel's correction)
var2 = function(x) var(x)*(length(x)-1)/length(x)

var2(law$LSAT)
(n.correction = jackknife(law$LSAT,var2)$jack.bias)
var2(law$LSAT) - n.correction #compare with var(law$LSAT)

#We see that we have gotten the unbiased estimate for variance
#by applying a correction to a biased statistic

####
# Other uses for jackknife resampling
# includes residual analysis
####
require(MASS)

### Creating a bivariate normal data set of n=[whatever i feel like]

#Set mu
mu = c(5,4)

#Make correlation matrix
R = matrix(c(1,.9,.9,1),2,2)

#Transform to covariance matrix.
V_sqrt = matrix(c(sqrt(2.5),0,0,sqrt(2)),2,2)
S = V_sqrt %*% R %*% V_sqrt

set.seed(999)
bivMat <- MASS::mvrnorm(30, mu, S)

# Add some outliers
bivMat[1:nrow(bivMat) %% 15 == 0,1] <- bivMat[1:nrow(bivMat) %% 15 == 0,1] + 3

####Plot our data set. Outliers are in red.
plot(bivMat)
points(bivMat[1:nrow(bivMat) %% 15 == 0,],col=2)

####Build a linear model and look at residuals.

model = lm(bivMat[,2]~bivMat[,1])

residuals = model$residuals
standardized.residuals = stdres(model)
jack.residuals = studres(model)

#Now we plot
#we will use row number as x so we can identify our "outliers"
plot(residuals, ylim = c(-4,4))
points(standardized.residuals, col=2)
points(jack.residuals, col=3)
#See how much the jackknife residuals stand out?


#In case you want to save the data for analysis in that OTHER software
#write.csv(bivMat,row.names = FALSE,file = "bivariate.csv")
