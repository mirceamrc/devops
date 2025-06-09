#!/bin/bash

# Faceti un script de shell cu numele group-copy.sh ce copiaza userii dintr-un grup in altul.
# Scriptul primește 2 parametrii obligatorii și diferiți: grupul sursa și grupul destinatie (in ordinea aceasta). 


if [ $# -ne 2 ]; then
    echo "Trebuie sa specifici exact 2 parametri: grupul sursa si grupul destinatie"
    echo "Exemplu: $0 grup_sursa grup_destinatie"
    exit 1
fi

GRUP_SRC="$1"
GRUP_DEST="$2"

if [ "$GRUP_SRC" == "$GRUP_DEST" ]; then
    echo "Grupurile sursa si destinatie trebuie sa fie diferite."
    exit 1
fi

if ! cat /etc/group | grep -e "$GRUP_SRC:" > /dev/null; then
    echo "Grupul sursa '$GRUP_SRC' nu exista."
    exit 1
fi

if ! cat /etc/group | grep -e "$GRUP_DEST:" > /dev/null; then
    echo "Grupul destinatie '$GRUP_DEST' nu exista."
    exit 1
fi

USERI=$(cat /etc/group | grep -e "$GRUP_SRC:" | awk -F: '{print $4}' | tr ',' ' ')

if [ -z "$USERI" ]; then
    echo "Grupul '$GRUP_SRC' nu contine utilizatori."
    exit 0
fi

for user in $USERI; do
    if ! id "$user" &> /dev/null; then
        echo "Utilizatorul '$user' nu exista in sistem. Urmatorul..."
        continue
    fi

    if id -nG "$user" | grep -qw "$GRUP_DEST"; then
        echo "Utilizatorul '$user' este deja in grupul '$GRUP_DEST'."
    else
        sudo usermod -a -G "$GRUP_DEST" "$user"
        echo "Utilizatorul '$user' a fost adaugat in grupul '$GRUP_DEST'."
    fi
done
