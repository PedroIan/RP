
rm(list = ls())
require(RnavGraphImageData)
require(OpenImageR)
library(ggfortify)
require(caret)
require(ks)

data(faces)
faces <- t(faces)
cores <-rainbow(50)

MostraImagem <- function( x ) {
  rotate <- function(x) t( apply(x, 2, rev) )
  img <- matrix( x, nrow=64 )
  cor <- rev( gray(50:1/50) )
  image( rotate( img ), col=cor )
}

fBordas = matrix(c(-1,-1,-1,-1,8,-1,-1,-1,-1), nrow = 3, ncol = 3)
fLinhasVerticais = matrix(c(1,2,1,0,0,0,-1,-2,-1),nrow=3, ncol = 3)
fLinhasHorizontais = matrix(c(1,0,-1,2,0,-2,1,0,-1),nrow=3, ncol = 3)
fSharpen = matrix(c(0,-1,0,-1,5,-1,0,-1,0),nrow=3, ncol = 3)

MostraImagem(faces[377,])
Sys.sleep(5)

conv <- convolution(matrix( faces[377,], nrow=64 ), fBordas)
MostraImagem(conv)
Sys.sleep(5)

conv <- convolution(matrix( faces[377,], nrow=64 ), fLinhasVerticais)
MostraImagem(conv)
Sys.sleep(5)

conv <- convolution(matrix( faces[377,], nrow=64 ), fLinhasHorizontais)
MostraImagem(conv)
Sys.sleep(5)

conv <- convolution(matrix( faces[377,], nrow=64 ), fSharpen)
MostraImagem(conv)

#for (i in 1:nrow(faces)){
#  MostraImagem( faces[i,])
#}

