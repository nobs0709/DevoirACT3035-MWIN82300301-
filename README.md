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

Les variables de type caractère ont été converties en facteurs

La variable cible fraud_reported a été transformée en variable binaire :
1 pour reclamation frauduleuse
0 pour reclamation honnête

Après, Le jeu de données final nettoyé et transformé a été sauvegardé dans le dossier data/processed de notre fichier depot
Les données ont été séparées en :
80 % pour l’entraînement
20 % pour le test
Cette séparation permettra d’évaluer la performance des modèles sur des données non utilisées lors de l’estimation.

## Etape 3 : Analyse exploratoire des données

Dans cette étape, l’objectif est de mieux comprendre les données nettoyées avant de passer à la modélisation. 
L’analyse exploratoire permet d’identifier la structure des variables, de repérer des tendances générales et d’avoir une première idée des liens possibles avec la fraude.
Les données utilisées ici proviennent du fichier transformé insurance_final.csv, obtenu après l’étape de nettoyage et de transformation puis après importer via 
le fichier deta/processed

Les librairies tidyverse, dplyr et ggplot2 sont utilisées pour la manipulation et la visualisation des données.

1.Statistiques descriptives
Une première analyse descriptive est réalisée afin d’avoir une vue d’ensemble du jeu de données :
Des statistiques de base (minimum, maximum, moyenne, médiane, quartiles) sont obtenues à l’aide de la fonction summary().
La moyenne et l’écart-type du montant total des réclamations sont calculés pour mesurer la dispersion.
Des tableaux de fréquences sont produits pour certaines variables catégorielles comme :
  la gravité de l’incident (incident_severity)
  le sexe de l’assuré (insured_sex)
  La proportion de fraudes est également calculée afin d’évaluer le déséquilibre éventuel entre les classes.

2.Visualisations graphiques

Plusieurs graphiques sont réalisés pour illustrer les résultats de l’analyse exploratoire :
  - Histogramme et courbe de densité du montant total des réclamations
     Ce graphique permet d’observer la distribution des coûts de réclamation et de vérifier si celle-ci est asymétrique.

  -Boxplot du montant des sinistres par type d’incident
      Ce graphique met en évidence les différences de montants de réclamation selon le type d’incident et permet d’identifier d’éventuelles valeurs extrêmes.

 -Analyse de corrélation
     Une matrice de corrélation est construite entre l’âge de l’assuré et le montant total des réclamations.
     Le graphique de corrélation permet d’évaluer visuellement l’intensité et le sens du lien entre ces variables numériques.

  -Répartition des sinistres frauduleux
    Un diagramme en barres montre le nombre de cas frauduleux et non frauduleux, ce qui permet de visualiser la distribution de la variable cible.

3.Conclusion de l’analyse exploratoire
 Cette analyse exploratoire permet de :
  * mieux comprendre la distribution des variables clés,
  * identifier des différences selon les types d’incidents,
  * observer la proportion de fraude dans le jeu de données.

Ces résultats servent de base pour la modélisation statistique, notamment avec des modèles de type régression logistique ou GLM.

## Etape 4: Modélisation
