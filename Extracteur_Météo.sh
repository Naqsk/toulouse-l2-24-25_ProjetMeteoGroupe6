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
