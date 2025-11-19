# toulouse-l2-24-25_ProjetMeteoGroupe6
Projet d’extraction d'informations météorologiques
Utilisation de cron pour automatiser l'exécution du script


1. Vérifier que cron est installé et actif

Avant de configurer cron, il est nécessaire de vérifier que le service est disponible sur le système :

sudo service cron start
sudo service cron status


Si le service est actif, vous pouvez passer à l’étape suivante.

2. Éditer la crontab

La crontab est le fichier dans lequel sont définies les tâches planifiées. Pour l’éditer, utilisez la commande suivante :

crontab -e


Lors de la première utilisation, le système peut demander de choisir un éditeur de texte.

3. Ajouter une tâche cron

Pour exécuter automatiquement le script toutes les 30 minutes, ajoutez la ligne suivante dans la crontab :

*/30 * * * * /chemin/vers/Extracteur_Meteo.sh


Veillez à remplacer /chemin/vers/Extracteur_Meteo.sh par le chemin absolu du script sur votre machine.

Pour tester rapidement, vous pouvez également configurer le script pour s’exécuter toutes les minutes :

* * * * * /chemin/vers/Extracteur_Meteo.sh

4. Vérifier les tâches programmées

Pour afficher les tâches cron actuellement enregistrées, utilisez :

crontab -l

5. Format des tâches cron

Le format général d’une ligne dans la crontab est :

* * * * * commande_a_executer
| | | | |
| | | | └── Jour de la semaine (0 à 7)
| | | └──── Mois (1 à 12)
| | └────── Jour du mois (1 à 31)
| └──────── Heure (0 à 23)
└────────── Minutes (0 à 59)


Une fois la tâche cron ajoutée et le service actif, le script s'exécute automatiquement selon la fréquence définie et ajoute les nouvelles données au fichier de sortie.
