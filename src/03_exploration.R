library (tidyverse)
library (dplyr)

#Importation de nos donnees transformees
data_transf <- read.csv("data/processed/insurance_final.csv")

# Statistiques descriptives
#1. Statistique de base
summary (data_transf)
