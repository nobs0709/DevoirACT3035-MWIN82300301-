library()

#Importation de notre jeu de données:
data <- read.csv("data/raw/insurance_claims.csv", stringsAsFactors = FALSE)

#Verification des colonnes et des premières observations:
head(data)
colnames(data)
