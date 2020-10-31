
rm(list = ls())
library(mlbench)
library(e1071)
library(SparseM)
require(caret)
require(ks)

table = read.csv('EURUSD_D1.csv')

dadosOpen = table$Open
dadosClose = table$Close

allData = cbind(dadosOpen, dadosClose)

mediaData = rowMeans(allData)

dadosEmMatriz = matrix(0, nrow = (length(mediaData) - 101), ncol = 101)

for (i in 1:(length(mediaData) - 101)) {
  dadosEmMatriz[i,] = mediaData[i:(i + 100)]
  
  if(mediaData[i+100] > mediaData[i+99]) {
    dadosEmMatriz[i, 101] = 1
  } else {
    dadosEmMatriz[i, 101] = -1
  }
}

trainIndex <- createDataPartition(c(1:(length(mediaData)-101)), p=0.7, list=FALSE)

dadosTreinamento = dadosEmMatriz[trainIndex,]
dadosTeste = dadosEmMatriz[-trainIndex,]

dataFrame = data.frame(dadosTreinamento[,1:100], y = as.factor(dadosTreinamento[,101]))

SVMModel = svm(y ~ ., data = dataFrame, kernel = "radial", cost = 100, scale = FALSE)

tune.out=tune(svm ,y~.,data=dataFrame ,kernel ="radial", 
              ranges =list(cost=c(0.001,0.01,0.1, 1,5,10,100)))
summary(tune.out)

predictions = predict(SVMModel,dadosTeste[,1:100])

confusionMatrix(factor(predictions), factor(dadosTeste[,101]))