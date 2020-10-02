
rm(list = ls())
library(mlbench)
library(e1071)
library(SparseM)
require(caret)
require(ks)
data(BreastCancer) 

db <- na.omit(BreastCancer) 

# --------------------- Converting Data to Matrix
X <- data.matrix(db[,2:10])
y <- data.matrix(db[,11])

y[y == 'benign'] <- -1 
y[y == 'malignant'] <- 1 
y <- as.numeric(y)

# ---------------------

trainIndex <- createDataPartition(y, p=0.7, list=FALSE)

# --------------------- Variâncias de todos os componentes

todosOsComponentes <- prcomp(X)

variancias <- NULL
quantidadeDeComponentes <- ncol(todosOsComponentes$x)
for (i in 1:quantidadeDeComponentes) {
  variancias <- c(variancias, var(todosOsComponentes$x[,i]))
}

plot(c(1:quantidadeDeComponentes), variancias)

# ---------------------

pca2D <- prcomp(X, rank. = 2)

X <- pca2D$x

trainIndex <- createDataPartition(y, p=0.7, list=FALSE)

svmModel <- svm(X[trainIndex,], y[trainIndex], const = 1, kernel = "radial", tolerance = 0.001, epsilon = 0.1, cross = 10)

asd <- y[-trainIndex]
predictions <- predict(svmModel, X[-trainIndex,])
yhat <- predictions

yhat[yhat > 0] <- 1
yhat[yhat < 0] <- -1 

confusionMatrix(factor(yhat), factor(y[-trainIndex]))

ordenado <- var(X[,1])
