
rm(list = ls())
library(mlbench)
library(e1071)
library(SparseM)
require(caret)
require(ks)
data(BreastCancer) 

db<- na.omit(BreastCancer) 

X<- data.matrix(db[,2:10])
y<- data.matrix(db[,11])

y[y == 'benign']<- -1 
y[y == 'malignant']<- 1 
y <- as.numeric(y)

for (i in 1:nrow(X)) {
  a <- prcomp(X[i,])
  
}

trainIndex <- createDataPartition(y, p=0.7, list=FALSE)

a <- data.frame(X, y)


todosOsComponentes <- prcomp(X)
b <- a$center

X <- todosOsComponentes$x

svmModel <- svm(X[trainIndex,], y[trainIndex], const = 1, kernel = "radial", tolerance = 0.001, epsilon = 0.1, cross = 10)

asd <- y[-trainIndex]
predictions <- predict(svmModel, X[-trainIndex,])
yhat <- predictions

yhat[yhat > 0] <- 1
yhat[yhat < 0] <- -1 

confusionMatrix(factor(yhat), factor(y[-trainIndex]))

ordenado <- var(X[,1])
