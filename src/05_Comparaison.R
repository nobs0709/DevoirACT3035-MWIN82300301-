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
indice_repartition <- sample(1:taille, size = floor(0.8 * taille))

x_train <- x[indice_repartition, ]
x_test  <- x[-indice_repartition, ]

y_train <- y[indice_repartition]
y_test  <- y[-indice_repartition]
print(paste("Dimension des données train: ", 
            paste(dim(x_train), collapse = " x ")))
print(paste("Dimension des données train: ", 
            paste(dim(x_test), collapse = " x ")))


# Modèlisation actuarielle avec ces 2 methodes choisies:
# Régression logistique et Modèle linéaire généralisé (GLM)
#Je vais justifier un peu plus en bas pourquoi je les ai choisi
#1. Régression logistique

modele_regLog <- glm(fraud_reported ~ ., 
                     data = cbind(x_train, fraud_reported = y_train), 
                     family = binomial())
#Description de notre modele
summary(modele_regLog)

#Test de notre modele
y_predit <- predict(model_regLog, newdata = x_test, type = "response")
y_pred_class <- ifelse(y_pred, 1, 0)
y_pred_class
head(y_predit)
summary(proba_fraude)
prediction <- ifelse(y_pred_class >= 0.3, 1, 0)

table(
  Réel = y_test,
  Prédit = prediction
)