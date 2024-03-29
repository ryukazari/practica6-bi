################## KNN ################
#Cargar datos
#setwd("C:/Users/rogger.maita/Desktop")
data <- read.csv("Pregunta4R.csv")
head(data)
summary(data)

#Dividir entrenamiento y Prueba
set.seed(322)
test <- 1:5
train.data <- data[-test,]
test.data <- data[test,]

#Creaci�n de FACTOR
data$ofrece_seguro <- factor(data$ofrece_seguro)
train.def <- data$ofrece_seguro[-test]
test.def <- data$ofrece_seguro[test]

library(class)
knn.2 <- knn(train.data, test.data, train.def, k=2)
knn.5 <- knn(train.data, test.data, train.def, k=5)
knn.10 <- knn(train.data, test.data, train.def, k=10)

#Resultado
cm <- as.matrix(table(Actual = test.def, Predicted = knn.5))
sum(diag(cm))/length(test.def) #0.4
cm <- as.matrix(table(Actual = test.def, Predicted = knn.2))
sum(diag(cm))/length(test.def) #0.2
cm <- as.matrix(table(Actual = test.def, Predicted = knn.10))
sum(diag(cm))/length(test.def) #0.2



##################NAIVE BAYES################
# NAIVE BAYES
library(e1071)
library(naivebayes)
library(caret)
data.nb <- data

set.seed(322)
train.ids <-createDataPartition(data.nb$ofrece_seguro, p=0.70, list=F)
mod <- naiveBayes(ofrece_seguro~.,data = data.nb[train.ids,])
mod
pred <- predict(mod, data.nb[-train.ids,])
tab <- table(data.nb[-train.ids,]$ofrece_seguro, pred, dnn = c("Acutal", "Predicha"))
confusionMatrix(tab) #Accuracy: 0.8571

################## SVM ################
library(caret) #divisiones de conjuntos de datos
library(e1071)

data.svm <- data
data.svm$ofrece_seguro = factor(data.svm$ofrece_seguro)
set.seed(322)
t.ids <- createDataPartition(data.svm$ofrece_seguro, p=0.7, list=F)
mod <- svm(ofrece_seguro ~ ., data = data.svm[t.ids,])
table(data.svm[t.ids,"ofrece_seguro"], fitted(mod), dnn=c("Actual", "Predicho"))
pred1 <- predict(mod, data.svm[-t.ids,])
tab1 <- table(data.svm[-t.ids, "ofrece_seguro"], pred, dnn=c("Actual", "Predicho"))
confusionMatrix(tab1) #Accuracy: 0.8571
