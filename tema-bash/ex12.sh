#!/bin/bash
# Adauga automat hasbang in fisierele de sh in care nu este prezent. 
# Scriptul verifica toate scripturile sh dintr-un director primit ca parametru.

if [ $# -ne 1 ]; then
    echo "Exemplu: $0 <cale_director>"
    exit 1
fi

DIRECTOR="$1"

if [ ! -d "$DIRECTOR" ]; then
    echo "Directorul $DIRECTOR nu exista!"
    exit 2
fi

for file in "$DIRECTOR"*.sh; do
   
    if [ -f "$file" ]; then
     
        first_line=$(head -n 1 "$file")

        if [[ "$first_line" != "#!"* ]]; then
            echo "Adaug shebang in $file"
            tmpfile=$(mktemp)
            echo "#!/bin/bash" > "$tmpfile"
            cat "$file" >> "$tmpfile"
            mv "$tmpfile" "$file"
            chmod +x "$file" 
        fi
    fi
done

echo "Scripturile au fost modificate."
