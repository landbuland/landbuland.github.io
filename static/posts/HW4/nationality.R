#####################################
########### Nationality #############
#####################################

# install.packages("glmnet")
rm(list = ls())
library(AER)
library(mlogit)
library(glmnet)
library(nnet)

####### import data ############
ESS8_c5 <- read.csv("ESS8_c5.csv",header = T)
ESS8_c5 <- ESS8_c5[,-1]
ess <- na.omit(ESS8_c5)
n=nrow(ess)
train <- sample(n,0.8*n)
ess.tr <- ess[train,] ## Training set
ess.test <- ess[-train,] ## Test set

x <- data.frame(ess.tr[,3:148])
y <- ess.tr$cntry
x1 <- as.matrix(x)

mystats <- function(x,na.omit=F){
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  return(c(n=n,m=m,stdev=s))
}
dstats <- function(x)sapply(x,mystats)
myvars <- names(ess[3:148])
statable <- by(ess[myvars],ess$cntry,dstats)

######## Multnomial Logit Regression #######
attach(ess.tr)
mlfit <- multinom(cntry ~ . ,data = data.frame(ess.tr[,2:148]))
mlfit.yhat <- predict(mlfit, ess.test)
t1 <- table(mlfit.yhat,ess.test$cntry,dnn = c("predicted","true"))
t1
pred_accuracy_multi <- 1 - sum(diag(t1))/sum(t1)
pred_accuracy_multi
detach(ess.tr)

########## Cross validation LASSO ###########
lassofit <- glmnet(x1,y,family = "multinomial",standardize = T,nlambda = 50,alpha = 1) # example of a Lasso
# coef(lassofit)
plot(lassofit,xvar = "lambda",label = F,main = "Number of variables")
cvlassofit <- cv.glmnet(x1,y,family = "multinomial",standardize = T,alpha = 1)

coef(cvlassofit)
plot.cv.glmnet(cvlassofit,sign.lambda = 1)
plot(cvlassofit)
optimal_lambda <- cvlassofit$lambda.min
optimal_lambda

# Use the optimal lambda to fit the model
lassofit <- glmnet(x1,y,family = "multinomial",standardize = T,lambda = optimal_lambda,alpha = 1)
coef(lassofit)
lassofit.yhat <- predict(lassofit,newx = as.matrix(ess.test[,3:148]),s = optimal_lambda,type = "class")
t2 <- table(lassofit.yhat,ess.test$cntry)
t2
pred_accuracy_lasso <- 1 - sum(diag(t2))/sum(t2)
pred_accuracy_lasso

######## Cross Validation RIDGE ###########
ridgefit <- cv.glmnet(x1,y,family = "multinomial",standardize = T, alpha = 0)
optimal_lambda_ridge <- ridgefit$lambda.min
optimal_lambda_ridge
plot(ridgefit)
ridgefit.yhat <- predict(ridgefit,newx = as.matrix(ess.test[,3:148]),s = optimal_lambda_ridge,type="class")
t3 <- table(ridgefit.yhat,ess.test$cntry)
t3
pred_accuracy_ridge <- 1 - sum(diag(t3))/sum(t3)
pred_accuracy_ridge

######## cross Validation Elastic net #######
enfit <- glmnet(x1,y,family = "multinomial",standardize = T,lambda = 0.2, alpha=0.5)
en_05 <- cv.glmnet(x1,y,family = "multinomial",standardize = T, alpha=0.5)
optimal_lambda_en <- en_05$lambda.min
optimal_lambda_en 
plot(en_05)
enfit.yhat <- predict(en_05,newx = as.matrix(ess.test[,3:148]),s = optimal_lambda_en,type="class")
t4 <- table(enfit.yhat,ess.test$cntry)
t4
pred_accuracy_en <- 1-sum(diag(t4))/sum(t4)
pred_accuracy_en


