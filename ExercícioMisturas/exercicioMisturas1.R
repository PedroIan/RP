library('mlbench')
source('kMeans.R')
library('plot3D')
library('rgl')

library(MASS)

p<-mlbench.spirals(1000,cycles=1, sd=0.05)
x <- p[[1]]
classes <- as.numeric(p[[2]])

nClusters <- 2
cores <- rainbow(nClusters)

allWithClasses <- cbind(x, classes)
diferentes <- matrix(0, nrow = nClusters)

plot(x[,1],x[,2], col = cores[classes], xlim = c(-1.5,1.5), ylim = c(-1.5,1.5), xlab='x', ylab='y')


nfolds <- 10

teste1 <- allWithClasses[sample(nrow(allWithClasses), 3, replace=TRUE),]