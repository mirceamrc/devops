#!/bin/bash

# Faceți un script de shell numit group-list.sh ce imi afiseaza toți userii ce se afla într-un 
# grup separati prin spațiu. Scriptul primește ca argument obligatoriu numele grupului. Dacă 
# nu este niciun user în grup nu afișează nimic.

# Hint: folositi o comanda similară cu aceasta: 
# cat /etc/group | grep -e "sudo:" | awk -F':' '{print $4}' | tr ',' ' '

GRUP="$1"

if [ -z "$GRUP" ]; then
    echo "Trebuie sa specifici un nume de grup."
    echo "Exemplu: $0 sudo sau $0 tech"
    exit 1
fi

USERI=$(cat /etc/group | grep -e "$GRUP:" | awk -F':' '{print $4}' | tr ',' ' ')

if [ -n "$USERI" ]; then
    echo "$USERI"
else
    echo "Grupul nu are utilizatori sau nu exista"
fi
