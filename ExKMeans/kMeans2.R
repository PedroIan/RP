library('mlbench')
source('kMeans.R')

p<-mlbench.spirals(1000,cycles=1, sd=0.05)
x <- p[[1]]
#classes0 <- matrix(0, length(x[,1]) /2)
#classes1 <- matrix(1, length(x[,1]) /2)

#y <- rbind(classes0, classes1)
#x <- cbind(x, y)

nClusters <- 20

retList <- kMeans(nClusters, x, 100)

centrosClusters <- retList[[1]]
pontosClusterizados <- retList[[2]]

cores <- rainbow(nClusters)

for(i in 1:nClusters){
  pointsToPlot <- pontosClusterizados[pontosClusterizados[,3] == i,]
  plot(pointsToPlot[,1],pointsToPlot[,2],col = cores[i], xlim = c(-1.5,1.5), ylim = c(-1.5,1.5), xlab='x', ylab='y')
  par(new=T)
}

#plot(p)