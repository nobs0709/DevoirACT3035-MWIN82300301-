#Etape Comparaison
library (tidyverse)
library (dplyr)

#Séparation éventuelle en ensembles d'entraînement et de test
x <- data_transf %>%
  select(age, insured_sex, policy_state, policy_csl,
         incident_type, incident_severity, collision_type,
         authorities_contacted, total_claim_amount)
y <- data_transf$fraud_reported
set.seed(123)
taille <- nrow(data_transf)
indice_repartition <- sample(1:taille, size=floor(.8 * taille))
x_train <- data_transf[indice_repartition, ]
x_test <- data_transf[-indice_repartition, ]
y_train <- data_transf[indice_repartition, ]
y_test <- data_transf[-indice_repartition, ]
print(paste("Dimension des données train: ", 
            paste(dim(x_train), collapse = " x ")))
print(paste("Dimension des données train: ", 
            paste(dim(x_test), collapse = " x ")))