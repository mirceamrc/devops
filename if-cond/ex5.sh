#! /bin/bash

cursanti=(Alice Bob Charlie Dan)

echo "Avem ${#cursanti[@]} cursanti"
for cursant in ${cursanti[@]};do
	echo "Nume cursant: $cursant"
done
