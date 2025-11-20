#!/bin/sh

#vérification nombre de paramètres
if [ $# -eq 0 ]
then
    ville="Toulouse"
elif [ $# -ne 1 ]
then
    echo "Usage : ./Extracteur_Meteo.sh <Ville>"
    exit 1
else
    ville=$1
fi

#exportation données brutes dans fichier .txt
curl -s wttr.in/$ville?format=j2 > local.txt
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de l'exportation des données brutes" >> meteo_error.log
    exit 1
fi

#récupération de la température actuelle
tempact=$(curl -s wttr.in/$ville?format="%t")
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville" >> meteo_error.log
    exit 1
fi

if [ "${tempact:0:1}" = "+" ]
then
    tempact=$(echo $tempact | cut -c 2-)
fi

#récupération de la température du lendemain
templen=$(head -n 103 local.txt | tail -n 1 | grep -oE "\-*[0-9]*")°C


#V1.4 formatage et ecriture dans meteo.txt
date_ajd=$(date +"%Y-%m-%d")
heure_ajd=$(date +"%H:%M")

#récupération de la vitesse du vent
vent=$(curl -s wttr.in/$ville?format="%w")
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de la récupération de la vitesse du vent" >> meteo_error.log
    exit 1
fi

#récupération du taux d'humidité
humidite=$(curl -s wttr.in/$ville?format="%h")
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de la récupération de l'humidité" >> meteo_error.log
    exit 1
fi

#récuperation de la visibilite
visibilite=$(head -n 17 local.txt | tail -n 1 | grep -oE "[0-9]*")

echo "$date_ajd - $heure_ajd - $ville : Température Actuelle=$tempact, Température Lendemain=$templen, Vent=$vent, Humidité=$humidite, Visibilité=$visibilite" >> meteo.txt

#gestion de l'historique
history_file="meteo_$(date +'%Y%m%d').txt"
echo "$date_ajd - $heure_ajd - $ville : Température Actuelle=$tempact, Température Lendemain=$templen, Vent=$vent, Humidité=$humidite, Visibilité=$visibilite" >> "$history_file"
