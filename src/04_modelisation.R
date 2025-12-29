library (tidyverse)
library (dplyr)

#Importation des donnees:
data_transf <- read.csv("data/processed/insurance_final.csv")
head(data_transf)

#Definition variable a predire
y <- data_transf$fraud_reported
head(y)
