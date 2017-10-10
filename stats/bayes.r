# STA 630 Advanced Biostatistics
# With Dr. Bob Downer
# Assignment 3
# 
# 28 March 2016
# 
# Paul Egeler
# 
# Calcualting the posterior probabilities
# of three thetas given 10 coin flips resulting in 2 heads.
# 

theta = c(.25,.5,.75)
priors = c(.3,.4,.3)
z = 2
n = 10

likelihood = theta^z * (1-theta)^(n-z)

evidence = sum(likelihood*priors)

(posteriors = likelihood * priors / evidence)

plot(density(posteriors), main = "posteriors", xlim=0:1)

for (i in c("priors","likelihood","posteriors")) 
  plot(x=theta, y=get(i), 
       type="h", 
       main = i, 
       xlim=0:1, ylim=0:1, 
       xlab="theta", 
       ylab="probability")

