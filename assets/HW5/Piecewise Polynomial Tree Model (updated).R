##############################
# Piecewise Polynomial Trees #
##############################
# Author: Zihan Zhang

## Note: For simplicity, code for plotting have been omitted.

# data generation
for (i in 1:2) {
  x1 <- runif(500,min = -1,max = 1)
  x2 <- runif(500,min = -1,max = 1)
  y <- -x1^2-x2^2+2+rnorm(500,mean = 0,sd = 0.02)
  if(i==1)
    trset <- data.frame(y,x1,x2)
  else
    teset <- data.frame(y,x1,x2)
}


# Trees
library(rpart)
library(rpart.plot)
set.seed(123)
fit.tree = rpart(y~x1+x2,trset,model = F,control=rpart.control(cp=0))
printcp(fit.tree)
plotcp(fit.tree)
fit.tree= prune(fit.tree,
                cp=fit.tree$cptable[which.min(fit.tree$cptable[,"xerror"]),"CP"])
rpart.plot(fit.tree,type = 2)
y.treehat <- predict(fit.tree,teset)

fit.tree.error <- sum((y.treehat-teset$y)^2)/500
fit.tree.error 
# [1] 0.3102634 (My result)


# Piecewise linear model
library(splines)
library(AER)

fit1 <- lm(y ~ bs(x1,knots = c(-0.5,0,0.5),degree = 1)+bs(x2,knots = c(-0.5,0,0.5),degree = 1),data = trset)

y.hat <- predict(fit1,teset)
fit.hat.error <- sum((y.hat-teset$y)^2)/500
fit.hat.error
# [1] 0.001103903


# # combination
library(dplyr)
leaf1 <- subset(trset,(x1 < -0.83)&(x2< - 0.62))
leaf2 <- subset(trset,(x1 < -0.83)&(x2>= 0.69))
leaf3 <- subset(trset,(x1 < -0.83)&(x2< 0.69)&(x2>= - 0.62))
leaf4 <- subset(trset,(x1 >= 0.91))
leaf5 <- subset(trset,(x1 < 0.91)&(x1>= 0.56)&(x2< -0.65))
leaf6 <- subset(trset,(x1 < 0.91)&(x1>= 0.56)&(x2>= 0.54))
leaf7 <- subset(trset,(x1 < 0.91)&(x1>= 0.56)&(x2< 0.54)&(x2>= -0.65))
leaf8 <- subset(trset,(x1 >= -0.83)&(x1< 0.56)&(x2< -0.82))
leaf9 <- subset(trset,(x1 >= -0.83)&(x1< 0.56)&(x2>= 0.57)&(x1< -0.38))
leaf10 <- subset(trset,(x1 >= -0.83)&(x1< 0.56)&(x2>= 0.57)&(x1>= -0.38))
leaf11 <- subset(trset,(x1 >= -0.83)&(x1< 0.56)&(x2>= -0.82)&(x2< -0.49))
leaf12 <- subset(trset,(x1 >= -0.83)&(x1<= -0.56)&(x2>= -0.49))
leaf13 <- subset(trset,(x1 >= 0.31)&(x1<0.56)&(x2>= 0.097)&(x2< 0.57))
leaf14 <- subset(trset,(x1 >= 0.31)&(x1<0.56)&(x2>= -0.49)&(x2< 0.097))
leaf15 <- subset(trset,(x1 >= -0.56)&(x1<0.31)&(x2>= 0.49)&(x2< 0.57))

fitc1 <- lm(y~x1+x2,data = leaf1)
fitc2 <- lm(y~x1+x2,data = leaf2)
fitc3 <- lm(y~x1+x2,data = leaf3)
fitc4 <- lm(y~x1+x2,data = leaf4)
fitc5 <- lm(y~x1+x2,data = leaf5)
fitc6 <- lm(y~x1+x2,data = leaf6)
fitc7 <- lm(y~x1+x2,data = leaf7)
fitc8 <- lm(y~x1+x2,data = leaf8)
fitc9 <- lm(y~x1+x2,data = leaf9)
fitc10 <- lm(y~x1+x2,data = leaf10)
fitc11 <- lm(y~x1+x2,data = leaf11)
fitc12 <- lm(y~x1+x2,data = leaf12)
fitc13 <- lm(y~x1+x2,data = leaf13)
fitc14 <- lm(y~x1+x2,data = leaf14)
fitc15 <- lm(y~x1+x2,data = leaf15)

leaf1 <- subset(teset,(x1 < -0.83)&(x2< - 0.62))
leaf2 <- subset(teset,(x1 < -0.83)&(x2>= 0.69))
leaf3 <- subset(teset,(x1 < -0.83)&(x2< 0.69)&(x2>= - 0.62))
leaf4 <- subset(teset,(x1 >= 0.91))
leaf5 <- subset(teset,(x1 < 0.91)&(x1>= 0.56)&(x2< -0.65))
leaf6 <- subset(teset,(x1 < 0.91)&(x1>= 0.56)&(x2>= 0.54))
leaf7 <- subset(teset,(x1 < 0.91)&(x1>= 0.56)&(x2< 0.54)&(x2>= -0.65))
leaf8 <- subset(teset,(x1 >= -0.83)&(x1< 0.56)&(x2< -0.82))
leaf9 <- subset(teset,(x1 >= -0.83)&(x1< 0.56)&(x2>= 0.57)&(x1< -0.38))
leaf10 <- subset(teset,(x1 >= -0.83)&(x1< 0.56)&(x2>= 0.57)&(x1>= -0.38))
leaf11 <- subset(teset,(x1 >= -0.83)&(x1< 0.56)&(x2>= -0.82)&(x2< -0.49))
leaf12 <- subset(teset,(x1 >= -0.83)&(x1<= -0.56)&(x2>= -0.49))
leaf13 <- subset(teset,(x1 >= 0.31)&(x1<0.56)&(x2>= 0.097)&(x2< 0.57))
leaf14 <- subset(teset,(x1 >= 0.31)&(x1<0.56)&(x2>= -0.49)&(x2< 0.097))
leaf15 <- subset(teset,(x1 >= -0.56)&(x1<0.31)&(x2>= 0.49)&(x2< 0.57))

y.hat.c1 <- predict(fitc1)
y.hat.c2 <- predict(fitc2)
y.hat.c3 <- predict(fitc3)
y.hat.c4 <- predict(fitc4)
y.hat.c5 <- predict(fitc5)
y.hat.c6 <- predict(fitc6)
y.hat.c7 <- predict(fitc7)
y.hat.c8 <- predict(fitc8)
y.hat.c9 <- predict(fitc9)
y.hat.c10 <- predict(fitc10)
y.hat.c11 <- predict(fitc11)
y.hat.c12 <- predict(fitc12)
y.hat.c13 <- predict(fitc13)
y.hat.c14 <- predict(fitc14)
y.hat.c15 <- predict(fitc15)

fit.c.error <- (sum(y.hat.c1-leaf1$y)+sum(y.hat.c2-leaf2$y)+sum(y.hat.c3-leaf3$y)+sum(y.hat.c4-leaf4$y)+sum(y.hat.c5-leaf5$y)+
                  sum(y.hat.c6-leaf6$y)+sum(y.hat.c7-leaf7$y)+sum(y.hat.c8-leaf8$y)+sum(y.hat.c9-leaf9$y)+sum(y.hat.c10-leaf10$y)+
                  sum(y.hat.c11-leaf11$y)+sum(y.hat.c12-leaf12$y)+sum(y.hat.c13-leaf13$y)+sum(y.hat.c14-leaf14$y)+
                  sum(y.hat.c15-leaf15$y))^2/500
fit.c.error
# 0.005494581

