#!/bin/bash

# Faceți un script ce compara dacă 2 fișiere (primite ca argument) sunt identice ca si continut. (sha256sum)

# verificare argumente
if [ "$#" -ne 2 ]; then
    echo "Scriptul asteapta doi parametri"
    echo "Exemplu: $0 fisier1 fisier2"
    exit 1
fi

fisier1="$1"
fisier2="$2"

# verificarea fisierelor daca exista
if [ ! -f "$fisier1" ] || [ ! -f "$fisier2" ]; then
    echo "Unul dintre fisiere nu exista."
    exit 1
fi

# extragem doar hash-urile
hash1=$(sha256sum "$fisier1" | awk '{print $1}')
hash2=$(sha256sum "$fisier2" | awk '{print $1}')

# comparam hash-urile
if [ "$hash1" = "$hash2" ]; then
    echo "Fisierele sunt identice."
    exit 0
else
    echo "Fisierele sunt diferite."
    exit 1
fi
