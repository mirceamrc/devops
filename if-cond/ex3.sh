#! /bin/bash

#Faceți un script de shell ce citește linie cu linie un fișier cu nume de utilizatori și pentru fiecare utilizator afișează grupurile în care acesta se afla.

cat utilizatori.txt | while read utilizator; do
	if [[ -z $utilizator ]]; then
		echo "Rand gol!"
		continue
	fi

	if ! id $utilizator &>/dev/null; then
		echo "Utilizatorul nu exista"
		continue
	fi

	echo "Utilizatorul $utilizator este in grumurile: "
	groups $utilizator
	
done
