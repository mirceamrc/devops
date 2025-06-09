#!/bin/bash

# Faceti un script cu numele config.sh ce face load în variabilele de mediu la variabilele 
# definite intr-un fisier config.txt ce arată în felul următor:

# DB_USER:admindb
# DB_PASS:12343dsadasdasFDTR!@13
# DB_HOSTNAME:my-db.com 
# DB_PORT:1234

# 1.	Cum facem ca variabilele setate automat în script să fie disponibile și în sesiunea de shell curentă?
#       Trebuie sa folosim source : source ./config.sh

# 2.	Cum facem ca variabilele să fie disponibile de fiecare dată când deschidem un terminal nou al userului curent?
#       Adaugam source config.sh in fisierul bashrc : echo "source git/devops/tema-bash/ex4/config.sh" >> ~/.bashrc

# 3.	Cum facem să le setam doar dacă nu sunt deja setate?
     

CONFIG_FILE="git/devops/tema-bash/ex4/config.txt"


if [ ! -f "$CONFIG_FILE" ]; then
    echo "Fisierul $CONFIG_FILE nu exista."
    exit 1
fi

echo "Incarcarea variabilelor din $CONFIG_FILE!"


while IFS=: read -r key value; do

    # Setam variabila doar daca nu e deja setata (BONUS 3)
     if [ -z "${!key}" ]; then
        export "$key=$value"
        echo "Am setat variabila: $key=$value"
    else
        echo "$key este deja setata cu valoarea $value"
    fi
done < "$CONFIG_FILE"