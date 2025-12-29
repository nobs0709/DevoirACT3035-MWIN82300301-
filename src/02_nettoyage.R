library(dplyr)
library(tidyverse)

#Extraction 
data <- read.csv("data/raw/insurance_claims.csv")

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
#Apres avoir visionner data_selection, on remarque des "?" 
#dans les observation du variable Collision_type
#Je veux faire le nottoyage des ?
data_selection$collision_type[data_selection$collision_type == "?"] <- NA
#Gestion des valeurs manquantes
data_selection <- data_selection %>%
   na.omit()
#D'apres ce qu'on a vu en cours, j'ai
#utiliser la methode na.omit() pour faire
#le nettoyage des valeurs manquantes
#Ca va supprimer directement les observations contenant les valeurs
#manquantes

#Verification de notre nettoyage
view(data_selection)

#Traitement des valeurs aberrantes
#Je vais me fixer un seuil du cout de reclamation 
#Je vais choisir arbitrairement le seuil du 95e percentile
seuil_reclamation <- quantile(data_selection$total_claim_amount, 0.95)

# sur chaque cout total reclamation superieur au seuil
#il sera considere comme valeur aberrante et R va le rejeter
# Donc, on a :
data_selection <- data_selection %>%
  filter(total_claim_amount <= seuil_reclamation)

# Création de nouvelles variables

data_selection <- data_selection %>%
  mutate(
    haute_reclamation = ifelse(total_claim_amount > 10000, 1, 0),
    jeune_conducteur = ifelse(age < 25, 1, 0)
  )

# Probabilité de réclamation par type d’incident
Taux_fraude <- data_selection %>%
  group_by(incident_type) %>%
  summarise(prob_reclam = mean(fraud_reported == "Y"))

#Joindre la nouvelle variable a notre data de base
data_selection <- left_join(data_selection, Taux_fraude, by = "incident_type")

#Verifions que les nouvelles variables sont dans
#notre jeu de donnees
head(data_selection)

#Transformation des variables de type caractere en facteur
data_selection <- data_selection %>% 
  mutate(across(where(is.character), as.factor))
