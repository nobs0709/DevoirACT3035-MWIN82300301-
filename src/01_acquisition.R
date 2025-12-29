library(dplyr)
library(tidyverse)


getwd()
setwd("C:/Users/Santi/OneDrive/Documents/DevoirACT3035-MWIN82300301-/")

#Importation de notre jeu de données:
data <- read.csv("data/raw/insurance_claims.csv", stringsAsFactors = FALSE)

#Verification des colonnes et des premières observations:
colnames(data)
head(data)