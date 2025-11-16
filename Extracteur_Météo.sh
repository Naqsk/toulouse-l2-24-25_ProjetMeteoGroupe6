#!/bin/sh

#vérification nombre de paramètres
if [ $# -ne 1 ]
then
    echo "Usage : ./Extracteur_Meteo.sh <Ville>"
    exit 1
else
    ville=$1
fi
