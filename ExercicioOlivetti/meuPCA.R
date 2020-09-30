

meuPCA <- function( xIn, nDimensoesFinal ) {
  
  xMedias <- colMeans(xIn)
  xNormalizado <- xIn - xMedias
  
  S <- cov(xNormalizado)
  
  decomposicao <- eigen(S)
  
  randomColumns <- sample.int(ncol(decomposicao$vectors), nDimensoesFinal)
  vectors <- matrix(0, ncol=nDimensoesFinal, nrow = nrow(decomposicao$vectors))
  
  for (i in 1:length(randomColumns)) {
    vectors[,i] <- decomposicao$vectors[,i]
  }
  
  return(list(decomposicao$values, vectors))
}