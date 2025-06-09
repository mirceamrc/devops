#!/bin/bash

LOG_FILE="./tmp/mylog.log"
i=1

while true; do
    echo "$(date) - Mesaj de test $i" >> "$LOG_FILE"
    ((i++))
    sleep 2
done