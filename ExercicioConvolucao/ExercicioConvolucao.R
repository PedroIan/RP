
rm(list = ls())
require(RnavGraphImageData)
require(OpenImageR)
library(ggfortify)
require(caret)
require(ks)

data(faces)
faces <- t(faces)
cores <-rainbow(50)

MostraImagem <- function( x, cols = 64 ) {
  rotate <- function(x) t( apply(x, 2, rev) )
  img <- matrix( x, nrow=cols )
  cor <- rev( gray(50:1/50) )
  image( rotate( img ), col=cor )
}

applyReLU <- function ( x ) {
  retVariable <- matrix(0, nrow = nrow(x), ncol = ncol(x))
  
  for(i in 1:nrow(x)) {
    for(j in 1:ncol(x)) {
      if(x[i,j] > 0) {
        retVariable[i,j] <- x[i,j]
      }
    }
  }
  
  return(retVariable)
}

applyMaxPooling <- function ( x ) {
  linhas <- seq(1, nrow(x) - 1, by = 2)
  colunas <- seq(1, ncol(x) - 1, by = 2)
  
  retVariable <- matrix(0, nrow = length(linhas), ncol = length(colunas))
  
  for(i in linhas) {
    for(j in colunas) {
      retVariable[i - floor(i/2),j - floor(j/2)] <- max(x[i:i+1,j:j+1])
    }
  }
  
  return(retVariable)
}

face <- faces[377,]
max(face)

fBordas = matrix(c(-1,-1,-1,-1,8,-1,-1,-1,-1), nrow = 3, ncol = 3)

MostraImagem(faces[377,])
Sys.sleep(5)

conv <- convolution(matrix( face, nrow=64 ), fBordas)
MostraImagem(conv, ncol(conv))
Sys.sleep(5)

convReLU <- applyReLU(matrix( face, nrow=64 ))
MostraImagem(convReLU, ncol(convReLU))
Sys.sleep(5)

convMaxPool <- applyMaxPooling(matrix( face, nrow=64 ))
MostraImagem(convMaxPool, ncol(convMaxPool))
Sys.sleep(5)

convReLUFiltered <- applyReLU(conv)
MostraImagem(convReLUFiltered, ncol(convReLUFiltered))
Sys.sleep(5)

convMaxPoolFiltered <- applyMaxPooling(conv)
MostraImagem(convMaxPoolFiltered, ncol(convMaxPoolFiltered))
Sys.sleep(5)

conv <- convolution(matrix( face, nrow=64 ), fSharpen)
MostraImagem(conv)

#for (i in 1:nrow(faces)){
#  MostraImagem( faces[i,])
#}

