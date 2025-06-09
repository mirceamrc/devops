#!/bin/bash

# Faceți un script ce face backup la fiecare 5 secunde la un director (doar la fisierele 
# ce s-au modificat din acel director). Scriptul primește ca argument numele directorului 
# la care trebuie făcut backup. Frecvența la care se face backup este citită dintr-o variabila 
# de mediu cu numele FRECVENTA_BACKUP (cu valoare implicită de 5 secunde). 

# Hint: 
# -	Folosiți comanda sha256sum pentru a verifica dacă un fișier a fost modificat.


if [ -z "$1" ]; then
    echo "Trebuie să specifici un director ca argument."
    echo "Exemplu: $0 director"
    exit 1
fi

SOURCE_DIR="$1"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Directorul '$SOURCE_DIR' nu exista!"
    exit 1
fi

FRECVENTA_BACKUP="${FRECVENTA_BACKUP:-5}"

BACKUP_DIR="./backup_$(basename "$SOURCE_DIR")"
mkdir -p "$BACKUP_DIR"

HASH_FILE=".file_hashes.tmp"

find "$SOURCE_DIR" -type f | while read -r file; do
    sha256sum "$file"
done > "$HASH_FILE"

echo "Pornit backup din '$SOURCE_DIR' la fiecare $FRECVENTA_BACKUP secunde in '$BACKUP_DIR'"

while true; do
    sleep "$FRECVENTA_BACKUP"

    TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")

    find "$SOURCE_DIR" -type f | while read -r file; do
        NEW_HASH=$(sha256sum "$file")

        OLD_HASH=$(grep " $file\$" "$HASH_FILE")

        if [ "$NEW_HASH" != "$OLD_HASH" ]; then
            RELATIVE_PATH="${file#$SOURCE_DIR/}"
            DEST_PATH="$BACKUP_DIR/${RELATIVE_PATH}_$TIMESTAMP"

            mkdir -p "$(dirname "$DEST_PATH")"

            cp "$file" "$DEST_PATH"
            echo "Backup salvat pentru: $file -> $DEST_PATH"
        fi
    done

    find "$SOURCE_DIR" -type f | while read -r file; do
        sha256sum "$file"
    done > "$HASH_FILE"

done
