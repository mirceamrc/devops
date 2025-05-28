#! /bin/bash

read -p "Introdu calea catre un fisier: " argument
hash_argument=$(sha256sum $argument | awk '{print$1}')


for file in *.sh; do
	hash_fisier=$(sha256sum $file | awk '{print$1}')
	if [[ $hash_argument == $hash_fisier ]]; then
		echo "Am gasit fisierul $file identic"
		exit 0
	fi
done

echo "Nu am gasit niciun fisier!"
exit 1
