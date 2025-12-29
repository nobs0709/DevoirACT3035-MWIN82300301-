library (tidyverse)
library (dplyr)

#Importation de nos donnees transformees
data_transf <- read.csv("data/processed/insurance_final.csv")

# Statistiques descriptives

#1. Statistique de base
summary (data_transf)
#2.Mesures de dispersion pour le montant des réclamations
mean_reclam <- mean(data_transf$total_claim_amount)
sd_reclam <- sd(data_transf$total_claim_amount)
