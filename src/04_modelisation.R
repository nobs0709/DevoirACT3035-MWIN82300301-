#Etape:Modelisation
library (tidyverse)
library (dplyr)

#Importation des donnees:
data_transf <- read.csv("data/processed/insurance_final.csv")
head(data_transf)

#Definition variable a predire
y <- data_transf$fraud_reported
head(y)

#Je fais ce choix par logique, on a besoin de prédire si une réclamation
#est frauduleuse. Je trouve que les autres variables sont des causes 
#potentielles

#Definition variables explicatives
x <- data_transf %>%
  select(age, insured_sex, policy_state, policy_csl,
         incident_type, incident_severity, collision_type,
         authorities_contacted, total_claim_amount)
head(x)

# J'ai choisi ces variables parce qu'elles décrivent le profil de l’assuré ainsi que 
# les caractéristiques du contrat et le type d’incident; exactement ce dont on a besoin 
# pour determiner le montant de reclamation

#L’objectif de la modélisation est d’identifier 
#et de prédire les réclamations frauduleuses 
#à l’aide des informations disponibles sur les sinistres et les assurés.