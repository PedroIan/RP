rm(list = ls())
require(RnavGraphImageData)
source('meuPCA.R')
library(ggfortify)
library(mlbench)

data(faces)
faces <- t(faces)

a<-mlbench.2dnormals(200)

MostraImagem <- function( x ) {
  rotate <- function(x) t( apply(x, 2, rev) )
  img <- matrix( x, nrow=64 )
  cor <- rev( gray(50:1/50) )
  image( rotate( img ), col=cor )
}

dimensaoFinal<-2

points <- matrix(0, nrow=nrow(faces), ncol=dimensaoFinal)
for (i in 1:nrow(faces)){
  
  MostraImagem( faces[i,])
  
  singleImage <- matrix( faces[i,], nrow=64 )
  Sys.sleep(3)
  #pcaResult <- meuPCA(singleImage, dimensaoFinal)
  #points[i,] <- singleImage %*% pcaResult[[2]]
  
}

rotulos <- NULL
for(i in 1:nrow(faces) ) {
  rotulos <- c( rotulos, ((i-1) %/% 10) + 1 )
}


