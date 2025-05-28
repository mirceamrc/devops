#! /bin/bash

cai=("/etc" "/var/log" "/tmp" "/work/ITSchool")

for cale in ${cai[@]}; do
	echo "Calea este: $cale"
	if [ ! -d "$cale" ]; then
		echo "Folderul nu exista!"
		continue
	fi
	echo  "In folder sunt:  $(ls -la $cale | wc -l) fisiere"
done
