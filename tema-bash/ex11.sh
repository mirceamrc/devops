#!/bin/bash
# Log rotation: Faceți un script ce face log rotation la un fisier de loguri primit ca argument. 
# Pentru simplitate log rotation-ul se face automat la un numar de secunde primit ca argument. 
# Cand se face log rotation se copiază fișierul curent într-un nou fișier cu același nume ca 
# fișierul original + un timestamp iar fișierul original se golește. Fisierele de log rotation 
# se și arhivează pentru a ocupa mai puțin spațiu.
# Faceți un script simplu ce printeaza la nesfarsit in loguri pentru a testa scriptul de log 
# rotation (vedeti hello.sh de la curs). 

if [ $# -ne 2 ]; then
    echo "Exemplu: $0 cale_fisier_log interval_secunde"
    exit 1
fi

LOG_FILE="$1"
INTERVAL="$2"

if [ ! -f "$LOG_FILE" ]; then
    echo "Fisierul $LOG_FILE nu exista!"
    exit 2
fi

while true; do
    TIMESTAMP=$(date +"%Y-%m-%d-%H-%M-%S")
    ROTATED_FILE="${LOG_FILE}.${TIMESTAMP}"

    cp "$LOG_FILE" "$ROTATED_FILE"
    echo "" > "$LOG_FILE"

    gzip "$ROTATED_FILE"

    echo "Arhiva creata: ${ROTATED_FILE}.gz"

    sleep "$INTERVAL"
done
