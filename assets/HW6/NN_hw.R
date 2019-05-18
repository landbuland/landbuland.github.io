###############################################################
# Neural Network for predicting nationality with IIA violated #
###############################################################

rm(list = ls())
library(AER)
library(mlogit)
library(glmnet)
library(nnet)
library(neuralnet)
# data import
setwd("/Users/zhangzihan/Documents/tex/Data Science report/HW6")

ESS8_c5 <- read.csv("ESS8_c5.csv",header = T)
ESS8_c5 <- ESS8_c5[,-1]
ess <- na.omit(ESS8_c5)
n=nrow(ess)
train <- sample(n,0.8*n)
ess.tr <- ess[train,] ## Training set
ess.test <- ess[-train,] ## Test set

x <- data.frame(ess.tr[,3:26])
x2 <- data.frame(ess.test[,3:26])
y <- ess.tr$cntry

x1 <- as.matrix(x)

# Mulitnomial 
attach(ess.tr)
mlfit <- multinom(cntry ~ . ,data = data.frame(ess.tr[,2:26]))
mlfit.yhat <- predict(mlfit, ess.test)
t1 <- table(mlfit.yhat,ess.test$cntry,dnn = c("predicted","true"))
t1
pred_accuracy_multi <- 1 - sum(diag(t1))/sum(t1)
pred_accuracy_multi
detach(ess.tr)

# HMF test
long<- mlogit.data(ess.tr[,2:148], shape="wide",  choice = "cntry")
m1 <- mFormula(cntry~ 0|netusoft+ pplfair+ trstep+ stfdem+stfedu+ mnrgtjb+ hmsacld+ aesfdrk+ eneffap+rdcenr+ dfincac + uemplwk + gvcldcr + imsclbn + vteurmmb + ipcrtiv)
mlfit2 <- mlogit(m1,long,reflevel = "FR",seed = 100)

mlfit3 <- mlogit(m1,long,alt.subset = c("FR","GB","IT"))
hmftest(mlfit2,mlfit3)

# Fit a neural network

x <- scale(x,center = T,scale = T)
x2 <- scale(x2,center = T,scale = T)
ess.tr1 <- data.frame(ess.tr$cntry,x)
ess.test1 <- data.frame(ess.test$cntry,x2)
netfit = nnet(ess.tr.cntry ~.,ess.tr1,maxit=10000, size=10,
           decay=0.195) ## the value for decay is generated from CV method.

net.hat <- predict(netfit,ess.test1,type ="class" )
t2<- table(net.hat,ess.test1$ess.test.cntry,dnn = c("predicted","true"))
t2
pred_accuracy_net <- 1 - sum(diag(t2))/sum(t2)
pred_accuracy_net


# Neural Networks Regularzation with Cross Validation.

  for (j in 1:30) {
    k=0.001+j*0.008*j
  require(nnet)
  data <- ess[,2:26]
  for (i in 1:10) {
  train <- ((i-1)/10*nrow(data)+1):((i)/10*nrow(data))
  data.tr <- data[-train,] ## Training set
  data.te <- data[train,] ## Test set
  x <- data.frame(data.tr[,2:25])
  x2 <- data.frame(data.te[,2:25])

  x <- scale(x,center = T,scale = T)
  x2 <- scale(x2,center = T,scale = T)
  data.tr1 <- data.frame(data.tr$cntry,x)
  data.te1 <- data.frame(data.te$cntry,x2)
  fit <- nnet(data.tr.cntry ~.,data.tr1,maxit=10000, size=10,
                decay=k)
  net.hat <- predict(fit,data.te1,type ="class" )
  t2<- table(net.hat,data.te1$data.te.cntry,dnn = c("predicted","true"))
  pred_accuracy_net <- 1 - sum(diag(t2))/sum(t2)
  pred_accuracy_net
  a[i]=pred_accuracy_net
  }
  b[j]=mean(a)
  }

