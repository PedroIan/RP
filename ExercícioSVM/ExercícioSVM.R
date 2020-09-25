library('mlbench')
library('kernlab')
library(caret)
library(ks)

source('kMeans.R')
library('plot3D')
library('rgl')

library(MASS)

cores <- rainbow(3)

p<-mlbench.spirals(1000,cycles=1, sd=0.05)
x <- p$x
y <- as.numeric(p$classes)

trainIndex <- createDataPartition(y, p=0.8, list=FALSE)

plot(x[,1],x[,2], col = cores[y], xlim = c(-1,1), ylim = c(-1,1), xlab='x', ylab='y')

minErro <- 10

svmtreinBest <- ksvm(x[trainIndex,],y[trainIndex],type='C-bsvc',kernel='rbfdot',kpar=list(sigma=0.23),C=44) 

# O FOR A SEGUIR ENCONTRA, POR MEIO DE TENTATIVA E ERRO, OS MELHORES VALORES PARA SIGMA E C
# USADOS NO TREINAMENTO SVM.

#for(sigmaValue in seq(0.05, 0.5, 0.01)){
#  for(cValue in seq(5, 50, 1)) {
#    
#    svmtrein <- ksvm(x[trainIndex,],y[trainIndex],type='C-bsvc',kernel='rbfdot',kpar=list(sigma=sigmaValue),C=cValue)
#  
#    predict(svmtrein, x[-trainIndex,], type = "response", coupler = "minpair")
#  
#    a <- error(svmtrein)
#    
#    if(minErro > a) {
#      svmtreinBest <- svmtrein
#      minErro <- a
#      
#      print('Sigma')
#      print(sigmaValue)
#      print('C')
#      print(cValue)
#      
#    }
#  }
    

  
#}

# FIM DO FOR

erro <- error(svmtreinBest)
suport <- SVindex(svmtreinBest)
seqx1x2 <- seq(-2, 2, 0.1)
lseq <- length(seqx1x2)
MZ <- matrix(0, nrow = lseq, ncol = lseq)
cr <- 0

for (i in 1:lseq) {
  for(j in 1:lseq) {
    cr <- cr + 1
    x1 <- seqx1x2[i]
    x2 <- seqx1x2[j]
    x1x2 <- matrix((cbind(x1, x2)), nrow = 1)
    MZ[i, j] <- predict(svmtrein, x1x2, type = "response", coupler = "minpair")
  }
}
par(new = TRUE)
plot(x[suport,1],x[suport,2], col = cores[3], xlim = c(-1,1), ylim = c(-1,1), xlab='x', ylab='y')
par(new = TRUE)
contour(seqx1x2, seqx1x2, MZ, nlevels = 1, xlim = c(-1, 1), ylim = c(-1, 1))

persp3D(seqx1x2,seqx1x2,MZ,counter=T,theta = 55, phi = 30, r = 40,d = 0.1, expand = 0.5, ltheta = 90, lphi = 180, shade = 0.4,ticktype = 'detailed', nticks=5)
