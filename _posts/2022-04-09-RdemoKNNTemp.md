---
layout: post
title: "R code - Predict temperature with a KNN"
date:   2022-04-09 23:59:59
categories: Code_notebook
---

# R code - Predict temperature with a KNN

Use KNN to fit the temperature variation in China. 

Features: longitude, latitude, elevation.

Tuned with `caret` packet, parallel allowed.



```R

rm(list = ls())
library(haven)
library(kknn)
library(caret)
library(randomForest)
library(ranger)
library(doParallel)
set.seed(233)

cl <- makeCluster(12)
registerDoParallel(cl)
sample <- read_stata("station_train_sample.dta")
PredSample <- read_stata('countyElevLoc.dta')
year <- sample$year
content <- c()
MSE_content <- matrix(data = NA, nrow = 25)
names <- c()
count = 0
for (t in c(1990:2014)) {
  count = count+1
  id <- year == t
  yrsample <- sample[id,c(2:5)]
  tr <- createDataPartition(yrsample$temp,p = 0.85,list =F)
  trainSp <- yrsample[tr,]
  testSp <- yrsample[-tr,]
  
  control <- trainControl(method = "repeatedcv",number = 5,repeats = 3)
  knnGrid <- expand.grid(kmax = c(1:10),distance = c(0.5,0.8,1,1.2,1.5,1.8,2,2.5,3,3.5,5)
                         ,kernel = 'optimal')
  fit <- train(temp~., data = trainSp,
                method = "kknn",
                trControl = control,
                preProcess = c('center','scale'),
                tuneGrid = knnGrid,
                verbose = T,
                allowParallel = T
  )
  fitvalue <- predict(fit,newdata = testSp)

  png(filename = paste('year_',t,'.png',sep = ""))
  plot(fitvalue, testSp$temp,xlim = c(-10,30),ylim = c(-10,30),xlab = "Predicted value",ylab = "True Value",main = t)
  lines(c(-10:30),c(-10:30),col = 'red')
  dev.off()
  
  value <- predict(fit,newdata = PredSample)
  content <- cbind(content,value)
  MSE_content[count,] <- sum((fitvalue- testSp$temp)^2)/length(fitvalue)
  names = c(names,paste('year_',t,sep = ""))
}
colnames(content) <- names
out = cbind(PredSample,content)
write_dta(data = out,path = "CountyTemp.dta")

```

