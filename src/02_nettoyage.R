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
