library(dplyr)
library(tidyverse)

#Je vais faire une selection des variables necessaires
#pour mon analyse 
data_selection <- data %>%
  select(
    age,
    insured_sex,
    policy_state,
    policy_csl,
    incident_type,
    incident_severity,
    collision_type,
    authorities_contacted,
    total_claim_amount,
    fraud_reported
  )

# Je vais voir si j'ai correctement mon data
# avec les variables selectionnées:
view (data_selection)

#Tranformation
#Gestion des valeurs manquantes
data_selection <- data_selection %>%
   na.omit()
#D'apres ce qu'on a vu en cours, j'ai
#utiliser la methode na.omit() pour faire
#le nettoyage des valeurs manquantes
#Ca va supprimer directement les observations contenant les valeurs
#manquantes

#Traitement des valeurs aberrantes

