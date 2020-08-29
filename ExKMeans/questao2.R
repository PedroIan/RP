source('kMeans.R')


s1 <- 0.3
s2 <- 0.3
s3 <- 0.3
s4 <- 0.3
nc <- 100

#xc1 <- matrix(rnorm( nc*2) ,ncol=2)*s1 +t(matrix(c(2 ,2) ,nrow=2,ncol=nc ))
#xc2 <- matrix(rnorm( nc*2) ,ncol=2)*s2 +t(matrix(c(4 ,4) ,nrow=2,ncol=nc ))
#xc3 <- matrix(rnorm( nc*2) ,ncol=2)*s3 +t(matrix(c(2 ,4) ,nrow=2,ncol=nc ))
#xc4 <- matrix(rnorm( nc*2) ,ncol=2)*s4 +t(matrix(c(4 ,2) ,nrow=2,ncol=nc ))

allX <- rbind(xc1, xc2, xc3, xc4)

nClusters <- 4
maxIteracao <- 12

retList <- kMeans(nClusters, allX, 10)

centrosClusters <- retList[[1]]
pontosClusterizados <- retList[[2]]

cores <- rainbow(nClusters)

for(i in 1:nClusters){
  pointsToPlot <- pontosClusterizados[pontosClusterizados[,3] == i,]
  plot(pointsToPlot[,1],pointsToPlot[,2],col = cores[i], xlim = c(1,5), ylim = c(1,5), xlab='x', ylab='y')
  par(new=T)
}