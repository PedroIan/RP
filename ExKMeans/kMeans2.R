library('mlbench')
source('kMeans.R')
library('plot3D')
library('rgl')

library(MASS)

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

den3d <- kde2d(pontosClusterizados[,1],pontosClusterizados[,2], h=1, lims=c(-1.5,1.5,-1.5,1.5))


xResult <- den3d$x
yResult <- den3d$y
zResult <- matrix(0, nrow = nrow(den3d$z), ncol = ncol(den3d$z))

for(i in 1:nClusters){
  
  pointsToPlot <- pontosClusterizados[pontosClusterizados[,3] == i,]
  
  if(nrow(pointsToPlot) > 0){
    plot(pointsToPlot[,1],pointsToPlot[,2],col = cores[i], xlim = c(-1.5,1.5), ylim = c(-1.5,1.5), xlab='x', ylab='y')
    par(new=T)
    den3d <- kde2d(pointsToPlot[,1],pointsToPlot[,2], lims=c(-1.5,1.5,-1.5,1.5))
    
    #persp3D(xResult, yResult, den3d$z, counter=T, theta = 55, phi = 80, r = 40, d = 0.1, expand = 0.5, ltheta = 90, lphi = 180, shade = 0.4, ticktype = 'detailed', nticks=5)
    
    zResult <- zResult + den3d$z
    
  }
}

persp3D(xResult, yResult, zResult, counter=T, theta = 55, phi = 85, r = 10000000000, d = 0.000001, expand = 2, ltheta = 90, lphi = 90, shade = 0.4, ticktype = 'detailed', nticks=5)
#movie3d(spin3d(axis = c(0,0,1), rpm = 10), duration=6,  type = "png")
#plot(p)