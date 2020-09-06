library('mlbench')
library(ggplot2)
library(caret)
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
saida <- factor(y, levels=c(0,1), labels = c('1','2'))

yLength <- length(y)
allIndexes <- 1:yLength

nFolds <- 10
eachFoldLength <- floor(yLength/nFolds)

foldsIndexes <- matrix(0, nrow=eachFoldLength, ncol = nFolds)

for(i in 1:nFolds){
  newIndexes <- allIndexes[1:eachFoldLength]
  foldsIndexes[,i] <- newIndexes
  allIndexes <- allIndexes[-(1:eachFoldLength)]
}

foldsTreinamentoIndexes <- foldsIndexes[1:floor(eachFoldLength*0.75),]
foldsTestesIndexes <- foldsIndexes[-foldsTreinamentoIndexes,]
dados <- as.data.frame(dados)

saidaTreinamento <- factor(y[foldsTreinamentoIndexes[,1]])

model <- train(dados[foldsTreinamentoIndexes[,1],], saidaTreinamento, 'nb', trControl=trainControl(method='cv',number=10) )








#dados <- cbind(dados,y)

#for(i in 0:(nFolds - 1)) {
 # folds[i + 1] <- dados[(i*eachFoldLength + 1):((i + 1)*eachFoldLength),]
  
#}


#classifier <- naiveBayes(dados, y)

#newdata <- as.data.frame(dados)

#a <- predict(classifier, newdata)