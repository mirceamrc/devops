#!/bin/bash

# Faceți un script ce dă restart la serviciul de sshd dacă este oprit. 
# Puneți scriptul in crontab sa ruleze la fiecare minut. 

if ! systemctl is-active --quiet sshd; then
    echo "Serviciul sshd este oprit. Se da restart!"
    systemctl restart sshd
else
    echo "Serviciul sshd este activ. Nicio actiune necesara."
fi
