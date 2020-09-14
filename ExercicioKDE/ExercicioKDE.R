library('mlbench')
require(caret)
require(ks)

p <- mlbench.spirals(1000,cycles=1, sd=0.05)

entrada <- p$x
allData <- cbind(entrada, as.numeric(p$classes))

nFolds <- 10
flds <- createFolds(allData, k = 10, list = TRUE, returnTrain = FALSE)

class1 <- allData[which(allData[,3] %in% 1),]
class2 <- allData[which(allData[,3] %in% 2),]

teste11 <- kde(class1[,1], h=0.1)
teste12 <- kde(class1[,2], h=0.1)
teste21 <- kde(class2[,1], h=0.1)
teste22 <- kde(class2[,2], h=0.1)

plot(teste11, col=1, xlim=c(-1,1), ylim=c(0,1))
par(new=T)
plot(teste12, col=2, xlim=c(-1,1), ylim=c(0,1))
par(new=T)
plot(teste21, col=3, xlim=c(-1,1), ylim=c(0,1))
par(new=T)
plot(teste22, col=4, xlim=c(-1,1), ylim=c(0,1))

colnames(allData, do.NULL = FALSE, prefix = "col")

trainIndex <- createDataPartition(allData[,3], p=0.8, list=FALSE)

trains <- allData[trainIndex,]
tests <- allData[-trainIndex,]

trainCopy <- data.frame(par = trains[,1:2], class = factor(trains[,3]))
trainCopy$class <- as.factor(trainCopy$class)

testDf <- data.frame(par = tests[,1:2], class = factor(tests[,3]))

modelNB <- train(class ~ par.1, data = trainCopy,
                method = "nb",
                preProcess = c("center", "scale"),
                tuneLength = 10, 
                trControl = trainControl(method="repeatedcv", number=10, repeats=10))

predictions <- predict(modelNB, testDf)

print(confusionMatrix(predictions, testDf$class))