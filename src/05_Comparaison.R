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

#Interpretation :
#Pourquoi avoir choisi ce modele: 
#J'ai choisie ce modele car je le trouve mieux adapté predire la variable reponse cad 
#prédire si une réclamation est frauduleuse ou non. Elle est simple à mettre en œuvre, rapide,
#et surtout permet d’interpréter les coefficients, càd de comprendre comment chaque
# variable explicative influence la probabilité de fraude reported.

#Interpertation resultat modele RegLog:
#Apres avoir fait le summary du modele j'ai pu voir les coefficients de chaque
#variable explicative qui infulence comme on l'a dit la probabilite de fraude
#Brievement ce que je peux dire, un coefficient negatif signifie reduit le risque
#de fraude tandisque un coefficient positif augmente le risque de fraude

#Interpretation resultat predits: 
#Quand j'ai effectue un test du modele sur le jeu du test, il a predit 
#presque toutes les reclamations comme non frauduleuses car presque toute 
#probabilite de fraude est proche de 0; Ca ne veut pas dire que le modele 
#n'est pas correct ou n'a pas marche ca veut tout simplement dire ca montre
#que les fraudes sont très rares dans les données et
#que le modèle initial avait trop de variables, 
#ce qui l’empêche de distinguer les rares cas de fraude.

#2. GLM
modele_glm <- glm(fraud_reported ~ ., 
                  data = data_transf, family = binomial(link = "probit"))
summary(modele_glm)

#Interpretation :
#Pourquoi avoir choisi ce modele: 
# J'ai choisie ce modele car il permet à la fois de prédire 
# et de comprendre l’influence de chaque variable.
# Idéal quand on veut savoir quelles caractéristiques augmentent
# la probabilité d’un événement, pas juste prédire.

#Test de notre modele
y_predit <- predict(model_glm, newdata = x_test, type = "response")
y_pred_class <- ifelse(y_pred, 1, 0)
y_pred_class
head(y_predit)
summary(proba_fraude)
prediction <- ifelse(y_pred_class >= 0.3, 1, 0)

table(
  Réel = y_test,
  Prédit = prediction
)

#Interpretation resultat predit:
#D'apres les resultats nous pouvons bien voir que le modele glm joue bien
#un role de detecteur il a bien detecter et avec le test reel et avec prediction
#42 cas de fraude cad le modèle glm reconnaît bien les dossiers honnêtes, 
#mais il rate encore quelques fraudes, ce qui montre que nos variables 
#sont utiles mais pas parfaites.

#Comparaison de modele_RegLog et modele_glm
summary(modele_regLog)
summary(modele_glm)

# Choix modele:
#malgre que le modele GLM est bon detecteur,
#Je choisis le modele Regression lineaire parce que comme nous pouvons le voir dans 
#les resultats son AIC est 745.18 tandisqu'il est de AIC: 609.06
#Le modèle avec l’AIC le plus faible est préféré, 
#car il équilibre mieux la qualité d’ajustement et la simplicité.
#De plus les resultats du modele GLM sont un peu complexe a interpreter