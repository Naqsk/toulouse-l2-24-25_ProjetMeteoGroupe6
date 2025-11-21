# toulouse-l2-24-25_ProjetMeteoGroupe6

README.md : Projet Extracteur Météo
Ce projet est un script Shell robuste et automatisé (Extracteur_Météo.sh) conçu pour collecter, traiter et archiver les données météorologiques de manière périodique, en utilisant le service public wttr.in.

I. Vue d'Ensemble et Fonctionnalités Clés

Ce script répond aux exigences du projet en couvrant toutes les versions (V1, V2, V3) et en intégrant plusieurs variantes.

A. Architecture du Script
Source de Données : Utilise curl pour interroger wttr.in.
Traitement : Emploie des outils Unix classiques (grep, sed, awk, etc.) pour l'extraction des données à partir de la sortie texte brute de wttr.in.
Sorties Multiples : Gère la sortie de base, l'archivage quotidien et la sérialisation JSON.

B. Fonctionnalités Implémentées

Version / Variante
Description de la Fonctionnalité
V1 (Script de Base)
Récupération de la température actuelle et des prévisions du lendemain.
V2.1 (Automatisation)
Gestion d'une ville par défaut (Toulouse) si l'argument est manquant.
V3 (Historique)
Archivage quotidien des données dans un fichier horodaté (meteo_YYYYMMDD.txt).
Var. 1 (Enrichissement)
Ajout de données supplémentaires (Vent, Humidité, Visibilité) au format de sortie.
Var. 2 (Format)
Génération d'une sortie structurée au format JSON.
Var. 3 (Stabilité)
Gestion des erreurs de connexion à wttr.in avec horodatage dans un fichier de log (meteo_error.log)


II. Mise en Œuvre et Exécution

A. Prérequis

Assurez-vous d'être dans un environnement UNIX/Linux classique.

B. Lancement

La syntaxe d'exécution est simple. Le script détecte automatiquement la ville à cibler.

# Utilise la ville par défaut (Toulouse)
./Extracteur_Météo.sh

# Cible une ville spécifique
./Extracteur_Météo.sh Paris

C. Automatisation : Tâche Cron ( V2.2 )

Pour une collecte de données périodique, configurez une tâche cron.
Ouvrez l'éditeur crontab :

crontab -e


Ajoutez votre tâche (Exemple : Exécution toutes les 30 minutes) :
*/30 * * * * /chemin/absolu/vers/Extracteur_Météo.sh "Ville_Souhaitée"


III. Formats de Sortie

Le script produit trois fichiers pour valider les différentes exigences de formatage et d'archivage.

A. Format Texte Standard (meteo.txt & meteo_YYYYMMDD.txt)

Ce format est utilisé pour le rapport de base et l'archivage historique. Il inclut toutes les données enrichies.
Structure :
[Date] - [Heure] - [Ville] : Température Actuelle=[T_act], Température Lendemain=[T_demain], Vent=[Vitesse], Humidité=[Taux], Visibilité=[Distance]
Exemple :
2025-11-20 - 21:12 - Toulouse : Température Actuelle=+15°C, Température Lendemain=+19°C, Vent=10 km/h, Humidité=75%, Visibilité=10 km

B. Format JSON (meteo_YYYYMMDD.json)

Une sortie sérialisée pour faciliter l'intégration avec d'autres systèmes ou pour l'analyse statistique.

{
  "date": "2024-09-24",
  "heure": "14:30",
  "ville": "Paris",
  "temperature_actuelle": "18°C",
  "temperature_demain": "Pluie légère",
  "vent": "15 km/h",
  "humidite": "70%",
  "visibilite": "10 km"
}

IV. Suivi de Projet et Stabilité

A. Log des Erreurs (meteo_error.log)

La robustesse est assurée par un système de journalisation des erreurs. Toute interruption de connexion ou échec de curl est tracé avec un horodatage précis.
Exemple d'entrée :
2025-11-20 21:12:35 - Erreur de connexion à wttr.in pour Paris lors de l'exportation des données brutes

B. Conventions Git

Le projet suit des conventions de versionnement strictes.
Commits : Des commits fréquents sont encouragés pour chaque nouvelle fonctionnalité ou session de travail.
Tags : Chaque version majeure du projet est marquée par un tag Git pour un suivi clair de la progression (e.g., v1.0, v2.0, v3.0).
Branches : L'utilisation de branches est encouragée pour le développement de fonctionnalités spécifiques. Puis toutes les versions et variantes one étés push dans le main.

