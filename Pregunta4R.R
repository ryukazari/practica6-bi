#libraries
library(caret)
library(pROC)
library(mlbench)

data <- str(Pregunta4)

#SPLIT DATA
set.seed(1234)
ind <- sample(2, 25, replace=T, prob=c(0.8, 0.2))
training <- data[ind == 1,]
test <- data[ind == 2,]

#KNN
trControl <- trainControl(method = "repeatedcv",
                          number=10,
                          repeats = 3)
set.seed(222)
fit <- train(admit ~ .,
             data = training,
             method = 'knn',
             tuneLength = 20,
             trControl = trControl,
             preProc = c("center", "scale"))
fit
