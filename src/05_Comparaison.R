#Etape Comparaison
library (tidyverse)
library (dplyr)

#Séparation éventuelle en ensembles d'entraînement et de test
set.seed(123)
taille <- nrow(data_selection)
indice_repartition <- sample(1:taille, size=floor(.8 * taille))
data_train <- data_selection[indice_repartition, ]
data_test <- data_selection[-indice_repartition, ]