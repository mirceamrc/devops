#! /bin/bash

if [[ $# -ne 1 ]]; then
	echo "Scriptul asteapta nu argument"
	echo "$0 Gigi"
	exit 1
fi


if [ -z "$NUME_CURSANT" ]; then
	echo "Variabila nu exista"
	export NUME_CURSANT=$1
else
	echo "Exista"
fi


echo "Numele cursanutului este $NUME_CURSANT"

