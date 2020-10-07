
rm(list = ls())
require(RnavGraphImageData)
source('meuPCA.R')
library(ggfortify)
require(caret)
require(ks)
library(mlbench)
library(penaltyLearning)
library(e1071)

data(faces)
faces <- t(faces)
cores <-rainbow(50)

MostraImagem <- function( x ) {
  rotate <- function(x) t( apply(x, 2, rev) )
  img <- matrix( x, nrow=64 )
  cor <- rev( gray(50:1/50) )
  image( rotate( img ), col=cor )
}

#for (i in 1:nrow(faces)){
#  MostraImagem( faces[i,])
#}

