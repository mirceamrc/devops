#!/bin/bash

# Faceți un script ce așteaptă (la nesfarsit) după un fisier pe disk sa fie creat (ce fișier doriti). 
# După ce fișierul a fost create scriptul afișează un mesaj și iese cu succes.

# Bonus (dificultate medie): Modificați scriptul să nu aștepte la nesfarsit ci maxim 1 minut. 
# Dar daca fisierul este create mai devreme de 1 minut scriptul trebuie sa se termine mai devreme.

if [ "$#" -ne 1 ]; then
	echo "Scriptul asteapta un paramteru"
	echo "Exemplu: $0 numele_fisierului.extensia"
	exit 1
fi


fisier=$1
timp_asteptare=60
i=0

echo "Astept dupa fisierul: $fisier (maxim $timp_asteptare de secunde)..."

while [ ! -f "$fisier" ]; do
    sleep 1
    ((i++))
    if [ "$i" -ge "$timp_asteptare" ]; then
        echo "Timpul a expirat. Fisierul nu a fost gasit."
        exit 1
    fi
done

echo "Fisierul a fost creat!"
exit 0
