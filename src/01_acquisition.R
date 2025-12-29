library(dplyr)
library(tidyverse)


getwd()
setwd("C:/Users/Santi/OneDrive/Documents/DevoirACT3035-MWIN82300301-/")

#Importation de notre jeu de données:
data <- read.csv("data/raw/insurance_claims.csv", stringsAsFactors = FALSE)

#Verification des colonnes et des premières observations:
colnames(data)
head(data)



#Selection des variables necessaires
data_selection <- data %>%je 
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
view(data_selection)


#Gestion des valeurs manquantes

data_selection <- data_selection %>%
  filter(!is.na(total_claim_amount))

#Traitement des valeurs aberrantes
seuil_reclamation <- quantile(data_selection$total_claim_amount, 0.99)
data_selection <- data_selection %>%
  filter(total_claim_amount <= seuil_reclamation)

#Création de variables dérivées simples
data_selection <- data_selection %>%
  mutate(
    haute_reclamation = ifelse(total_claim_amount > 10000, 1, 0),      
    jeune_conducteur = ifelse(age < 25, 1, 0)                        
  )

# probabilité de réclamation par type d’incident:

Taux_fraude <- data_selection %>%
  group_by(incident_type) %>%
  summarise(prob_reclam = mean(fraud_reported == "Y"))

#Jointure de la nouvelle variable a notre jeu de donnees:

data_selection <- left_join(data_selection, Taux_fraude, by = "incident_type")

# Chargement 
dim(data_selection)
summary(data_selection$total_claim_amount)
head(data_selection)


# Statistiques descriptives 

summary(data_selection$age)
summary(data_selection$total_claim_amount)
table(data_selection$insured_sex)
table(data_selection$policy_state)
table(data_selection$fraud_reported)

#Visualisation 
# Histogramme du montant des sinistres 

ggplot(data_selection, aes(x = total_claim_amount)) +
  geom_histogram(binwidth = 500, fill = "red", color = "black") +
  labs(title = "Histogramme des montants de sinistre",
       x = "Montant du sinistre",
       y = "Nombre de cas")

# Boîtes à moustaches : Boxplot du montant des sinistres par type d'incident
ggplot(data_selection, aes(x = incident_type, y = total_claim_amount)) +
  geom_boxplot(fill = "green") +
  labs(title = "Montant des sinistres par type d'incident",
       x = "Type d'incident",
       y = "Montant du sinistre") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Graphique des fréquences pour fraude

ggplot(data_selection, aes(x = fraud_reported)) +
  geom_bar(fill = "brown") +
  labs(title = "Répartition des sinistres frauduleux",
       x = "Fraude signalée",
       y = "Nombre de cas")

# Correlations simples (montants vs âge)
cor(data_selection$age, data_selection$total_claim_amount, use = "complete.obs")


# Variable réponse à prédire :
# Je choisis : fraude signalée (fraud_reported)
# J'ai defini cette variable car je le trouve
# pertinent pour : la sélection des risques et tarification

y <- data_selection$fraud_reported

# Variables explicatives retenues
x <- data_selection %>%
  select(age, insured_sex, policy_state, policy_csl,
         incident_type, incident_severity, collision_type,
         authorities_contacted, total_claim_amount)

# J'ai choisi ces variables parce qu'elles décrivent le profil de l’assuré ainsi que 
# les caractéristiques du contrat et le type d’incident; exactement ce dont on a besoin 
# pour determiner le montant de reclamation.

# Objectif de la modélisation :
# 1. Prédire si une réclamation est frauduleuse ou pas
# 2. Aider à la sélection de risques et à la prévention


#Parmi les modèles citées dans l'enonce j'ai choisi d'utliser:
#Régression logistique et Modèle linéaire généralisé (GLM)

#1. Modèle Régression logistique
model_regLog <- glm(fraud_reported ~ age + insured_sex + policy_state +
                     policy_csl + incident_type + incident_severity +
                     collision_type + authorities_contacted + total_claim_amount,
                   data = data_selection, family = binomial)

summary(model_regLog)

#2. Modèle linéaire généralisé (GLM)
model_glm <- glm(total_claim_amount ~ age + insured_sex + policy_state +
                   policy_csl + incident_type + incident_severity +
                   collision_type + authorities_contacted,
                 data = data_selection, family = gaussian)

summary(model_glm)
