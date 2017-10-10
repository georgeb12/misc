#Define a target gradation
Target.Gradation  = c(100, 82, 47, 35,  4.0)

#Define the gradations of our stock materials
CA.75             = c(100, 45,  6,  5,  2.0)
CA.375            = c(100,100, 30,  7,  2.0)
Man.Sand          = c(100,100, 97, 70,  4.0)
Natural.Sand      = c(100,100, 97, 82,  0.4)

#Create a matrix of the stock material gradations
(Blend.Matrix = cbind(CA.75,CA.375,Man.Sand,Natural.Sand))
row.names(Blend.Matrix) = c("1/2","3/8",4,8,200) #Sieve sizes

#Solve for the ideal blend proportions
answer = solve(t(Blend.Matrix) %*% Blend.Matrix) %*% 
  t(Blend.Matrix) %*% Target.Gradation

#Normalize to 100%
(answer = answer/sum(answer))
sum(answer)

#Check to see that the actual blend matches target
(Actual.Blend = Blend.Matrix %*% answer)
cat("\r\n",
  sprintf("Sieve %3s : %3.2f \r\n",
        row.names(Blend.Matrix),
        Actual.Blend)
)


#####
#Define a target gradation
Target.Gradation  = c(100, 82, 47, 35,  4.0)

#Define the gradations of our stock materials
CA.75             = c(100, 45,  6,  5,  2.0)
CA.375            = c(100,100, 30,  7,  2.0)
Man.Sand          = c(100,100, 97, 70,  4.0)
Natural.Sand      = c(100,100, 97, 82,  0.4)
Breakdown         = c(100,100,100,100, 97.0)

#Create a matrix of the stock material gradations
(Blend.Matrix = cbind(CA.75,CA.375,Man.Sand,Natural.Sand,Breakdown))
row.names(Blend.Matrix) = c("1/2","3/8",4,8,200) #Sieve sizes

#Solve for the ideal blend proportions
answer = solve(t(Blend.Matrix) %*% Blend.Matrix) %*% 
  t(Blend.Matrix) %*% Target.Gradation

#Normalize to 100%
(answer = answer/sum(answer))
sum(answer)

#Check to see that the actual blend matches target
(Actual.Blend = Blend.Matrix %*% answer)
cat("\r\n",
    sprintf("Sieve %3s : %3.2f \r\n",
            row.names(Blend.Matrix),
            Actual.Blend)
)

##New blend
#Create a matrix of the stock material gradations
(New.Blend.Matrix = cbind(CA.75,CA.375,Natural.Sand,Breakdown))
row.names(New.Blend.Matrix) = c("1/2","3/8",4,8,200) #Sieve sizes

#Solve for the ideal blend proportions
answer = solve(t(New.Blend.Matrix) %*% New.Blend.Matrix) %*% 
  t(New.Blend.Matrix) %*% Target.Gradation

#Normalize to 100%
(answer = answer/sum(answer))
sum(answer)

#Check to see that the actual blend matches target
(New.Actual.Blend = New.Blend.Matrix %*% answer)
cat("\r\n",
    sprintf("Sieve %3s : %3.2f \r\n",
            row.names(New.Blend.Matrix),
            New.Actual.Blend)
)

##User-input
Blend.Matrix %*% c(.33,.30,0,.345,.025) ##Too much natural sand

