#!/bin/sh

#vérification nombre de paramètres
if [ $# -ne 1 ]
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

echo "$date_ajd - $heure_ajd - $ville : $tempact - $templen" >> meteo.txt
