# Rapport Final de mon projet
Ici je vais montrer en resume ce a quoi consister mon projet et ce qui a ete fait 

## Détection de la fraude en assurance automobile

1. Introduction

La fraude en assurance automobile représente un enjeu financier important pour les compagnies d’assurance. Elle engendre des pertes directes, augmente les coûts opérationnels et peut mener à une hausse des primes pour l’ensemble des assurés.  
Dans un contexte actuariel, il est donc essentiel de développer des modèles statistiques capables de **détecter et prédire les réclamations frauduleuses** à partir des données disponibles.  
Ce travail pratique vise à réaliser un projet complet de science des données actuarielles, allant de l’acquisition des données jusqu’à la comparaison de modèles prédictifs, en utilisant le langage **R**.

2. Acquisition des données

Le jeu de données utilisé provient de la plateforme **Kaggle** et concerne des réclamations d’assurance automobile.  
Les données ont été téléchargées manuellement à partir du lien suivant :  
https://www.kaggle.com/datasets/buntyshah/auto-insurance-claims-data/data  
Le fichier original a été conservé dans le dossier `data/raw` afin de préserver l’intégrité des données brutes avant toute transformation.

3. Processus ETL (Extraction, Transformation, Chargement)
 3.1 Extraction
   Les données ont été importées dans R à l’aide de la fonction `read.csv()` à partir du dossier `data/raw`.

 3.2 Transformation
Plusieurs étapes de nettoyage et de transformation ont été réalisées :

- sélection des variables pertinentes pour l’analyse actuarielle ;
- remplacement des valeurs `"?"` par des valeurs manquantes (`NA`) ;
- suppression des observations contenant des valeurs manquantes à l’aide de `na.omit()` ;
- traitement des valeurs aberrantes du montant des réclamations en utilisant le **95e percentile** comme seuil ;
- création de variables dérivées, notamment :
- indicateur de haute réclamation ;
- indicateur de jeune conducteur ;
- transformation des variables catégorielles en facteurs ;
- conversion de la variable cible `fraud_reported` en variable binaire (0 = non frauduleuse, 1 = frauduleuse).

3.3 Chargement

Les données nettoyées et transformées ont été sauvegardées dans le dossier `data/processed`.  
Une séparation des données en ensembles d’entraînement (80 %) et de test (20 %) a également été effectuée pour la modélisation.

 4. Analyse exploratoire des données
Une analyse exploratoire a été réalisée afin de mieux comprendre la structure des données et d’identifier d’éventuels problèmes.

Analyses effectuées :
- statistiques descriptives globales ;
- calcul de la moyenne et de l’écart-type du montant des réclamations ;
- tableaux de fréquences pour les variables catégorielles ;
- proportion de réclamations frauduleuses ;
- visualisations :
- histogramme et densité du montant total des réclamations ;
- boxplots du montant des sinistres selon le type d’incident ;
- analyse de corrélation entre l’âge et le montant des réclamations ;
- graphique de la répartition des cas de fraude.

Cette analyse met en évidence un **déséquilibre important entre les cas frauduleux et non frauduleux**, ce qui est donc un défi pour la modélisation.

5. Définition du problème actuariel
Le problème actuariel étudié consiste à **prédire la probabilité qu’une réclamation soit frauduleuse**, à partir des informations disponibles sur :
- le profil de l’assuré ;
- les caractéristiques du contrat ;
- la nature et la gravité du sinistre.

D’un point de vue actuariel, ce type de modélisation permet :
- d’identifier les facteurs de risque liés à la fraude ;
- de prioriser les dossiers à analyser ;
- de réduire les pertes financières associées aux réclamations frauduleuses.

La variable réponse étant binaire, des modèles de type **GLM** sont particulièrement adaptés.

6. Modélisation actuarielle

Deux modèles ont été estimés :

6.1 Régression logistique
La régression logistique est un modèle classique en actuariat pour la prédiction d’événements binaires.  
Elle permet :
- d’estimer la probabilité de fraude ;
- d’interpréter facilement l’impact des variables explicatives.
Un coefficient positif indique une augmentation du risque de fraude, tandis qu’un coefficient négatif indique une diminution du risque.

6.2 Modèle GLM

Le modèle Probit est une autre forme de GLM utilisant une fonction de lien différente.  
Il permet également d’analyser l’influence des variables explicatives sur la probabilité de fraude, tout en offrant une approche légèrement différente de la régression logistique.

7. Comparaison des modèles

Les deux modèles ont été évalués à l’aide des données de test.
Observations principales :
- la régression logistique prédit majoritairement des réclamations non frauduleuses, ce qui reflète la rareté des cas de fraude ;
- le modèle Probit détecte correctement plusieurs cas de fraude tout en conservant une bonne reconnaissance des dossiers honnêtes.

Critère de comparaison

Le critère **AIC ** a été utilisé pour comparer les modèles.  
Un AIC plus faible indique un meilleur compromis entre la qualité d’ajustement et la complexité du modèle.

Modèle retenu
La **régression logistique** a été retenue comme modèle final car :
- elle présente un AIC plus faible ;
- elle est plus simple à interpréter ;
- elle est mieux adaptée à une utilisation actuarielle opérationnelle.

8. Implications pratiques

Les résultats obtenus peuvent être utilisés par une compagnie d’assurance pour :
- cibler les réclamations à risque élevé ;
- optimiser les ressources dédiées à la détection de la fraude ;
- réduire les pertes financières ;
- améliorer les processus internes de gestion des sinistres.
  
9. Limites et améliorations possibles

Limites :
- taille limitée de l’échantillon ;
- déséquilibre important entre les classes.

Biais potentiels :
- erreurs possibles dans l’identification des fraudes ;
- variables explicatives incomplètes.

Améliorations possibles :
- ajout de variables historiques sur les assurés ;
- ajustement du seuil de classification
  
10. Conclusion

Ce travail a permis de mettre en pratique les concepts vus en laboratoire d’actuariat à travers un projet complet de modélisation.  
Les modèles GLM se sont révélés pertinents pour l’analyse de la fraude, tout en soulignant les défis liés aux événements rares.
