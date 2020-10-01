

meuPCA <- function( xIn, nDimensoesFinal ) {
  
  xMedias <- colMeans(xIn)
  xNormalizado <- xIn - xMedias
  
  S <- cov(xNormalizado)
  
  decomposicao <- eigen(S)
  
  randomColumns <- sample.int(ncol(decomposicao$vectors), nDimensoesFinal)
  vectors <- matrix(0, ncol=nDimensoesFinal, nrow = nrow(decomposicao$vectors))
  
  sorted <- sort(decomposicao$values, decreasing = TRUE)
  
  index1 <- match(sorted[1], decomposicao$values) 
  index2 <- match(sorted[2], decomposicao$values) 
  
  for (i in c(index1, index2)) {
    vectors[,i] <- decomposicao$vectors[,i]
  }
  
  
  return(list(decomposicao$values, vectors))
}

MostraImagem <- function( x ) {
  rotate <- function(x) t( apply(x, 2, rev) )
  img <- matrix( x, nrow=64 )
  cor <- rev( gray(50:1/50) )
  image( rotate( img ), col=cor )
}