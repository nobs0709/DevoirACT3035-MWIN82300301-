#Etape: Analyse Exploratoire
library (tidyverse)
library (dplyr)
library (ggplot2)

#Importation de nos donnees transformees
data_transf <- read.csv("data/processed/insurance_final.csv")

# Statistiques descriptives

#1. Statistique de base
summary (data_transf)
#2.Mesures de dispersion pour le montant des réclamations
mean_reclam <- mean(data_transf$total_claim_amount)
sd_reclam <- sd(data_transf$total_claim_amount)
# 3. Tableaux de fréquences pour les variables catégorielles
table(data_transf$incident_severity)
table(data_transf$insured_sex)
# Proportion de fraude
prop.table(table(df$fraud_reported))

#VISUALISATIONS : AJOUT GRAPHIQUES
#1.Histogramme et Densité du montant des réclamations
ggplot(data_transf, aes(x = total_claim_amount)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "white") +
  geom_density(alpha = 0.2, fill = "red") +
  labs(title = "Distribution du montant total des réclamations"
       , x = "Montant", y = "Densité")

# 2. Boxplot du montant des sinistres par type d'incident
ggplot(data_transf, aes(x = incident_type, y = total_claim_amount)) +
  geom_boxplot(fill = "green") +
  labs(title = "Montant des sinistres par type d'incident",
       x = "Type d'incident",
       y = "Montant du sinistre")

#3. Graphique de Correlation
#Pour ce graphique on aura besoin de la matrice de correlation
data_numeric <- data_transf[, c("age", "total_claim_amount")]
matrix_corr <- cor(data_numeric, use="complete.obs")

#Visionnement du graphique
install.packages("ggcorrplot")
library(ggcorrplot)
ggcorrplot(matrix_corr,
           type = "lower", 
           lab = TRUE,
           title = "Corrélation age vs claim_amount")

#4. Graphique Repartition Fraude
ggplot(data_transf, aes(x = fraud_reported)) +
  geom_bar(fill = "brown") +
  labs(title = "Répartition des sinistres frauduleux",
       x = "Fraude signalée",
       y = "Nombre de cas")
