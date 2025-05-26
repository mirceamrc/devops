#! /bin/bash

while true; do
	if pgrep hello &> /dev/null; then
		sleep 5
		echo "Scriptul inca ruleaza"
	else
		echo "Voi reporni hello.sh"
		nohup ./hello.sh &
	fi

done
