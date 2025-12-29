# DevoirACT3035-MWIN82300301-

## Description TP ACT3035 LABORATOIRE EN ACTUARIAT

Ce dépôt contient mon travail concernant le TP du cours Laboratoire et Actuariat.
Dans ce travail seul le langage R a été utilisé
Ce projet a pour objectif de faire une analyse acturielle d'un jeu de données collectées sur un des sites proposées afin de construire des modèles prédictifs pertinents.
Les étapes seront celles-ci:
1.Acquisition des données
2.processuss ETL
3.Analyse Exploratoire
4.Definition du problème actuariel
5.Modélisation
6.Comparaison et Interpretation des resultats
7.discussion des limites

## Etape 1: Acquisition des donnees
Les données utilisées dans ce projet ont étés collectées sur le site web des données ouvertes Kaggle.
Mon jeu de données choisi est appelé "Insurance_claims"; vous pouvez y acceder direct via 
le [lien](https://www.kaggle.com/datasets/buntyshah/auto-insurance-claims-data/data).
Les données ont été téléchargées manuellement à partir de la plateforme Kaggle. Le fichier CSV a ensuite été placé dans le dossier data/raw afin de conserver les données brutes avant toute transformation.
Mon jeu de données contient 1000 observations et contient 1000 observations.

## Etape 2 : processus ETL
Cette étape vise à préparer les données brutes pour l’analyse et la modélisation en appliquant un processus ETL rigoureux : extraction, transformation et chargement.
D'abord j'ai fait l'importation de mon jeu de données à partir du fichier CSV conservé dans le dossier data/raw.
Mon jeu de données a beaucoup de variables mais pour faciliter l'analyse actuairlle, j'ai fait une sélection des variables les plus pertinentes entre autres:
age,insured_sex, policy_state, policy_csl, incident_type, incident_severity, collision_type, authorities_contacted, total_claim_amount, fraud_reported

Lors de l’exploration des données, la variable collision_type contenait des valeurs "?", interprétées comme des valeurs manquantes.
Ces valeurs ont été remplacées par NA.
Ensuite, la méthode na.omit() a été utilisée afin de supprimer les observations contenant des valeurs manquantes.
Cette approche a été choisie conformément aux notions vues en cours, pour garantir un jeu de données complet avant la modélisation.

Les valeurs aberrantes ont été traitées à l’aide d’un seuil basé sur le 95e percentile du montant total des réclamations (total_claim_amount).
Toute observation dépassant ce seuil a été exclue du jeu de données.
Ce choix permet de limiter l’influence des réclamations extrêmement élevées sur les modèles.

Deux nouvelles variables ont été créées afin d’enrichir l’analyse actuarielle :
haute_reclamation : indicateur binaire égal à 1 si le montant total dépasse 10 000 $
jeune_conducteur : indicateur binaire égal à 1 si l’âge est inférieur à 25 ans
De plus, une variable représentant la probabilité de fraude par type d’incident a été calculée et ajoutée au jeu de données.
