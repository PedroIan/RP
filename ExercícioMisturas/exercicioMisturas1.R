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

plot(x[,1],x[,2], col = cores[classes], xlim = c(-1.0,1.0), ylim = c(-1.0,1.0), xlab='x', ylab='y')


nfolds <- 10

teste1 <- allWithClasses[sample(nrow(allWithClasses), 3, replace=TRUE),]
allMeanAcuracias <- array(0,1)
standardDeviation <- array(0,1)

while(TRUE) {
  acuracia <- array(0,1)
  
  
  clustersErrados <- matrix(FALSE, nrow = nClusters)
  cores <- rainbow(nClusters)
  
  retList <- kMeans(nClusters, allWithClasses, 100)
  
  centrosClusters <- retList[[1]]
  pontosClusterizados <- retList[[2]]
  
  for(i in 1:nClusters){
    pontosSelecionados <- pontosClusterizados[pontosClusterizados[,4] == i,]
    
    diferentes <- unique(pontosSelecionados[,3])
    
    if(length(diferentes) <= 1) {
      acuracia <- c(acuracia, 1)
      clustersErrados[i] <- TRUE
    } else {
      quantidade <- length(pontosSelecionados[pontosSelecionados[,3] == 1,1])
      tamanhoTotal <- length(pontosSelecionados[,1])
      razao <- quantidade/tamanhoTotal
      
      if(is.numeric(razao) & !is.na(razao)){
        if(razao < 0.5) {
          razao <- 1 - razao
        }
        
        acuracia <- c(acuracia, razao)
        if(razao > 0.90) {
          clustersErrados[i] <- TRUE
        }
      }
      
    }
  }
  
  den3d <- kde2d(pontosClusterizados[,1],pontosClusterizados[,2], lims=c(-1.0,1.0,-1.0,1.0),n=100)
  
  xResult <- den3d$x
  yResult <- den3d$y
  zResult <- matrix(0, nrow = nrow(den3d$z), ncol = ncol(den3d$z))
  
  
  dev.off(dev.list()["RStudioGD"])
  for(i in 1:nClusters){
    
    pointsToPlot <- pontosClusterizados[pontosClusterizados[,4] == i,]
    
    if(nrow(pointsToPlot) > 0){
      plot(pointsToPlot[,1],pointsToPlot[,2],col = cores[i], xlim = c(-1.0,1.0), ylim = c(-1.0,1.0), xlab='x', ylab='y')
      par(new=T)
      
      den3d <- kde2d(pointsToPlot[,1],pointsToPlot[,2], lims=c(-1.0,1.0,-1.0,1.0),n=100)
      
      #persp3D(den3d$x, den3d$y, den3d$z, counter=T, theta = 55, phi = 80, r = 40, d = 0.1, expand = 0.5, ltheta = 90, lphi = 180, shade = 0.4, ticktype = 'detailed', nticks=5)
      
      zResult <- zResult + den3d$z      
    }
  }
  plot(centrosClusters[,1],centrosClusters[,2],col = 'red',cex=4, pch=2, xlim = c(-1.0,1.0), ylim = c(-1.0,1.0), xlab='x', ylab='y')
  par(new=T)
  contour(xResult,yResult, zResult, xlim = c(-1.0,1.0), ylim = c(-1.0,1.0), xlab='', ylab='')
  
  falses <- clustersErrados[clustersErrados[] == FALSE]
  
  print(nClusters)
  
  standardDeviation <- c(standardDeviation, sd(acuracia))
  result <- sum(acuracia)/nClusters
  print(result)
  
  allMeanAcuracias <- c(allMeanAcuracias, result)
  
  if(length(falses)/length(clustersErrados) < 0.1) {
    break
  }
  nClusters <- 1 + nClusters
  
}

print('Media')
print(allMeanAcuracias)

print('Standard Deviation')
print(standardDeviation)

dev.off(dev.list()["RStudioGD"])
persp3D(xResult, yResult, zResult, counter=T, theta = 55, phi = 85, r = 100, d = 0.000001, expand = 2, ltheta = 90, lphi = 90, shade = 0.4, ticktype = 'detailed', nticks=5)
