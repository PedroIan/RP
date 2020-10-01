
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

dimensaoFinal<-2

rotulos <- NULL
for(i in 1:nrow(faces) ) {
  rotulos <- c( rotulos, ((i-1) %/% 10) + 1 )
}

#for (i in 1:nrow(faces)){
#  MostraImagem( faces[i,])
#}

points <- matrix(0, nrow=nrow(faces), ncol=dimensaoFinal)
for (i in 1:nrow(faces)){
  
  singleImage <- matrix( faces[i,], nrow=64 )
  pcaResult <- meuPCA(singleImage, dimensaoFinal)
  
  
  newData <- singleImage %*% pcaResult[[2]]
  newData[is.na(newData)] <- 0
  points[i,] <- colSums(newData, na.rm = TRUE) / nrow(newData)
  
}

for(i in 1:ncol(points)) {
  points[,i] <- points[,i] - mean(points[,i])
}

newConfusionMatrix <- matrix(0, ncol = 40, nrow= 40)
acuracia <- NULL

for(i in 1:10) {
  trainIndex <- createDataPartition(points[,1], p=0.5, list=FALSE)
  
  #trainCopy <- data.frame(par = points[trainIndex,], class = factor(rotulos[trainIndex]))
  #trainCopy[is.na(trainCopy)] <- 0
  
  trainCopy <- data.frame(par = faces[trainIndex,], class = factor(rotulos[trainIndex]))
  
  #testDf <- data.frame(par = points[-trainIndex,], class = factor(rotulos[-trainIndex]))
  #testDf[is.na(testDf)] <- 0
  
  testDf <- data.frame(par = faces[-trainIndex,], class = factor(rotulos[-trainIndex]))
  
  
  modelNB <- naiveBayes(class ~ ., data = trainCopy, laplace = 0, na.action = na.pass)
  
  predictions <- predict(modelNB, testDf)
  cMatrix <- confusionMatrix(predictions, testDf$class)
  newConfusionMatrix <- newConfusionMatrix + cMatrix$table
  
  acuracia <- c( acuracia, as.numeric(cMatrix$overall[[1]]) )
}

mean(acuracia)
sd(acuracia)

write.csv(newConfusionMatrix, file = "confusionMatrix.csv")
print('Matriz salva!')

indexesAll <- c(1:10,41:50,81:90,121:130)
plot(abs(points[,1]), abs(points[,2]), col=cores[rotulos])


