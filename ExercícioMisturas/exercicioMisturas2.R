library('mlbench')
library('e1071')
data("BreastCancer")

dados <- BreastCancer

dados <- cbind(dados[,2],dados[,3],dados[,4],dados[,5],dados[,6],dados[,7],dados[,8],dados[,9],dados[,10])

y <- as.character(BreastCancer[,11])

for(i in 1:length(y)) {
  if(y[i] == 'benign') {
    y[i] <- 1
  } else {
    y[i] <- 2
  }
}

y <- as.numeric(y)

classifier <- naiveBayes(dados, y)