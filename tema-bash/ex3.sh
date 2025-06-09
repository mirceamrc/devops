#!/bin/bash

# Scrieți un script care verifica dacă un site este available (status code între 200 si 399). 
# Scriptul verifică de un număr maxim de ori primit tot ca argument.
# Hint: Comanda pentru a citi doar status code-ul este: 
# curl -o /dev/null -s -w "%{http_code}\n" https://example.com

# verificarea argumentelor
if [ $# -ne 2 ]; then
    echo "Scriptul asteapta doi parametri"
    echo "Exemplu: $0 URL NUMARUL_DE_INCECARI"
    exit 1
fi

url="$1"
max_incercari="$2"

# varificare parametru incercari sa fie pozitiv
if ! [[ "$max_incercari" =~ ^[0-9]+$ ]]; then
    echo "$2 trebuie sa fie un numar intreg pozitiv."
    exit 1
fi

echo "Incepe verificarea site-ul: $url (de maxim $max_incercari ori)"

for ((i=1; i<=max_incercari; i++)); do
    status_code=$(curl -o /dev/null -s -w "%{http_code}" "$url")

    echo "Incercarea $i: status code = $status_code"

    if [[ "$status_code" -ge 200 && "$status_code" -lt 400 ]]; then
        echo "Site-ul este disponibil!"
        exit 0
    fi

    sleep 1
done

echo "Site-ul NU este disponibil dupa $max_incercari incercari."
exit 1
