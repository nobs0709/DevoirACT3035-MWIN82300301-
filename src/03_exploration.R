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



