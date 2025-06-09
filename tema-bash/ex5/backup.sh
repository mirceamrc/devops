#!/bin/bash

# Creați un script ce face backup la un fișier primit ca parametru printr-o variabila de mediu 
# cu numele  BACKUP_FILE_PATH, doar dacă fișierul a fost modificat. Cerințe:

# A.	Toate backup-urile sunt ținute într-un subdirector. Numele subdirectorului de backup este 
#       și el primit tot ca variabila de mediu (și are valoare implicită backup în caz că nu a fost setată).
# B.	Fiecare fișier de backup are un timestamp în nume.  
# C.	Dacă variabilă de mediu BACKUP_FILE_PATH nu a fost setată se afișează o eroare.
# D.	Dacă există deja un fișier de backup cu același conținut doar îl redenumim cu timestamp-ul curent  (nu mai facem încă un backup). 

# Hint: Comenzi utile:
# -	Folosiți comanda sha256sum pentru a verifica dacă un fișier a fost modificat.
# -	Folosiți următoarea comanda pentru a genera un date cu zi și oră:
# -	date +"%Y-%m-%d-%H-%M-%S"


if [ -z "$BACKUP_FILE_PATH" ]; then
    echo "Variabila de mediu BACKUP_FILE_PATH nu este setata."
    echo "Exemplu: export BACKUP_FILE_PATH="/cale/catre/fisier.txt""
    exit 1
fi

if [ ! -f "$BACKUP_FILE_PATH" ]; then
    echo "Fisierul '$BACKUP_FILE_PATH' nu a fost gasit."
    exit 1
fi

BACKUP_DIR="${BACKUP_DIR:-backup}"

mkdir -p "$BACKUP_DIR"

CURRENT_HASH=$(sha256sum "$BACKUP_FILE_PATH" | awk '{print $1}')

FILENAME=$(basename "$BACKUP_FILE_PATH")
TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/${FILENAME}_${TIMESTAMP}"

MATCHING_FILE=$(find "$BACKUP_DIR" -type f -name "${FILENAME}_*" -exec sha256sum {} \; | grep "$CURRENT_HASH" | awk '{print $2}' | head -n 1)

if [ -n "$MATCHING_FILE" ]; then
    mv "$MATCHING_FILE" "$BACKUP_FILE"
    echo "Fisierul de backup exista si a fost redenumit: $BACKUP_FILE"
else
    cp "$BACKUP_FILE_PATH" "$BACKUP_FILE"
    echo "Backup creat: $BACKUP_FILE"
fi
